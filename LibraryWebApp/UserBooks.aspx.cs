using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace LibraryWebApp
{
    public partial class UserBooks : System.Web.UI.Page
    {
        protected List<Dictionary<string, object>> BooksList = new List<Dictionary<string, object>>();


        protected void SearchClick(object sender, EventArgs e)
        {
            if (SearchKeyword.Text.Length > 0)
                Search(SearchKeyword.Text);
        }
        protected void Search(string keyword = null)
        {
            BooksList = new List<Dictionary<string, object>>();
            MySqlConnection Connection = Helpers.Database.Connect();
            string query = "SELECT * FROM books_tbl";

            if (keyword != null)
            {
                string lowerKeyword = keyword.ToLowerInvariant();
                query += " WHERE lower(title) LIKE '%" + lowerKeyword + "%' OR lower(author) LIKE '%" + lowerKeyword + "%' OR lower(publisher) LIKE '%" + lowerKeyword + "%'";
            }
            query += " ORDER BY id DESC";

            MySqlCommand cmd = new MySqlCommand(query, Connection);

            MySqlDataReader reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                Dictionary<string, object> dict = new Dictionary<string, object>();
                for (int lp = 0; lp < reader.FieldCount; lp++)
                {
                    dict.Add(reader.GetName(lp), reader.GetValue(lp));
                }

                BooksList.Add(dict);
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            //Check if logged in
            if (Helpers.User.AutomaticLoginUserLogic("USER", false, true) == null) Response.Redirect("/");

            Search();
        }
    }
}