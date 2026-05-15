using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using Newtonsoft.Json;
using System.Text;
using System.IO;
using System.Web.UI;

namespace KMC_ClientApp
{
    public partial class EditEvent : System.Web.UI.Page
    {
        private string apiBase = "https://localhost:44314/api/events";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string eventId = Request.QueryString["id"];
                if (!string.IsNullOrEmpty(eventId))
                {
                    FetchEventForEdit(eventId);
                }
                else
                {
                    Response.Redirect("Events.aspx");
                }
            }
        }

        private void FetchEventForEdit(string id)
        {
            
            string apiUrl = $"{apiBase}/search";

            using (HttpClient client = new HttpClient())
            {
                try
                {
                    var response = client.GetAsync(apiUrl).Result;
                    if (response.IsSuccessStatusCode)
                    {
                        var json = response.Content.ReadAsStringAsync().Result;
                        var events = JsonConvert.DeserializeObject<List<dynamic>>(json);
                        var ev = events.FirstOrDefault(x => x.EventId.ToString() == id);

                        if (ev != null)
                        {
                            txtTitle.Text = ev.Title;
                            txtDesc.Text = ev.Description;
                            txtLocation.Text = ev.Location;
                            ddlType.SelectedValue = ev.EventType;
                            txtDate.Text = Convert.ToDateTime(ev.EventDate).ToString("yyyy-MM-dd");
                            ViewState["CurrentImg"] = ev.ImageUrl != null ? ev.ImageUrl.ToString() : "";
                        }
                    }
                }
                catch (Exception ex)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Error fetching: {ex.Message}');", true);
                }
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            string eventId = Request.QueryString["id"];
            string imageUrl = ViewState["CurrentImg"]?.ToString();

           
            if (Session["UserId"] == null) { Response.Redirect("Login.aspx"); return; }
            int currentUserId = Convert.ToInt32(Session["UserId"]);

            if (fileImg.HasFile)
            {
                try
                {
                    string fileName = Path.GetFileName(fileImg.FileName);
                    string folderPath = Server.MapPath("~/Uploads/");
                    if (!Directory.Exists(folderPath)) Directory.CreateDirectory(folderPath);
                    string savePath = Path.Combine(folderPath, fileName);
                    fileImg.SaveAs(savePath);
                    imageUrl = "Uploads/" + fileName;
                }
                catch (Exception ex)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Upload failed: {ex.Message}');", true);
                    return;
                }
            }

            
            var updatedEvent = new
            {
                EventId = int.Parse(eventId),
                Title = txtTitle.Text,
                Description = txtDesc.Text,
                Location = txtLocation.Text,
                EventType = ddlType.SelectedValue,
                EventDate = DateTime.Parse(txtDate.Text),
                ImageUrl = imageUrl,
                OrganizerId = currentUserId
            };

            using (HttpClient client = new HttpClient())
            {
                try
                {
                    var json = JsonConvert.SerializeObject(updatedEvent);
                    var content = new StringContent(json, Encoding.UTF8, "application/json");

                    
                    var response = client.PutAsync($"{apiBase}/update/{currentUserId}", content).Result;

                    if (response.IsSuccessStatusCode)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Event Updated Successfully!'); window.location='Events.aspx';", true);
                    }
                    else
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Update Failed! Check API logs.');", true);
                    }
                }
                catch (Exception ex)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('API Error: {ex.Message}');", true);
                }
            }
        }
    }
}