using System;
using System.Web.UI;
using System.Text.RegularExpressions;

namespace LibraryWebApp
{
    public partial class _Default : Page
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
                var reader = Helpers.User.LoginLogic(email.Text, password.Text, true);

                if (reader == null)
                {
                    EmailErrorLabel.Text = "";
                    PasswordErrorLabel.Text = "Invalid password. Please try again.";
                    return;
                }
            }
            catch (InvalidOperationException error)
            {
                EmailErrorLabel.Text = "";
                PasswordErrorLabel.Text = error.Message;
            }
        }
    }
}