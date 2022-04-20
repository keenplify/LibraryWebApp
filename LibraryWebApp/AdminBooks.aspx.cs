using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace LibraryWebApp
{
    public partial class AdminBooks : System.Web.UI.Page
    {
        protected List<Dictionary<string, object>> BooksList = new List<Dictionary<string, object>>();
        protected void Page_Load(object sender, EventArgs e)
        {
            //Check if logged in
            if (Helpers.User.AutomaticLoginUserLogic("ADMIN", false, true) == null) Response.Redirect("/");

            MySqlConnection Connection = Helpers.Database.Connect();
            string query = "SELECT * FROM books_tbl";
            MySqlCommand cmd = new MySqlCommand(query, Connection);

            MySqlDataReader reader = cmd.ExecuteReader();
            if (reader.HasRows != true) throw new InvalidOperationException("No user found!");

            while (reader.Read())
            {
                Dictionary<string, object> dict = new Dictionary<string, object>();
                for (int lp = 0; lp < reader.FieldCount; lp++)
                {
                    dict.Add(reader.GetName(lp), reader.GetValue(lp));
                }
                foreach (var key in dict.Keys)
                {
                    System.Diagnostics.Debug.WriteLine(dict[key]);
                }
                BooksList.Add(dict);
            }
        }
    }
}