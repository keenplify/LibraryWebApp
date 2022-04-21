using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace LibraryWebApp
{
    public partial class UserBookViewer : System.Web.UI.Page
    {
        protected string id;
        protected bool bookFound = false;
        protected Dictionary<string, object> Book = new Dictionary<string, object>();
        protected Dictionary<string, object> user = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            //Check if logged in
            user = Helpers.User.AutomaticLoginUserLogic("USER", false, true);
            if (User == null) Response.Redirect("/");
            if (!IsPostBack)
            {
                id = Request.QueryString["id"];

                MySqlConnection Connection = Helpers.Database.Connect();
                string query = "SELECT * FROM books_tbl LEFT JOIN (SELECT id AS user_id, first_name, last_name FROM users_tbl) users_tbl ON books_tbl.created_by = users_tbl.user_id  WHERE books_tbl.id='" + id + "'";

                MySqlCommand cmd = new MySqlCommand(query, Connection);

                MySqlDataReader reader = cmd.ExecuteReader();
                if (reader.HasRows != true) return;
                bookFound = true;

                reader.Read();
                for (int lp = 0; lp < reader.FieldCount; lp++)
                {
                    Book.Add(reader.GetName(lp), reader.GetValue(lp));
                }

                string dor = DateTime.Now.AddDays(7).ToString("yyyy-MM-dd");
                DateOfReturn.Text = dor;
                DateOfReturn.Attributes["max"] = dor;
                DateOfReturn.Attributes["min"] = DateTime.Now.AddDays(1).ToString("yyyy-MM-dd");


                Connection.Close();
                Connection = Helpers.Database.Connect();
                string transactionsActiveQuery = "SELECT count(*) FROM transactions_tbl WHERE state='BORROWED' AND book_id=" + Book["id"];

                MySqlCommand transactionsActiveCmd = new MySqlCommand(transactionsActiveQuery, Connection);
                Int32 transactionsActiveCount = Convert.ToInt32(transactionsActiveCmd.ExecuteScalar());
                Book.Add("transactionsActiveCount", transactionsActiveCount);
                Book.Add("availableStocks", Convert.ToInt32(Book["stock"]) - transactionsActiveCount);
                Connection.Close();

            }
        }

        protected void CreateTransaction_Click(object sender, EventArgs e)
        {
            string returnCode = RandomDigits(6);
            string query =
                    "INSERT INTO transactions_tbl (" +
                    "created_by," +
                    "book_id," +
                    "date_of_return," +
                    "return_code" +
                    ") VALUES (" +
                    "'" + user["id"] + "'," +
                    "'" + Request.QueryString["id"] + "'," +
                    "'" + Convert.ToDateTime(DateOfReturn.Text).ToString("yyyy-MM-dd HH:mm:ss")+ "'," +
                    ""+ returnCode + "" +
                    ");";
            MySqlConnection Connection = Helpers.Database.Connect();
            MySqlCommand cmd = new MySqlCommand(query, Connection);

            cmd.ExecuteNonQuery();
            HttpContext.Current.Response.Redirect("~/UserTransactions");
        }
        public string RandomDigits(int length)
        {
            var random = new Random();
            string s = string.Empty;
            for (int i = 0; i < length; i++)
                s = String.Concat(s, random.Next(10).ToString());
            return s;
        }
    }
}