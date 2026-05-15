using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Http;
using System.Text;
using Newtonsoft.Json;

namespace KMC_ClientApp
{
    public partial class Login : System.Web.UI.Page
    {
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            
            var loginData = new
            {
                Email = txtEmail.Text,
                Password = txtPass.Text
            };

            string apiUrl = "https://localhost:44314/api/account/login";

            using (HttpClient client = new HttpClient())
            {
                
                System.Net.ServicePointManager.ServerCertificateValidationCallback += (se, cert, chain, ssl) => true;

                var json = JsonConvert.SerializeObject(loginData);
                var content = new StringContent(json, Encoding.UTF8, "application/json");

                
                var response = client.PostAsync(apiUrl, content).Result;

                if (response.IsSuccessStatusCode)
                {
                    
                    var resultJson = response.Content.ReadAsStringAsync().Result;
                    dynamic user = JsonConvert.DeserializeObject(resultJson);

                    
                    Session["UserId"] = user.UserId;
                    Session["UserRole"] = user.Role; 
                    Session["UserName"] = user.FullName;

                    
                    Response.Redirect("Events.aspx");
                }
                else
                {
                    lblError.Text = "Invalid Email or Password. Please try again.";
                }
            }
        }
    }
}