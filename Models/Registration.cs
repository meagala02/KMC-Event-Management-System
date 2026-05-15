using System;
using System.ComponentModel.DataAnnotations;

namespace KMC_API.Models
{
    public class Registration
    {
        [Key]
        public int RegId { get; set; }
        public int UserId { get; set; }
        public int EventId { get; set; }
        public DateTime RegDate { get; set; }
        public string Status { get; set; } 
    }
}