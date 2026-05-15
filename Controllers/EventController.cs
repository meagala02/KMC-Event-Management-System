using System;
using System.Collections.Generic;
using System.Web.Http;
using KMC_API.Models;
using KMC_API.Services;

namespace KMC_API.Controllers
{
    [RoutePrefix("api/events")]
    public class EventController : ApiController
    {
        private EventService service = new EventService();

        [HttpGet]
        [Route("search")]
        public IHttpActionResult Search(string type = null, string date = null)
        {
            try
            {
                if (type == "All" || type == "") type = null;
                var results = service.SearchEvents(type, date);
                return Ok(results);
            }
            catch (Exception ex) { return InternalServerError(ex); }
        }

        [HttpPost]
        [Route("add")]
        public IHttpActionResult Add(Event ev)
        {
            if (ev == null) return BadRequest("Invalid event data");
            if (service.CreateEvent(ev)) return Ok("Event Created Successfully");
            return BadRequest("Error creating event");
        }

        [HttpPost]
        [Route("register")]
        public IHttpActionResult Register(Registration reg)
        {
            if (reg == null) return BadRequest("Invalid registration data");
            if (service.RegisterParticipant(reg)) return Ok("Registered Successfully");
            return BadRequest("Registration Failed");
        }

        
        [HttpPut]
        [Route("cancel-registration/{eventId}/{userId}")]
        public IHttpActionResult CancelReg(int eventId, int userId)
        {
            if (service.CancelRegistration(eventId, userId))
                return Ok("Booking Cancelled Successfully");

            return BadRequest("Cancellation Failed or No active booking found");
        }

        [HttpPut]
        [Route("update/{userId}")]
        public IHttpActionResult Update(int userId, Event ev)
        {
            if (ev == null) return BadRequest("Invalid data");
            if (service.UpdateEvent(ev, userId)) return Ok("Updated Successfully");
            return BadRequest("Not Authorized");
        }

        [HttpDelete]
        [Route("delete/{eventId}/{userId}")]
        public IHttpActionResult Delete(int eventId, int userId)
        {
            if (service.DeleteEvent(eventId, userId)) return Ok("Event Deleted Successfully");
            return BadRequest("Not Authorized");
        }
    }
}