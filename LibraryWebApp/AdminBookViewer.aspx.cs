using System;
using System.Collections.Generic;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace LibraryWebApp
{
    public partial class AdminBookViewer : System.Web.UI.Page
    {
        protected string id;
        protected Dictionary<string, object> Book = new Dictionary<string, object>();
        protected bool bookFound = false;

        protected void Page_Load(object sender, EventArgs e)
        {
            //Check if logged in
            if (Helpers.User.AutomaticLoginUserLogic("ADMIN", false, true) == null) Response.Redirect("/");

            id = Request.QueryString["id"];

            MySqlConnection Connection = Helpers.Database.Connect();
            string query = "SELECT * FROM books_tbl LEFT JOIN (SELECT id AS user_id, first_name, last_name FROM users_tbl) users_tbl ON books_tbl.created_by = users_tbl.user_id  WHERE books_tbl.id='" + id + "'";

            MySqlCommand cmd = new MySqlCommand(query, Connection);

            MySqlDataReader reader = cmd.ExecuteReader();
            if (reader.HasRows != true) return;

            reader.Read();
            for (int lp = 0; lp < reader.FieldCount; lp++)
            {
                Book.Add(reader.GetName(lp), reader.GetValue(lp));
            }
            if (!IsPostBack)
            {
                bookFound = true;
                Publisher.Text = (string)Book["publisher"];
                Author.Text = (string)Book["author"];
                CoverPhoto.ImageUrl = (string)Book["cover_image_location"];
                Stock.Text = Book["stock"].ToString();
                Page.Title = Book["title"] + " - Library System";
                ISBN.Text = Book["isbn"].ToString();
                PublisherID.Text = Book["publisher_id"].ToString();
                Pages.Text = Book["pages"].GetType().ToString() == "System.DBNull" ? "0" : Book["pages"].ToString();
                BookType.Text = Book["book_type"].ToString();
                PublishingDate.Text = Book["publishing_date"].ToString();
                StockModTbx.Text = "1";
            }
        }

        protected void Update_Book(object sender, EventArgs e)
        {
            MySqlConnection connection = Helpers.Database.Connect();
            string query = "UPDATE books_tbl " +
                "SET author='" + Author.Text + "', " +
                "publisher='" + Author.Text + "', " +
                "isbn='" + ISBN.Text + "', " +
                $"publisher_id='{PublisherID.Text}', " +
                $"pages='{Pages.Text}', " +
                $"book_type='{BookType.Text}', " +
                $"publishing_date='{PublishingDate.Text}' " +
                "WHERE id=" + id;
            MySqlCommand cmd = new MySqlCommand(query, connection);
            cmd.ExecuteNonQuery();
            Response.Redirect("AdminBooks");
        }

        protected void Delete_Book(object sender, EventArgs e)
        {
            MySqlConnection connection = Helpers.Database.Connect();
            string query = "DELETE FROM books_tbl WHERE id=" + id;
            MySqlCommand cmd = new MySqlCommand(query, connection);
            cmd.ExecuteNonQuery();
            Response.Redirect("AdminBooks");
        }

        protected void UpdateImageBtn_Click(object sender, EventArgs e)
        {
            if (UpdateCover.HasFile)
            {
                string fileName = "book-cover-" + new Random().Next(0, 100000) + "-" + Path.GetFileName(UpdateCover.PostedFile.FileName);
                string path = "/public/" + fileName;
                UpdateCover.PostedFile.SaveAs(Server.MapPath("~/public/") + fileName);

                MySqlConnection connection = Helpers.Database.Connect();
                string query = "UPDATE books_tbl SET cover_image_location='" + path.Replace(@"\", @"\\") + "' WHERE id=" + id;
                MySqlCommand cmd = new MySqlCommand(query, connection);
                cmd.ExecuteNonQuery();
                Response.Redirect("AdminBooks");
            }
        }

        protected void UpdateStockBtn_Click(object sender, EventArgs e)
        {
            MySqlConnection connection = Helpers.Database.Connect();
            string query = "UPDATE books_tbl SET stock=stock" + StockMode.Text + StockModTbx.Text + " WHERE id=" + id;
            System.Diagnostics.Debug.WriteLine(query);
            MySqlCommand cmd = new MySqlCommand(query, connection);
            cmd.ExecuteNonQuery();
            Response.Redirect("AdminBooks");
        }
    }
}