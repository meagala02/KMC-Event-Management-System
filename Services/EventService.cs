using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using KMC_API.Models;
using System.Data.Entity;

namespace KMC_API.Services
{
    public class EventService
    {
        private KMCContext db = new KMCContext();

        public List<Event> SearchEvents(string type, string date)
        {
            var query = db.Events.AsQueryable();
            if (!string.IsNullOrEmpty(type)) query = query.Where(e => e.EventType == type);
            if (!string.IsNullOrEmpty(date))
            {
                var d = System.DateTime.Parse(date);
                query = query.Where(e => DbFunctions.TruncateTime(e.EventDate) == d.Date);
            }
            return query.ToList();
        }

        public bool CreateEvent(Event ev)
        {
            db.Events.Add(ev);
            return db.SaveChanges() > 0;
        }

        
        public bool UpdateEvent(Event ev, int currentUserId)
        {
            var existing = db.Events.Find(ev.EventId);

            if (existing != null)
            {
                
                if (existing.OrganizerId == currentUserId)
                {
                    
                    ev.OrganizerId = existing.OrganizerId;

                    
                    db.Entry(existing).CurrentValues.SetValues(ev);
                    return db.SaveChanges() > 0;
                }
            }
            return false;
        }

        public bool DeleteEvent(int eventId, int userId)
        {
            var existing = db.Events.Find(eventId);
            if (existing != null && existing.OrganizerId == userId)
            {
                db.Events.Remove(existing);
                return db.SaveChanges() > 0;
            }
            return false;
        }

        public bool RegisterParticipant(Registration reg)
        {
            reg.RegDate = DateTime.Now;
            reg.Status = "Booked";
            db.Registrations.Add(reg);
            return db.SaveChanges() > 0;
        }

        public bool CancelRegistration(int eventId, int userId)
        {
            var booking = db.Registrations.FirstOrDefault(r => r.EventId == eventId && r.UserId == userId && r.Status == "Booked");
            if (booking != null)
            {
                booking.Status = "Cancelled";
                return db.SaveChanges() > 0;
            }
            return false;
        }
    }
}