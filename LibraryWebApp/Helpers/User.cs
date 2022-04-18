using System;
using System.Collections.Generic;
using MySql.Data.MySqlClient;
using System.Web;

namespace LibraryWebApp.Helpers
{
    public class User
    {
        public static void LogoutLogic()
        {
            Cookie.RemoveCookie("user", "email", null);
            Cookie.RemoveCookie("user", "password", null);
            HttpContext.Current.Response.Redirect("~/");
        }
        public static MySqlDataReader LoginLogic(string email, string password, bool redirect= false)
        {
            MySqlConnection Connection = Database.Connect();
            MySqlCommand cmd = new MySqlCommand("SELECT * FROM users_tbl WHERE email='" + email + "'", Connection);

            MySqlDataReader reader = cmd.ExecuteReader();
            reader.Read();
            string _pwd = reader.GetString("password");

            if (BCrypt.Net.BCrypt.Verify(password, _pwd))
            {
                Dictionary<string, string> userdata = new Dictionary<string, string>
                {
                    { "email", email },
                    { "password", password }
                };

                Helpers.Cookie.StoreInCookieDictionary("user", null, userdata, null);
                if (redirect)
                {
                    if (reader.GetString("type") == "ADMIN") HttpContext.Current.Response.Redirect("~/AdminDashboard");
                    else HttpContext.Current.Response.Redirect("~/UserDashboard");
                }
                return reader;
            }
            else
            {
                throw new InvalidOperationException("Wrong or invalid password. Please try again.");
            }
        }

        public static void AutomaticLoginUserLogic(string _type="", bool redirect = false)
        {
            if (Cookie.CookieExist("user", "email") && Cookie.CookieExist("user", "password"))
            {
                try
                {
                    MySqlDataReader reader = LoginLogic(Cookie.GetFromCookie("user", "email"), Cookie.GetFromCookie("user", "password"));
                    string type = reader.GetString("type");
                    if (type == "") return;

                    if (type != _type)
                    {
                        throw new InvalidOperationException();
                    }

                    if (redirect)
                    {
                        if (type == "ADMIN") HttpContext.Current.Response.Redirect("~/AdminDashboard");
                        else HttpContext.Current.Response.Redirect("~/UserDashboard");
                    }
                }
                catch (InvalidOperationException e)
                {
                    LogoutLogic();
                }
            } else
            {
                if (!redirect)
                {
                    LogoutLogic();
                }
            }
        }
    }
}