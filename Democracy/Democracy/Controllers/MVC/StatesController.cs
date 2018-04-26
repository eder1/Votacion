﻿using Democracy.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;

namespace Democracy.Controllers
{    
    [Authorize(Roles ="Admin")]    
    public class StatesController : Controller
    {
        //the data - base connection
        private DemocracryContext db = new DemocracryContext();

        //List all states
        [HttpGet]
        public ActionResult Index()
        {
            return View(db.States.ToList());
        }
        [HttpGet]
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            var state = db.States.Find(id);
            if (state == null)
            {
                return HttpNotFound();
            }
            return View(state);
        }

        [HttpGet]
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            var state = db.States.Find(id);
            if (state == null)
            {
                return HttpNotFound();
            }
            return View(state);
        }

        [HttpGet]
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            var state = db.States.Find(id);
            if (state == null)
            {
                return HttpNotFound();
            }
            return View(state);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Delete(int id, State state)
        {
            state = db.States.Find(id);
            if (state == null)
            {
                return HttpNotFound();
            }
        
            db.States.Remove(state);
            try
            {
                db.SaveChanges();

            }
            catch (Exception ex)
            {
                if(ex.InnerException != null && ex.InnerException.InnerException != null &&
                    ex.InnerException.InnerException.Message.Contains("REFERENCE"))
                {

                    ViewBag.Error = "Can't delete the record, because has related record";
                }
                else
                {
                    ViewBag.Error = ex.Message;
                }

                return View(state);
            }
            return RedirectToAction("Index");
        }

        [HttpPost]
        public ActionResult Edit(State state)
        {
            if (!ModelState.IsValid)
            {
                return View(state);
            }
            db.Entry(state).State = EntityState.Modified;
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        [HttpGet]
        public ActionResult Create()
        {
            return View();

        }

        [HttpPost]
        public ActionResult Create(State state)
        {
            if (!ModelState.IsValid)
            {
                return View(state);
            }
            db.States.Add(state);
            db.SaveChanges();
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