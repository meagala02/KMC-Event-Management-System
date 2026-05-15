using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using System.Linq;
using System.Text;

namespace KMC_ClientApp
{
    public partial class Events : System.Web.UI.Page
    {
        private string apiBase = "https://localhost:44314/api/events";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadEventsList("", "");
            }
        }

        private void LoadEventsList(string type, string date)
        {
            string url = $"{apiBase}/search?type={type}&date={date}";
            using (HttpClient client = new HttpClient())
            {
                try
                {
                    var response = client.GetAsync(url).Result;
                    if (response.IsSuccessStatusCode)
                    {
                        var json = response.Content.ReadAsStringAsync().Result;
                        var events = JsonConvert.DeserializeObject<List<dynamic>>(json);
                        rptEvents.DataSource = events;
                        rptEvents.DataBind();
                        phNoData.Visible = (events == null || events.Count == 0);
                    }
                }
                catch (Exception) { phNoData.Visible = true; }
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadEventsList(ddlTypeSearch.SelectedValue, txtDateSearch.Text);
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (Session["UserId"] == null) { Response.Redirect("Login.aspx"); return; }

            string eventIdStr = ((Button)sender).CommandArgument;
            var registrationData = new
            {
                UserId = Convert.ToInt32(Session["UserId"]),
                EventId = Convert.ToInt32(eventIdStr)
              
            };

            using (HttpClient client = new HttpClient())
            {
                var json = JsonConvert.SerializeObject(registrationData);
                var content = new StringContent(json, Encoding.UTF8, "application/json");
                var response = client.PostAsync($"{apiBase}/register", content).Result;

                if (response.IsSuccessStatusCode)
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Event Booked Successfully!');", true);
                else
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Booking Failed! Maybe you already booked?');", true);
            }
        }

      
        protected void btnCancel_Click(object sender, EventArgs e)
        {
            if (Session["UserId"] == null) return;

            string eventId = ((Button)sender).CommandArgument;
            string userId = Session["UserId"].ToString();

            using (HttpClient client = new HttpClient())
            {
                
                var response = client.PutAsync($"{apiBase}/cancel-registration/{eventId}/{userId}", null).Result;

                if (response.IsSuccessStatusCode)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Booking Cancelled Successfully!');", true);
                    LoadEventsList("", ""); 
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Cancel Failed! No active booking found.');", true);
                }
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            if (Session["UserId"] == null) return;
            string eventId = ((LinkButton)sender).CommandArgument;
            string userId = Session["UserId"].ToString();

            using (HttpClient client = new HttpClient())
            {
                var response = client.DeleteAsync($"{apiBase}/delete/{eventId}/{userId}").Result;
                if (response.IsSuccessStatusCode) LoadEventsList("", "");
            }
        }
    }
}