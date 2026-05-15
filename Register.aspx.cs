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
    public partial class Register : System.Web.UI.Page
    {
        protected void btnRegister_Click(object sender, EventArgs e)
        {
            
            var userData = new
            {
                FullName = txtName.Text,
                Email = txtEmail.Text,
                Password = txtPass.Text,
                Role = ddlRole.SelectedValue
            };

            
            string apiUrl = "https://localhost:44314/api/account/register";

            using (HttpClient client = new HttpClient())
            {
                
                System.Net.ServicePointManager.ServerCertificateValidationCallback += (se, cert, chain, ssl) => true;

                
                var json = JsonConvert.SerializeObject(userData);
                var content = new StringContent(json, Encoding.UTF8, "application/json");

                
                var response = client.PostAsync(apiUrl, content).Result;

                if (response.IsSuccessStatusCode)
                {
                    
                    Response.Write("<script>alert('Account created successfully!'); window.location='Login.aspx';</script>");
                }
                else
                {
                    Response.Write("<script>alert('Error: Registration failed. Email might already exist.');</script>");
                }
            }
        }
    }
}