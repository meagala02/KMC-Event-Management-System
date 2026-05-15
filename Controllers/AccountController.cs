using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;
using System.Web.Mvc;
using KMC_API.Models;
using System.Data.Entity;

namespace KMC_API.Controllers
{
    [System.Web.Http.RoutePrefix("api/account")]
    public class AccountController : ApiController
    {
        private KMCContext db = new KMCContext();

        
        [System.Web.Http.HttpPost]
        [System.Web.Http.Route("register")]
        public IHttpActionResult Register(User user)
        {
            if (db.Users.Any(u => u.Email == user.Email))
                return BadRequest("Email already exists!");

            if (user.Role == "General Public")
            {
                user.Role = "Participant";
            }

            try
            {
                db.Users.Add(user);
                db.SaveChanges(); 
                return Ok(new { Message = "Registration Successful" });
            }
            catch (Exception ex)
            {
                return InternalServerError(ex);
            }
        }

        [System.Web.Http.HttpPost]
        [System.Web.Http.Route("login")]
        public IHttpActionResult Login(User login)
        {
            var user = db.Users.FirstOrDefault(u => u.Email == login.Email && u.Password == login.Password);

            if (user == null)
                return Unauthorized();

            
            return Ok(new
            {
                UserId = user.UserId,
                FullName = user.FullName,
                Role = user.Role
            });
        }
    }
}