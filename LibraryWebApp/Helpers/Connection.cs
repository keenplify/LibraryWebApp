using MySql.Data.MySqlClient;

namespace LibraryWebApp.Helpers
{
    public class Database
    {
        public static string SERVER = "127.0.0.1";
        public static string UID = "root";
        public static string PWD = "*8*S5Kz2drNc";
        public static string DATABASE = "library_db";

        public static MySqlConnection Connect()
        {
            try
            {
                MySqlConnection Connection = new MySqlConnection
                {
                    ConnectionString =
                    "server=" + SERVER +
                    ";uid=" + UID +
                    ";pwd=" + PWD +
                    ";database=" + DATABASE
                };
                Connection.Open();

                return Connection;
            }
            catch (MySqlException ex)
            {
                throw ex;
            }
        }
    }
}