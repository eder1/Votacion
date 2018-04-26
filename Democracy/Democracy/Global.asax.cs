using Democracy.Migrations;
using Democracy.Models;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Http;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;

namespace Democracy
{
    public class MvcApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {

            Database.SetInitializer(new MigrateDatabaseToLatestVersion<DemocracryContext, 
                Configuration>());
            this.CheckSuperuser();
            AreaRegistration.RegisterAllAreas();
            GlobalConfiguration.Configure(WebApiConfig.Register);
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
        }

        private void CheckSuperuser()
        {
            var userContext = new ApplicationDbContext();
            var userManager = new UserManager<ApplicationUser>(
                                 new UserStore<ApplicationUser>(userContext));
            var db = new DemocracryContext();

            this.CheckRole("Admin", userContext);
            this.CheckRole("User", userContext);

            var user = db.Users.
                        Where(u => u.UserName.ToLower()
                        .Equals("martinez@gmail.com")).FirstOrDefault();

            if(user == null)
            {
                user = new User
                {
                    Address = "Av Jose Pardo",
                    FirstName = "Ed",
                    LastName = "Edjo",
                    Phone = "910038294",
                    UserName = "martinez@gmail.com",
                    Photo = "~/Content/Photos/NENA.jpg"
                };
                db.Users.Add(user);
                db.SaveChanges();
            }
            var userASP = userManager.FindByName(user.UserName);
            if(userASP == null)
            {
                // create the ASP NET user 
                userASP = new ApplicationUser
                {
                    UserName = user.UserName,
                    Email = user.UserName,
                    PhoneNumber = user.Phone
                };
                userManager.Create(userASP, "12345678");    
            }

            userManager.AddToRole(userASP.Id, "Admin");
        }

        private void CheckRole(string roleName, ApplicationDbContext userContext)
        {
            var roleManager = new RoleManager<IdentityRole>(
                                new RoleStore<IdentityRole>(userContext));


            //check to see if role exists, if not create it 
            if (!roleManager.RoleExists(roleName))
            {
                roleManager.Create(new IdentityRole(roleName));
            }
        }
    }
}
