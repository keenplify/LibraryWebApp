using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using MySql.Data.MySqlClient;
using System.IO;

namespace LibraryWebApp
{
    public partial class AdminAddBook : System.Web.UI.Page
    {
        protected Dictionary<string, object> user;
        protected void Page_Load(object sender, EventArgs e)
        {
            user = Helpers.User.AutomaticLoginUserLogic("ADMIN", false, true);

            //Check if logged in
            if (user == null) Response.Redirect("/");
        }

        protected void Add_Book(object sender, EventArgs e)
        {
            string fileName = "book-cover-" + new Random().Next(0, 100000) + "-" + Path.GetFileName(Cover.PostedFile.FileName);
            string path = "/public/" + fileName;
            Cover.PostedFile.SaveAs(Server.MapPath("~/public/") + fileName);

            string query =
                    "INSERT INTO books_tbl (" +
                    "created_by," +
                    "title," +
                    "publisher," +
                    "author," +
                    "stock," +
                    "cover_image_location," +
                    "isbn," +
                    "publisher_id," +
                    "pages," +
                    "book_type," +
                    "publishing_date" +
                    ") VALUES (" +
                    "'" + user["id"] + "'," +
                    "'" + BookTitle.Text + "'," +
                    "'" + Publisher.Text + "'," +
                    "'" + Author.Text + "'," +
                    "'" + Stock.Text + "'," +
                    "'" + path.Replace(@"\", @"\\") + "'," +
                    $"'{ISBN.Text}'," +
                    $"'{PublisherID.Text}'," +
                    $"'{Pages.Text}'," +
                    $"'{BookType.Text}'," +
                    $"'{PublishingDate.Text}'" +
                    ");";

            MySqlConnection Connection = Helpers.Database.Connect();
            MySqlCommand cmd = new MySqlCommand(query, Connection);

            cmd.ExecuteNonQuery();
            HttpContext.Current.Response.Redirect("~/AdminBooks");
        }
    }
}