using System;
using System.Collections.Generic;
using MySql.Data.MySqlClient;
using System.Web;

namespace LibraryWebApp.Helpers
{
    public class User
    {
        public static void LogoutLogic(bool redirect=false)
        {
            Cookie.RemoveCookie("user", "email", null);
            Cookie.RemoveCookie("user", "password", null);
            if (redirect) HttpContext.Current.Response.Redirect("~/");
        }
        public static MySqlDataReader LoginLogic(string email, string password, bool redirect = false, bool isAdmin = false)
        {
            MySqlConnection Connection = Database.Connect();
            string query = "SELECT * FROM users_tbl WHERE email='" + email + "'";
            if (isAdmin) query += " AND type='ADMIN'";

            MySqlCommand cmd = new MySqlCommand(query, Connection);

            MySqlDataReader reader = cmd.ExecuteReader();
            if (reader.HasRows != true) throw new InvalidOperationException("No user found!");

            reader.Read();
            string _pwd = reader.GetString("password");

            if (BCrypt.Net.BCrypt.Verify(password, _pwd))
            {
                Dictionary<string, string> userdata = new Dictionary<string, string>
                {
                    { "email", email },
                    { "password", password }
                };

                Cookie.StoreInCookieDictionary("user", null, userdata, null);
                if (redirect)
                {
                    if (reader.GetString("type") == "ADMIN") HttpContext.Current.Response.Redirect("~/AdminDashboard");
                    else HttpContext.Current.Response.Redirect("~/UserDashboard");
                }
                return reader;
            }
            else
            {
                return null;
            }
        }

        public static void Register(string firstName, string lastName, string birthday, string email, string gender, string section, string address, string phoneNumber, string guardianPhoneNumber, string schoolIdImageLocation, string password, string type = "USER")
        {
            try
            {
                string passwordHash = BCrypt.Net.BCrypt.HashPassword(password, 10);
                string query =
                    "INSERT INTO users_tbl (" +
                    "first_name," +
                    "last_name," +
                    "type," +
                    "birthday," +
                    "email," +
                    "gender," +
                    "section," +
                    "address," +
                    "phone_number," +
                    "guardian_phone_number," +
                    "school_id_image_location," +
                    "password) VALUES (" +
                    "'" + firstName + "'," +
                    "'" + lastName + "'," +
                    "'" + type + "'," +
                    "'" + birthday + "'," +
                    "'" + email + "'," +
                    "'" + gender + "'," +
                    "'" + section + "'," +
                    "'" + address + "'," +
                    "'" + phoneNumber + "'," +
                    "'" + guardianPhoneNumber + "'," +
                    "'" + schoolIdImageLocation.Replace(@"\", @"\\") + "'," +
                    "'" + passwordHash + "'" +
                    ");";
                System.Diagnostics.Debug.WriteLine(query);
                MySqlConnection Connection = Database.Connect();
                MySqlCommand cmd = new MySqlCommand(query, Connection);

                cmd.ExecuteNonQuery();
                HttpContext.Current.Response.Redirect("~/UserLoginForm");
            }
            catch
            {
                System.Diagnostics.Debug.WriteLine("Something went wrong while trying to add a user.");
            }
        }
        public static Dictionary<string, object> AutomaticLoginUserLogic(string _type="", bool redirect = false, bool returnReader = false)
        {
            if (Cookie.CookieExist("user", "email") && Cookie.CookieExist("user", "password"))
            {
                try
                {
                    MySqlDataReader reader = LoginLogic(Cookie.GetFromCookie("user", "email"), Cookie.GetFromCookie("user", "password"));

                    if (reader == null) return null;

                    string type = reader.GetString("type");
                    if (type == "") return null;

                    if (_type != "" && type != _type)
                    {
                        throw new InvalidOperationException();
                    }


                    if (returnReader)
                    {
                        Dictionary<string, object> dict = new Dictionary<string, object>();
                        for (int lp = 0; lp < reader.FieldCount; lp++)
                        {
                            dict.Add(reader.GetName(lp), reader.GetValue(lp));
                        }

                        return dict;
                    }

                    if (redirect)
                    {
                        if (type == "ADMIN") HttpContext.Current.Response.Redirect("~/AdminDashboard");
                        else HttpContext.Current.Response.Redirect("~/UserDashboard");
                    }
                }
                catch (InvalidOperationException e)
                {
                    if (redirect) LogoutLogic(false);
                    return null;
                }
            }
            return null;
        }
    }
}