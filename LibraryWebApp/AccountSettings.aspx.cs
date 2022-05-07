using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace LibraryWebApp
{
    public partial class AccountSettings : System.Web.UI.Page
    {
        protected Dictionary<string, object> user=null;
        protected void Page_Load(object sender, EventArgs e)
        {
            user = Helpers.User.AutomaticLoginUserLogic("", false, true);
            
            if (user == null) Response.Redirect("/");

            if (!IsPostBack)
            {
                FirstName.Text = user["first_name"].ToString();
                LastName.Text = user["last_name"].ToString();
                Birthday.Text = Convert.ToDateTime(user["birthday"]).ToString("yyyy-MM-dd");
                Strand.Text = user["strand"].ToString();
                Address.Text = user["address"].ToString();
                PhoneNumber.Text = user["phone_number"].ToString();
                email.Text = user["email"].ToString();
                GuardianPhoneNumber.Text = user["guardian_phone_number"].ToString();
                Gender.Items.FindByValue(user["gender"].ToString()).Selected = true;
            }
        }

        protected void UpdateBtn_Click(object sender, EventArgs e)
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
                "WHERE id=" + user["id"];
            MySqlCommand cmd = new MySqlCommand(query, connection);
            cmd.ExecuteNonQuery();

            Response.Redirect("/AccountSettings");
        }

        protected void UpdatePasswordBtn_Click(object sender, EventArgs e)
        {
            if (NewPassword.Text != NewPasswordConfirm.Text)
            {
                NewPasswordError.Text = "The new password and the confirm new password is not the same.";
                return;
            }

            string passwordHash = BCrypt.Net.BCrypt.HashPassword(NewPassword.Text, 10);
            MySqlConnection connection = Helpers.Database.Connect();
            string query = "UPDATE users_tbl " +
                "SET " +
                "password='" + passwordHash + "' " +
                "WHERE id=" + user["id"];
            MySqlCommand cmd = new MySqlCommand(query, connection);
            cmd.ExecuteNonQuery();

            Helpers.User.LogoutLogic(true);
            Response.Redirect("/");
        }
    }
}