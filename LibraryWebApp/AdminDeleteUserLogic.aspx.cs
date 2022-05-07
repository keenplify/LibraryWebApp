using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace LibraryWebApp
{
    public partial class AdminDeleteUserLogic : System.Web.UI.Page
    {
        protected string id;
        protected void Page_Load(object sender, EventArgs e)
        {
            id = Request.QueryString["id"];

            if (id != null && !IsPostBack)
            {
                var Connection = Helpers.Database.Connect();
                var query = $"DELETE FROM users_tbl WHERE id={id}";
                var cmd = new MySqlCommand(query, Connection);
                cmd.ExecuteNonQuery();
            }

            Response.Redirect("~/AdminUsers");
        }
    }
}