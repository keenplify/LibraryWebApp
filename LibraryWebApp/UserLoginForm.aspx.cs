using System;
using System.Text.RegularExpressions;

namespace LibraryWebApp
{
    public partial class UserLoginForm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Helpers.User.AutomaticLoginUserLogic("", true);
        }

        protected void Login(object sender, EventArgs e)
        {
            if (email.Text.Length <= 0 || !new Regex("^\\S+@\\S+\\.\\S+$").IsMatch(email.Text))
            {
                EmailErrorLabel.Text = "Invalid email. Please try again.";
                PasswordErrorLabel.Text = "";
                return;
            }

            try
            {
                Helpers.User.LoginLogic(email.Text, password.Text, true);
            }
            catch (InvalidOperationException error)
            {
                EmailErrorLabel.Text = "";
                PasswordErrorLabel.Text = error.Message;
            }
        }
    }
}