using System;
using System.Collections.Generic;
using System.Web.UI;
using MySql.Data.MySqlClient;
using System.Web;

namespace LibraryWebApp
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Helpers.Cookie.CookieExist("user", "email") && Helpers.Cookie.CookieExist("user", "password"))
            {
                MySqlDataReader reader = Helpers.User.LoginLogic(Helpers.Cookie.GetFromCookie("user", "email"), Helpers.Cookie.GetFromCookie("user", "password"));
                Dictionary<string, object> dict = new Dictionary<string, object>();
                for (int lp = 0; lp < reader.FieldCount; lp++)
                {
                    dict.Add(reader.GetName(lp), reader.GetValue(lp));
                }

                if (dict == null) return;
                UserFullName.Text = dict["first_name"].ToString() + " " + dict["last_name"].ToString();
            }
        }
    protected void Logout(object sender, EventArgs e)
        {
            Helpers.User.LogoutLogic();
            Response.Redirect("/");
        }
    }
}