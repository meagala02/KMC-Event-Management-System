using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Http;
using System.Text;
using Newtonsoft.Json;
using System.IO; 

namespace KMC_ClientApp
{
    public partial class AddEvent : System.Web.UI.Page
    {
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                
                string imageUrl = "Uploads/default.jpg"; 
                if (fileImg.HasFile)
                {
                    string fileName = Guid.NewGuid().ToString() + Path.GetExtension(fileImg.FileName);
                    string folderPath = Server.MapPath("~/Uploads/");

                    
                    if (!Directory.Exists(folderPath)) Directory.CreateDirectory(folderPath);

                    fileImg.SaveAs(folderPath + fileName);
                    imageUrl = "Uploads/" + fileName;
                }

                
                var newEvent = new
                {
                    Title = txtTitle.Text,
                    Description = txtDesc.Text,
                    EventDate = txtDate.Text,
                    Location = txtLocation.Text,
                    EventType = ddlType.SelectedValue,
                    ImageUrl = imageUrl, 
                    OrganizerId = Session["UserId"] != null ? Session["UserId"] : 1 
                };

                string apiUrl = "https://localhost:44314/api/events/add";

                using (HttpClient client = new HttpClient())
                {
                    System.Net.ServicePointManager.ServerCertificateValidationCallback += (se, cert, chain, sslerror) => true;

                    
                    var json = JsonConvert.SerializeObject(newEvent);
                    var content = new StringContent(json, Encoding.UTF8, "application/json");

                    
                    var response = client.PostAsync(apiUrl, content).Result;

                    if (response.IsSuccessStatusCode)
                    {
                        
                        Response.Write("<script>alert('Event Registered Successfully!'); window.location='Events.aspx';</script>");
                    }
                    else
                    {
                        Response.Write("<script>alert('Failed to register event. Check API status.');</script>");
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }
        }
    }
}