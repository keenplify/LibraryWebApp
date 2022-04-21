using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace LibraryWebApp
{
    public partial class UserTransactions : System.Web.UI.Page
    {
        protected Dictionary<string, object> user;
        protected List<Dictionary<string, object>> TransactionsList = new List<Dictionary<string, object>>();

        protected void Search(string keyword = null) {
            TransactionsList = new List<Dictionary<string, object>>();
            MySqlConnection Connection = Helpers.Database.Connect();
            string query = "SELECT * " +
                "FROM transactions_tbl " +
                "LEFT JOIN(SELECT id AS booktbl_id, title, author, publisher, cover_image_location FROM books_tbl) books_tbl " +
                "ON books_tbl.booktbl_id = transactions_tbl.book_id " +
                "WHERE transactions_tbl.created_by=" +
                user["id"];
                
            
            if (keyword != null)
            {
                string lowerKeyword = keyword.ToLowerInvariant();
                query += " AND lower(books_tbl.title) LIKE '%" + lowerKeyword + "%' OR lower(books_tbl.author) LIKE '%" + lowerKeyword + "%' OR lower(books_tbl.publisher) LIKE '%" + lowerKeyword + "%'";
            }

            query += " ORDER BY FIELD(state, 'BORROWED', 'RETURNED') ASC, transactions_tbl.date_of_return ASC LIMIT 10";
            MySqlCommand cmd = new MySqlCommand(query, Connection);

            MySqlDataReader reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                Dictionary<string, object> dict = new Dictionary<string, object>();
                for (int lp = 0; lp < reader.FieldCount; lp++)
                {
                    dict.Add(reader.GetName(lp), reader.GetValue(lp));
                }

                DateTime dor = Convert.ToDateTime(dict["date_of_return"]);
                string timeago = Helpers.Time.GetTimeSince(dor);
                bool isLate = (DateTime.Now >= dor);
                dict.Add("timeago", timeago);
                dict.Add("isLate", isLate);


                TransactionsList.Add(dict);
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            user = Helpers.User.AutomaticLoginUserLogic("USER", false, true);

            if (user == null) Response.Redirect("/");

            Search();
        }

        protected void SearchBtn_Click(object sender, EventArgs e)
        {
            if (SearchKeyword.Text.Length > 0)
                Search(SearchKeyword.Text);
        }
    }
}