using System;
using System.IO;
using System.Collections.Generic;

namespace LibraryWebApp
{
    public partial class RegisterForm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Register(object sender, EventArgs e)
        {
            if (SchoolIdImage.HasFile)
            {
                string fileName = "school-id-" + new Random().Next(0, 100000) + "-" + Path.GetFileName(SchoolIdImage.PostedFile.FileName);
                string path = "/public/" + fileName;
                SchoolIdImage.PostedFile.SaveAs(Server.MapPath("~/public/") + fileName);

                Helpers.User.Register(FirstName.Text, LastName.Text, Birthday.Text, email.Text, Gender.Text, Section.Text, Address.Text, PhoneNumber.Text, GuardianPhoneNumber.Text, path, password.Text);
            }
        }
    }
}