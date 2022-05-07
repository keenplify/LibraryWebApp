using System;
using System.IO;
using System.Collections.Generic;
using MySql.Data.MySqlClient;

namespace LibraryWebApp
{
    public partial class AdminUserForm : System.Web.UI.Page
    {
        protected string prefillup_id;
        protected Dictionary<string, object> user;
        protected bool isFound = false;
        protected void Page_Load(object sender, EventArgs e)
        {
            prefillup_id = Request.QueryString["prefillup_id"];

            if (prefillup_id != null && !IsPostBack)
            {
                var Connection = Helpers.Database.Connect();
                var query = $"SELECT * FROM users_tbl WHERE id={prefillup_id}";
                var cmd = new MySqlCommand(query, Connection);

                MySqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    user = new Dictionary<string, object>();
                    for (int lp = 0; lp < reader.FieldCount; lp++)
                    {
                        user.Add(reader.GetName(lp), reader.GetValue(lp));
                    }
                    isFound = true;
                    FormType.Text = "Edit";
                    FirstName.Text = (string)user["first_name"];
                    LastName.Text = (string)user["last_name"];
                    Birthday.Text = ((DateTime)user["birthday"]).ToString("yyyy-MM-dd");
                    email.Text = (string)user["email"];
                    Address.Text = (string)user["address"];
                    PhoneNumber.Text = (string)user["phone_number"];
                    GuardianPhoneNumber.Text = (string)user["guardian_phone_number"];
                    Gender.Text = (string)user["gender"];
                    Strand.Text = (string)user["strand"];
                }
            }
        }

        protected void SubmitBtn_Click(object sender, EventArgs e)
        {
            if (prefillup_id == null)
            {
                // Add user logic
                if (SchoolIdImage.HasFile)
                {
                    string fileName = "school-id-" + new Random().Next(0, 100000) + "-" + Path.GetFileName(SchoolIdImage.PostedFile.FileName);
                    string path = "/public/" + fileName;
                    SchoolIdImage.PostedFile.SaveAs(Server.MapPath("~/public/") + fileName);

                    Helpers.User.Register(FirstName.Text, LastName.Text, Birthday.Text, email.Text, Gender.Text, Strand.Text, Address.Text, PhoneNumber.Text, GuardianPhoneNumber.Text, path, password.Text, "USER", false);
                }

                Response.Redirect("/AdminUsers");
            }
            else
            {
                MySqlConnection connection = Helpers.Database.Connect();
                string query = "UPDATE users_tbl " +
                    "SET " +
                    "first_name='" + FirstName.Text + "', " +
                    "last_name='" + LastName.Text + "', " +
                    "birthday='" + Birthday.Text + "', " +
                    "email='" + email.Text + "', " +
                    "gender='" + Gender.Text + "', " +
                    "strand='" + Strand.Text + "', " +
                    "address='" + Address.Text + "', " +
                    "phone_number='" + PhoneNumber.Text + "', " +
                    "guardian_phone_number='" + GuardianPhoneNumber.Text + "' " +
                    "WHERE id=" + prefillup_id;
                MySqlCommand cmd = new MySqlCommand(query, connection);
                cmd.ExecuteNonQuery();

                Response.Redirect("/AdminUsers");
            }
        }
    }
}