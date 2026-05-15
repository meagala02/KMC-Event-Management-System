using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace KMC_API.Models
{
    public class Event
    { [Key]
        public int EventId { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public DateTime EventDate { get; set; }
        public string Location { get; set; }
        public string EventType { get; set; }
        public string ImageUrl { get; set; }
        public int OrganizerId { get; set; } 
    }
}