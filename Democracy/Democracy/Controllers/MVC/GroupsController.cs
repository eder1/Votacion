using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Democracy.Models;

namespace Democracy.Controllers
{
    [Authorize(Roles = "Admin")]
    public class GroupsController : Controller
    {
        private DemocracryContext db = new DemocracryContext();

        [HttpGet]
        public ActionResult Index()
        {
            return View(db.Groups.ToList());
        }

        [HttpGet]
        public ActionResult Create()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "GroupId,Descripcion")] Group group)
        {
            if (ModelState.IsValid)
            {
                db.Groups.Add(group);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(group);
        }

        public ActionResult DeleteMember(int id)
        {
            var member = db.GroupMembers.Find(id);
            if (member != null)
            {
                db.GroupMembers.Remove(member);
                db.SaveChanges();
            }
            if (member == null)
            {
                return HttpNotFound();
            }
            //revisar esta linea
            //return HttpNotFound();
            return RedirectToAction(string.Format("Details/{0}", member.GroupId));
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult AddMember(AddMemberView view)
        {
            if (!ModelState.IsValid)
            {
                ViewBag.UserId = new SelectList(db.Users.OrderBy(u => u.FirstName)
               .ThenBy(u => u.LastName)
               , "UserId", "FullName");
                return View(view);
            }

            var member = db.GroupMembers.
                Where(gm => gm.GroupId == view.GrupoId && gm.UserId == view.UserId).FirstOrDefault();

            if (member != null)
            {
                ViewBag.UserId = new SelectList(db.Users.OrderBy(u => u.FirstName)
              .ThenBy(u => u.LastName)
              , "UserId", "FullName");
                ViewBag.Error = "The member already belongs to group";
                return View(view);
            }

            member = new GroupMember
            {
                GroupId = view.GrupoId,
                UserId = view.UserId
            };

            db.GroupMembers.Add(member);
            db.SaveChanges();
            return RedirectToAction(string.Format("Details/{0}", member.GroupId));
        }

        [HttpGet]
        public ActionResult AddMember(int groupId)
        {
            ViewBag.UserId = new SelectList(db.Users.OrderBy(u => u.FirstName)
                .ThenBy(u => u.LastName)
                , "UserId", "FullName");
            var view = new AddMemberView
            {
                GrupoId = groupId
            };
            return View(view);
        }

        // GET: Groups/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            var group = db.Groups.Find(id);
            if (group == null)
            {
                return HttpNotFound();
            }

            var view = new GroupDetailsView
            {
                GroupId = group.GroupId,
                Description = group.Descripcion,
                Members = group.GroupMember.ToList()
            };
            return View(view);
        }



        [HttpGet]
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            var group = db.Groups.Find(id);
            if (group == null)
            {
                return HttpNotFound();
            }
            return View(group);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(Group group)
        {
            if (ModelState.IsValid)
            {
                db.Entry(group).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(group);
        }

        [HttpGet]
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            var group = db.Groups.Find(id);
            if (group == null)
            {
                return HttpNotFound();
            }
            return View(group);
        }

        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            var group = db.Groups.Find(id);
            db.Groups.Remove(group);
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

                return View(group);
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
