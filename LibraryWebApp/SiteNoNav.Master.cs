using System;
using System.Collections.Generic;
using System.Web.UI;
using MySql.Data.MySqlClient;
using System.Web;

namespace LibraryWebApp
{
    public partial class SiteNoNav : MasterPage
    {
        protected string homeHREF = "#";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Helpers.Cookie.CookieExist("user", "email") && Helpers.Cookie.CookieExist("user", "password"))
            {
                try
                {
                    MySqlDataReader reader = Helpers.User.LoginLogic(Helpers.Cookie.GetFromCookie("user", "email"), Helpers.Cookie.GetFromCookie("user", "password"));

                    if (reader == null) return;

                    Dictionary<string, object> dict = new Dictionary<string, object>();
                    for (int lp = 0; lp < reader.FieldCount; lp++)
                    {
                        dict.Add(reader.GetName(lp), reader.GetValue(lp));
                    }

                    if (dict == null) return;
                    homeHREF = dict["type"].ToString() == "ADMIN" ? "/AdminDashboard" : "/UserDashboard";
                }
                catch (Exception err)
                {
                    System.Diagnostics.Debug.WriteLine(err);
                }
            }
        }
        protected void Logout(object sender, EventArgs e)
        {
            Helpers.User.LogoutLogic();
            Response.Redirect("/");
        }
    }
}