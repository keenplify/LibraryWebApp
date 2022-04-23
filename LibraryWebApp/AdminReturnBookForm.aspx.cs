using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace LibraryWebApp
{
    public partial class AdminReturnBookForm : System.Web.UI.Page
    {
        protected Dictionary<string, object> user = null;
        protected Dictionary<string, object> Transaction = null;
        protected bool isOnError = false;
        protected bool isOnPenalty = false;
        protected bool isOnLate = false;

        protected void Page_Load(object sender, EventArgs e)
        {
            user = Helpers.User.AutomaticLoginUserLogic("ADMIN", false, true);
            if (user == null) Response.Redirect("/");

            if (ReturnCode.Text.Length > 0) ReturnLookupBtn_Click(sender, e);
        }

        protected void ReturnLookupBtn_Click(object sender, EventArgs e)
        {
            MySqlConnection Connection = Helpers.Database.Connect();
            string query = "SELECT * FROM transactions_tbl LEFT JOIN (SELECT id AS bid, title, cover_image_location FROM books_tbl) books_tbl ON books_tbl.bid=transactions_tbl.book_id LEFT JOIN (SELECT id AS uid, first_name, last_name FROM users_tbl) users_tbl ON users_tbl.uid=transactions_tbl.created_by";
            if (ReturnCode.Text != null)
            {
                query += " WHERE state='BORROWED' AND return_code='" + ReturnCode.Text + "'";
            }

            MySqlCommand cmd = new MySqlCommand(query, Connection);

            MySqlDataReader reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                Transaction = new Dictionary<string, object>();

                for (int lp = 0; lp < reader.FieldCount; lp++)
                {
                    Transaction.Add(reader.GetName(lp), reader.GetValue(lp));
                }
            }

            if (Transaction==null)
            {
                isOnError = true;
                return;
            }
            DateTime dor = Convert.ToDateTime(Transaction["date_of_return"]);
            if (DateTime.Now >= dor)
            {
                isOnLate = true;
                isOnPenalty = true;
                IncludePenaltyCheckbox.Checked = true;
                Description.Text = "Returned the book " + Transaction["title"] + " late.";
            }
        }

        protected void IncludePenalty_CheckedChanged(object sender, EventArgs e)
        {
            isOnPenalty = IncludePenaltyCheckbox.Checked;
        }

        protected void ReturnBookBtn_Click(object sender, EventArgs e)
        {
            MySqlConnection connection = Helpers.Database.Connect();
            string query = "UPDATE transactions_tbl SET state='RETURNED' WHERE id=" + Transaction["id"];
            MySqlCommand cmd = new MySqlCommand(query, connection);
            cmd.ExecuteNonQuery();
            connection.Close();

            if (IncludePenaltyCheckbox.Checked)
            {
                connection = Helpers.Database.Connect();
                string query2 = "INSERT INTO penalties_tbl (created_by, description, punished_id, punisher_id) VALUES ('" + user["id"] + "','" + Description.Text + "', '" + Transaction["uid"] + "', '"+ user["id"] +"')";
                System.Diagnostics.Debug.WriteLine(query2);
                MySqlCommand cmd2 = new MySqlCommand(query2, connection);
                cmd2.ExecuteNonQuery();
                connection.Close();
            }

            Response.Redirect("AdminReturnBookForm");
        }
    }
}