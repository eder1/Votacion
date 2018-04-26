using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Democracy.Models;
using CrystalDecisions.CrystalReports.Engine;
using System.Configuration;
using System.Data.SqlClient;

namespace Democracy.Controllers
{
    public class VotingsController : Controller
    {
        private DemocracryContext db = new DemocracryContext();

        [Authorize(Roles = "Admin")]
        public ActionResult Closed(int id)
        {
            var voting = db.Votings.Find(id);
            if(voting != null)
            {
                var candidate = db.Candidates.Where(v => v.VotingId == voting.VotingId)
                                .OrderByDescending(c => c.QuantityVotes).FirstOrDefault();

                if (candidate != null)
                {
                    var state = this.GetState("Closed");
                    voting.StateId = state.StateId;
                    voting.CandidateWinId = candidate.User.UserId;
                    db.Entry(voting).State = EntityState.Modified;
                    db.SaveChanges();
                }
            }
            return RedirectToAction("Index");
        }

        public ActionResult ShowResults(int id)
        {
            var report = this.GenerateUserReport(id);
            var stream = report.ExportToStream(CrystalDecisions.
                                Shared.ExportFormatType.WordForWindows);
            return File(stream, "aplication/doc","Results.doc");
        }

        private ReportClass GenerateUserReport(int id)
        {

            var connectionString = ConfigurationManager.
                                ConnectionStrings["DefaultConnection"].ConnectionString;
            var connection = new SqlConnection(connectionString);
            var dataTable = new DataTable();
            var sql = @"SELECT Votings.VotingId, Votings.Descripcion AS Voting, States.Descripcion AS State, 
                                Users.FirstName + ' ' + Users.LastName AS Candidate, Candidates.QuantityVotes
                      FROM Users INNER JOIN Candidates ON Users.UserId = Candidates.UserId INNER JOIN
                                            Votings ON Candidates.VotingId = Votings.VotingId INNER JOIN
                                            States ON Votings.StateId = States.StateId
                                            where Votings.VotingId = "+id;
            try
            {
                connection.Open();
                var command = new SqlCommand(sql, connection);
                var adapter = new SqlDataAdapter(command);
                adapter.Fill(dataTable);
            }
            catch (Exception ex)
            {
                ex.ToString();
            }

            var report = new ReportClass();
            report.FileName = Server.MapPath("/Report/Results.rpt");
            report.Load();
            report.SetDataSource(dataTable);
            return report;
        }

        [Authorize(Roles = "User,Admin")]
        public ActionResult Results()
        {
            var state = this.GetState("Closed");
            var votings = db.Votings.Where(v => v.StateId == state.StateId)
                                    .Include(v =>v.State);
            var views = new List<VotingIndexView>();
            var bd2 = new DemocracryContext();

            foreach (var voting in votings)
            {
                User user = null;
                if (voting.CandidateWinId != 0)
                {
                    user = db.Users.Find(voting.CandidateWinId);
                }

                views.Add(new VotingIndexView
                {
                    CandidateWinId = voting.CandidateWinId,
                    DateTimeEnd = voting.DateTimeEnd,
                    DateTimeStart = voting.DateTimeStart,
                    Descripcion = voting.Descripcion,
                    IsEnabledBlankVote = voting.IsEnabledBlankVote,
                    IsForAllUsers = voting.IsForAllUsers,
                    QuantityBlankVotes = voting.QuantityBlankVotes,
                    Remarks = voting.Remarks,
                    StateId = voting.StateId,
                    State = voting.State,
                    VotingId = voting.VotingId,
                    Winner = user
                });
            }
            return View(views);
        }

        [Authorize(Roles = "User,Admin")]
        public ActionResult VoteForCandidate(int candidateId, int votingId)
        {
            var user = db.Users.Where(u => u.UserName == this.User.Identity.Name).FirstOrDefault();
            if (user == null)
            {
                return RedirectToAction("Index","Home");
            }

            var candidate = db.Candidates.Find(candidateId);
            if (candidate == null)
            {
                return RedirectToAction("Index", "Home");
            }

            var voting = db.Votings.Find(votingId);
            if (voting == null)
            {
                return RedirectToAction("Index", "Home");
            }

            if (this.VoteCandidate(user,candidate,voting))
            {
                return RedirectToAction("MyVotings");
            }
            return RedirectToAction("Index", "Home");
        }

        private bool VoteCandidate(User user, Candidate candidate, Voting voting)
        {
            using (var transation = db.Database.BeginTransaction())
            {
                var votingDetail = new VotingDetail
                {
                    CandidateId = candidate.CandidateId,
                    DateTime = DateTime.Now,
                    UserId = user.UserId,
                    VotingId = voting.VotingId
                };
                db.VotingDetails.Add(votingDetail);

                candidate.QuantityVotes++;
                db.Entry(candidate).State = EntityState.Modified;

                voting.QuantityVotes++;
                db.Entry(voting).State = EntityState.Modified;

                try
                {
                    db.SaveChanges();
                    transation.Commit();
                    return true;
                }
                catch(Exception ex)
                {
                    transation.Rollback();
                    ModelState.AddModelError(string.Empty, ex.Message);
                }
            }

            return false;
        }

        [Authorize(Roles = "User,Admin")]
        public ActionResult Vote(int votingId)
        {
            var voting = db.Votings.Find(votingId);
            var view = new VotingVoteView
            {
                MyCandidates = voting.Candidates.ToList(),
                DateTimeEnd = voting.DateTimeEnd,
                DateTimeStart = voting.DateTimeStart,
                Descripcion = voting.Descripcion,
                IsEnabledBlankVote = voting.IsEnabledBlankVote,
                IsForAllUsers = voting.IsForAllUsers,
                Remarks = voting.Remarks,
                VotingId = voting.VotingId

            };
            return View(view);
        }


        [Authorize(Roles = "User,Admin")]
        public ActionResult MyVotings()
        {
            var user = db.Users.Where(u => u.UserName == this.User.Identity.Name).FirstOrDefault();
            if (user == null)
            {
                ModelState.AddModelError(string.Empty,"There is an error with the current, call the support");
                return View();
            }

            //if state not exists, then created 
            var state = this.GetState("Opened");
            //get event voting for the correct time
            var votings = db.Votings.Where(u =>u.StateId == state.StateId &&
                            u.DateTimeStart <= DateTime.Now 
                            && u.DateTimeEnd >= DateTime.Now)
                            .Include(v =>v.Candidates)
                            .Include(v =>v.VotingGroup)
                            .Include(v =>v.State).ToList();

            //discard events in the witch the user already vote           
            foreach (var voting in votings.ToList())
            {
                var votingDetail = db.VotingDetails
                                    .Where(v => v.VotingId == voting.VotingId &&
                                        v.UserId == user.UserId).FirstOrDefault();

                if (votingDetail != null)
                {
                    votings.Remove(voting);
                }

            }

            //discard events by groups in witch the user are not included
            foreach (var voting in votings.ToList())
            {
                if (!voting.IsForAllUsers)
                {
                    bool userBelongToGroup = false;

                    foreach (var votingGroup in voting.VotingGroup)
                    {
                        var userGroup = votingGroup.Group.GroupMember
                            .Where(v => v.UserId == user.UserId).FirstOrDefault();

                        if (userGroup != null)
                        {
                            userBelongToGroup = true;
                            break;
                        }
                    }

                    if (!userBelongToGroup)
                    {
                        votings.Remove(voting);
                    }
                }
            }
           
            return View(votings);
        }

        private State GetState(string stateName)
        {
            var state = db.States.Where(u => u.Descripcion == stateName).FirstOrDefault();
            if (state == null)
            {
                state = new State
                {
                    Descripcion = stateName
                };
                db.States.Add(state);
                db.SaveChanges();             
            }
            return state;
        }

        [Authorize(Roles = "Admin")]
        [HttpGet]
        public ActionResult DeleteGroup(int id)
        {
            var votingGroup = db.VotingGroups.Find(id);
            if (votingGroup != null)
            {
                db.VotingGroups.Remove(votingGroup);
                db.SaveChanges();
            }

            return RedirectToAction(string.Format("Details/{0}", votingGroup.VotingId));
        }

        [HttpGet]
        [Authorize(Roles = "Admin")]
        public ActionResult DeleteCandidate(int id)
        {
            var candidate = db.Candidates.Find(id);
            if (candidate != null)
            {
                db.Candidates.Remove(candidate);
                db.SaveChanges();
            }

            return RedirectToAction(string.Format("Details/{0}", candidate.VotingId));
        }
        [HttpPost]
        public ActionResult AddCandidate(AddCandidateView view)
        {
            if (ModelState.IsValid)
            {
                var candidate = db.Candidates
                                    .Where(c => c.VotingId == view.VotingId &&
                                            c.UserId == view.UserId)
                                     .FirstOrDefault();
                if (candidate != null)
                {
                    ModelState.AddModelError(string.Empty, "The candidate already belongs to voting");
                    ViewBag.UserId = new SelectList(db.Users.OrderBy(u => u.FirstName)
                               .ThenBy(u => u.LastName)
                                , "UserId", "FullName");
                    return View(view);
                }

                candidate = new Candidate
                {
                    UserId = view.UserId,
                    VotingId = view.VotingId
                };

                db.Candidates.Add(candidate);
                db.SaveChanges();
                return RedirectToAction(string.Format("Details/{0}", view.VotingId));
            }

            ViewBag.UserId = new SelectList(db.Users.OrderBy(u => u.FirstName)
                                .ThenBy(u => u.LastName)
                                 , "UserId", "FullName");
            return View(view);
        }
        [HttpGet]
        [Authorize(Roles = "Admin")]
        public ActionResult AddCandidate(int id)
        {
            var view = new AddCandidateView
            {
                VotingId = id,

            };

            ViewBag.UserId = new SelectList(db.Users.OrderBy(u => u.FirstName)
              .ThenBy(u => u.LastName)
              , "UserId", "FullName");
            return View(view);
        }

        [HttpPost]
        public ActionResult AddGroup(AddGroupView view)
        {
            if (ModelState.IsValid)
            {
                var votingGroup = db.VotingGroups
                                    .Where(vg => vg.VotingId == view.VotingId &&
                                            vg.GroupId == view.GroupId)
                                     .FirstOrDefault();
                if (votingGroup != null)
                {
                    ModelState.AddModelError(string.Empty, "The group already belongs to voting");
                    ViewBag.GroupId = new SelectList(db.Groups.OrderBy(g => g.Descripcion),
                                                          "GroupId", "Descripcion");
                    return View(view);
                }

                votingGroup = new VotingGroup
                {
                    GroupId = view.GroupId,
                    VotingId = view.VotingId
                };

                db.VotingGroups.Add(votingGroup);
                db.SaveChanges();
                return RedirectToAction(string.Format("Details/{0}", view.VotingId));
            }

            ViewBag.GroupId = new SelectList(
                db.Groups.OrderBy(g => g.Descripcion), "GroupId", "Descripcion");
            return View(view);
        }

        // GET: Votings
        [Authorize(Roles = "Admin")]
        public ActionResult AddGroup(int id)
        {
            ViewBag.GroupId = new SelectList(
                db.Groups.OrderBy(g => g.Descripcion), "GroupId", "Descripcion");

            var view = new AddGroupView
            {

                VotingId = id
            };
            return View(view);
        }

        [Authorize(Roles = "Admin")]
        public ActionResult Index()
        {
            var votings = db.Votings.Include(v => v.State);
            var views = new List<VotingIndexView>();
            var db2 =  new DemocracryContext();
            foreach (var voting in votings)
            {
                User user = null;
                if (voting.CandidateWinId != 0)
                {
                    user = db2.Users.Find(voting.CandidateWinId);
                }

                views.Add(new VotingIndexView
                {
                    CandidateWinId = voting.CandidateWinId,
                    DateTimeEnd = voting.DateTimeEnd,
                    DateTimeStart = voting.DateTimeStart,
                    Descripcion = voting.Descripcion,
                    IsEnabledBlankVote = voting.IsEnabledBlankVote,
                    IsForAllUsers = voting.IsForAllUsers,
                    QuantityBlankVotes = voting.QuantityBlankVotes,
                    Remarks = voting.Remarks,
                    StateId = voting.StateId,
                    State = voting.State,
                    VotingId = voting.VotingId,
                    Winner = user
                });
            }
            return View(views);
        }

        [Authorize(Roles = "Admin")]
        // GET: Votings/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            var voting = db.Votings.Find(id);
            if (voting == null)
            {
                return HttpNotFound();
            }

            var view = new DetailsVotingView
            {
                VotingId = voting.VotingId,
                CandidateWinId = voting.CandidateWinId,
                DateTimeEnd = voting.DateTimeEnd,
                DateTimeStart = voting.DateTimeStart,
                Descripcion = voting.Descripcion,
                IsEnabledBlankVote = voting.IsEnabledBlankVote,
                IsForAllUsers = voting.IsForAllUsers,
                QuantityBlankVotes = voting.QuantityBlankVotes,
                QuantityVotes = voting.QuantityVotes,
                Remarks = voting.Remarks,
                StateId = voting.StateId,
                VotingGroups = voting.VotingGroup.ToList(),
                Candidates = voting.Candidates.ToList()

            };
            return View(view);
        }

        // GET: Votings/Create
        [Authorize(Roles = "Admin")]
        public ActionResult Create()
        {
            ViewBag.StateId = new SelectList(db.States, "StateId", "Descripcion");
            var view = new VotingView
            {
                DateStart = DateTime.Now,
                DateEnd = DateTime.Now
            };
            return View(view);
        }

        // POST: Votings/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(VotingView view)
        {
            if (ModelState.IsValid)
            {
                var voting = new Voting
                {                    
                    DateTimeStart = view.DateStart.AddHours(view.TimeStart.Hour)
                                    .AddMinutes(view.TimeStart.Minute),
                    DateTimeEnd = view.DateEnd.AddHours(view.TimeEnd.Hour)
                                    .AddMinutes(view.TimeEnd.Minute),
                    Descripcion = view.Descripcion,
                    IsEnabledBlankVote = view.IsEnabledBlankVote,
                    IsForAllUsers = view.IsForAllUsers,
                    Remarks = view.Remarks,
                    StateId = view.StateId
                };
                db.Votings.Add(voting);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.StateId = new SelectList(db.States, "StateId", "Descripcion", view.StateId);
            return View(view);
        }

        // GET: Votings/Edit/5
        [Authorize(Roles = "Admin")]
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Voting voting = db.Votings.Find(id);
            if (voting == null)
            {
                return HttpNotFound();
            }

            var view = new VotingView
            {
                DateEnd = voting.DateTimeEnd,
                DateStart = voting.DateTimeStart,
                Descripcion = voting.Descripcion,
                IsEnabledBlankVote = voting.IsEnabledBlankVote,
                IsForAllUsers = voting.IsForAllUsers,
                Remarks = voting.Remarks,
                StateId = voting.StateId,
                TimeEnd = voting.DateTimeEnd,
                TimeStart = voting.DateTimeStart,
                VotingId = voting.VotingId
            };
            ViewBag.StateId = new SelectList(db.States, "StateId", "Descripcion", voting.StateId);
            return View(view);
        }

        // POST: Votings/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(VotingView view)
        {
            if (ModelState.IsValid)
            {
                var voting = new Voting
                {
                    DateTimeEnd = view.DateEnd.AddHours(view.TimeEnd.Hour)
                                    .AddMinutes(view.TimeEnd.Minute),
                    DateTimeStart = view.DateStart.AddHours(view.TimeStart.Hour)
                                    .AddMinutes(view.TimeStart.Minute),
                    Descripcion = view.Descripcion,
                    IsEnabledBlankVote = view.IsEnabledBlankVote,
                    IsForAllUsers = view.IsForAllUsers,
                    Remarks = view.Remarks,
                    StateId = view.StateId,
                    VotingId = view.VotingId
                };
             
                db.Entry(voting).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.StateId = new SelectList(db.States, "StateId", "Descripcion", view.StateId);
            return View(view);
        }

        // GET: Votings/Delete/5
        [Authorize(Roles = "Admin")]
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Voting voting = db.Votings.Find(id);
            if (voting == null)
            {
                return HttpNotFound();
            }
            return View(voting);
        }

        // POST: Votings/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Voting voting = db.Votings.Find(id);
            db.Votings.Remove(voting);
            try
            {
                db.SaveChanges();

            }
            catch (Exception ex)
            {
                if (ex.InnerException != null && ex.InnerException.InnerException != null &&
                    ex.InnerException.InnerException.Message.Contains("REFERENCE"))
                {

                    ViewBag.Error = "Can't delete the record, because has related record";
                }
                else
                {
                    ViewBag.Error = ex.Message;
                }

                return View(id);
            }
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
