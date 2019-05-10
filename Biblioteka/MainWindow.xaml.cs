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
using System.Collections.ObjectModel;

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
        bool zalogowany = false;
        int rola;
        SqlConnection polaczenie;
        public MainWindow()
        {
            InitializeComponent();
            try
            {
                List<int> Roles = new List<int>();

                polaczenie = new SqlConnection(@"Data source=localhost;
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
               
            }

            catch (SqlException e)
            {
                Console.WriteLine("Wystąpił nieoczekiwany błąd!");
                Console.WriteLine(e.Message);
            }



        }

        ~MainWindow()
        {
            polaczenie.Close();
        }
        private void Login_TextChanged(object sender, TextChangedEventArgs e)
        {

        }
        
        private void Button_Click(object sender, RoutedEventArgs e)
        {
            doButton.IsEnabled = false;
            kolumna.IsEnabled = false;
            tabele.IsEnabled = false;
            switch (login.Text)
            {
                case "login":
                    if(password.Password =="123")
                    {
                        zalogowany = true;
                        roles.Items.Add(1);
                        roles.Items.Add(3);
                        roles.UpdateLayout();

                        tabele.Items.Add("Ksiazka");
                        
                        kolumna.Items.Add("Tytul");
                        kolumna.Items.Add("Rok_wydania");
                        kolumna.Items.Add("Autor");
                        kolumna.Items.Add("Id_ksiazki");

                        akcja.Items.Add("Read");
                        akcja.Items.Add("Update");
                        akcja.Items.Add("Add");
                        akcja.Items.Add("Delete");
                        
                        kolumna.UpdateLayout();
                        tabele.UpdateLayout();
                        akcja.UpdateLayout();

                        login.IsEnabled = false;
                        password.IsEnabled = false;
                        button1.IsEnabled = false;
                    }
                    break;
                   
            }
            
        }


        private void _do_Click(object sender, RoutedEventArgs e)
        {
            SqlCommand biblioteka = polaczenie.CreateCommand();
            biblioteka.CommandText = $"SELECT * FROM [{(string)tabele.SelectedItem}]";
            SqlDataReader czytnik = biblioteka.ExecuteReader();

            DataTable dt = new DataTable();

            dt.Columns.Add("Tytul");
            dt.Columns.Add("Rok_wydania");
            dt.Columns.Add("Autor");
            var colId = dt.Columns.Add("Id_ksiazki");
            colId.ReadOnly = true;




            while (czytnik.Read())
            {
                dt.Rows.Add(czytnik["Tytul"].ToString(),
                    czytnik["Rok_wydania"].ToString(),
                    czytnik["Autor"].ToString(),
                    czytnik["Id_ksiazki"].ToString());
            }

            dataTable.ItemsSource = dt.AsDataView();
            //dataTable.DataContext = dt.DefaultView;

            czytnik.Close();
        }

        private void Kolumna_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            doButton.IsEnabled = true;
        }

        private void Akcja_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            tabele.IsEnabled = true;
        }

        private void Roles_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            rola = (int)roles.SelectedItem;
            roles.IsEnabled = false;
        }

        private void ListBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {

        }

        private void Tabele_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            kolumna.IsEnabled = true;
        }

        private void DataTable_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {

        }
    }
}

