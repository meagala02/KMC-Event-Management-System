using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity;
using KMC_API.Models;

public class KMCContext : DbContext
{
    public KMCContext() : base("name=KMCConn") { }
    public DbSet<User> Users { get; set; }
    public DbSet<Event> Events { get; set; }
    public DbSet<Registration> Registrations { get; set; }
}