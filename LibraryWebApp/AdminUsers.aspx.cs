using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
namespace LibraryWebApp
{
    public partial class AdminUsers : System.Web.UI.Page
    {
        protected Dictionary<string, object> user;
        protected List<Dictionary<string, object>> UsersList = new List<Dictionary<string, object>>();

        protected void Search(string keyword = null)
        {
            UsersList = new List<Dictionary<string, object>>();
            MySqlConnection Connection = Helpers.Database.Connect();
            string query = "SELECT * FROM users_tbl WHERE type='USER'";

            if (keyword != null)
            {
                string lowerKeyword = keyword.ToLowerInvariant();
                query += " AND " +
                    "lower(users_tbl.first_name) LIKE '%" + lowerKeyword + "%' OR " +
                    "lower(users_tbl.last_name) LIKE '%" + lowerKeyword + "%' OR " +
                    "lower(users_tbl.email) LIKE '%" + lowerKeyword + "%'  OR " +
                    "lower(users_tbl.strand) LIKE '%" + lowerKeyword + "%'";
            }

            MySqlCommand cmd = new MySqlCommand(query, Connection);

            MySqlDataReader reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                Dictionary<string, object> dict = new Dictionary<string, object>();
                for (int lp = 0; lp < reader.FieldCount; lp++)
                {
                    dict.Add(reader.GetName(lp), reader.GetValue(lp));
                }
                UsersList.Add(dict);
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            user = Helpers.User.AutomaticLoginUserLogic("ADMIN", false, true);

            if (user == null) Response.Redirect("/");

            Search();

            string toggleStatusId = Request.QueryString.Get("toggleStatus");
            string toggleStatusTo = Request.QueryString.Get("toggleStatusTo");

            if (toggleStatusId != null && toggleStatusTo != null)
            {
                MySqlConnection connection = Helpers.Database.Connect();
                string query = "UPDATE penalties_tbl SET is_resolved='" + toggleStatusTo + "' WHERE id=" + toggleStatusId;
                MySqlCommand cmd = new MySqlCommand(query, connection);
                cmd.ExecuteNonQuery();

                Response.Redirect(Request.RawUrl.Replace(Request.Url.Query, ""));
            }
        }

        protected void SearchBtn_Click(object sender, EventArgs e)
        {
            if (SearchKeyword.Text.Length > 0)
                Search(SearchKeyword.Text);
        }

        protected void EditUserBtn_Click(object sender, EventArgs e)
        {
            System.Diagnostics.Debug.WriteLine(sender);
        }
    }
}