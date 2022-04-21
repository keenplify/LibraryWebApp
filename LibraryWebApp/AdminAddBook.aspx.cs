using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using MySql.Data.MySqlClient;

namespace LibraryWebApp
{
    public partial class AdminAddBook : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //Check if logged in
            if (Helpers.User.AutomaticLoginUserLogic("ADMIN", false, true) == null) Response.Redirect("/");
        }

        protected void Add_Book(object sender, EventArgs e)
        {
            string query =
                    "INSERT INTO users_tbl (" +
                    "title," +
                    "publisher," +
                    "author," +
                    "stock) VALUES (" +
                    "'" + Title.Text + "'," +
                    "'" + Publisher.Text + "'," +
                    "'" + Author.Text + "'," +
                    "'" + Stock.Text + "'," +
                    ");";
            MySqlConnection Connection = Helpers.Database.Connect();
            MySqlCommand cmd = new MySqlCommand(query, Connection);

            cmd.ExecuteNonQuery();
            HttpContext.Current.Response.Redirect("~/AdminBooks");
        }
    }
}