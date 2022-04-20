﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
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
                Stock.Text = Book["stock"].ToString();
                Page.Title = Book["title"] + " - Library System";
            }
        }

        protected void Update_Book(object sender, EventArgs e)
        {
            MySqlConnection connection = Helpers.Database.Connect();
            string query = "UPDATE books_tbl SET author='" + Author.Text + "', publisher='" + Author.Text + "', stock=" + Stock.Text + " WHERE id=" + id;
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
    }
}