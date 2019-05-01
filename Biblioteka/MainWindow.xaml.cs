using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Data.SqlClient;
using System.Data;

namespace Biblioteka
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>

    public class Role
    {
        int id;
        public List<Permissions> Permissions { get; set; }
    }

    public enum Permissions
    {
        Read = 1,
        Update = 2,
        Add = 3,
        Delete = 4 //rest of your roles
    }


    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
            try
            {
                List<int> Roles = new List<int>();

                SqlConnection polaczenie = new SqlConnection(@"Data source=LAPTOP-98O1O16J;
                                                             database=Biblioteka;
                                                            Integrated Security = True");
                polaczenie.Open();
                SqlCommand biblioteka = polaczenie.CreateCommand();
                biblioteka.CommandText = "SELECT Role.Id FROM [User], Role, User_Role WHERE [User].Name = 'Ania' AND [User].Password = 'test' AND [User].Id = User_Role.Id_User AND User_Role.Id_role = Role.Id";
                SqlDataReader czytnik = biblioteka.ExecuteReader();

                Console.WriteLine("Wiersze tabeli:");
                while (czytnik.Read())
                {
                    Roles.Add(Int32.Parse(czytnik["Id"].ToString()));
                }
                czytnik.Close();
                polaczenie.Close();

                Console.ReadKey();
            }

            catch (SqlException e)
            {
                Console.WriteLine("Wystąpił nieoczekiwany błąd!");
                Console.WriteLine(e.Message);
                //  Console.ReadKey();
            }



        }
    }
}

