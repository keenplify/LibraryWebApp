using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace LibraryWebApp
{
    public partial class AdminUserBorrowBook : System.Web.UI.Page
    {
        protected List<Dictionary<string, object>> booksList = new List<Dictionary<string, object>>();
        protected Dictionary<string, object> user = null;
        protected string user_id;
        protected bool isFound = false;

        protected void Search(string keyword=null)
        {
            booksList = new List<Dictionary<string, object>>();
            MySqlConnection Connection = Helpers.Database.Connect();
            string query = "SELECT * FROM books_tbl";

            if (keyword != null) {
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

                booksList.Add(dict);
            }
            foreach (Dictionary<string, object> dict in booksList)
            {
                Connection.Close();
                Connection = Helpers.Database.Connect();
                string transactionsActiveQuery = "SELECT count(*) FROM transactions_tbl WHERE state='BORROWED' AND book_id=" + dict["id"];

                MySqlCommand transactionsActiveCmd = new MySqlCommand(transactionsActiveQuery, Connection);
                Int32 transactionsActiveCount = Convert.ToInt32(transactionsActiveCmd.ExecuteScalar());
                dict.Add("transactionsActiveCount", transactionsActiveCount);
                dict.Add("availableStocks", Convert.ToInt32(dict["stock"]) - transactionsActiveCount);
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            //Check if logged in
            if (Helpers.User.AutomaticLoginUserLogic("ADMIN", false, true) == null) Response.Redirect("/");

            user_id = Request.QueryString["user_id"];

            if (user_id == null)
            {
                Response.Redirect("/");
            }

            if (user_id != null)
            {
                var Connection = Helpers.Database.Connect();
                var query = $"SELECT * FROM users_tbl WHERE id={user_id}";
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
                }
            }

            Search();
        }

        protected void SearchClick(object sender, EventArgs e)
        {
            if (SearchKeyword.Text.Length > 0)
                Search(SearchKeyword.Text);
        }
    }
}