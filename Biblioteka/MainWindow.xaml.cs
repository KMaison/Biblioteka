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
        public int id;
        public bool canAdd = false, canDelete = false, canUpdate = false, canRead = false;
    }



    public partial class MainWindow : Window
    {
        Role admin = new Role() { id = 1, canAdd = true, canDelete = true, canUpdate = true, canRead = true };
        Role user = new Role() { id = 2, canAdd = false, canDelete = false, canUpdate = false, canRead = true };
        Role editor = new Role() { id = 3, canAdd = false, canDelete = false, canUpdate = true, canRead = true };
        Role adder = new Role() { id = 4, canAdd = true, canDelete = false, canUpdate = false, canRead = true };

        bool zalogowany = false;
        bool ifUpdate = false;
        Role actualRole;

        SqlConnection polaczenie;
        public MainWindow()
        {
            InitializeComponent();
            try
            {
                polaczenie = new SqlConnection(@"Data source=localhost;
                                                             database=Biblioteka;
                                                            Integrated Security = True");
                polaczenie.Open();
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
            switch (login.Text)
            {
                case "login":
                    if (password.Password == "123")
                    {
                        zalogowany = true;
                        roles.Items.Add("Admin");
                        roles.Items.Add("User");
                    }
                    break;
                case "login2":
                    if (password.Password == "123")
                    {
                        zalogowany = true;
                        roles.Items.Add("Editor");
                        roles.Items.Add("Adder");
                    }
                    break;
            }
            if (zalogowany == true)
            {
                roles.UpdateLayout();
                login.IsEnabled = false;
                password.IsEnabled = false;
                button1.IsEnabled = false;
            }

        }


        private void _do_Click(object sender, RoutedEventArgs e)
        {
            SqlCommand biblioteka = polaczenie.CreateCommand();
            biblioteka.CommandText = $"SELECT * FROM [Ksiazka]";
            SqlDataReader czytnik = biblioteka.ExecuteReader();

            DataTable dt = new DataTable();

            dt.Columns.Add("Tytul");
            dt.Columns.Add("Rok_wydania");
            dt.Columns.Add("Autor");
            dt.Columns.Add("Id_ksiazki");

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

        private bool readActualRole()
        {
            SqlCommand biblioteka = polaczenie.CreateCommand();
            biblioteka.CommandText = $"SELECT Actual_role FROM [Users] WHERE User_name = {login.Text}";
            SqlDataReader czytnik = biblioteka.ExecuteReader();
            string role = "";

            while (czytnik.Read())
            {
                role = czytnik["Actual_role"].ToString();
            }

            if (role.Equals("Admin"))
                actualRole = admin;
            if (role.Equals("Editor"))
                actualRole = editor;
            if (role.Equals("User"))
                actualRole = user;
            if (role.Equals("Adder"))
                actualRole = adder;

            return !role.Equals("");
        }

        private void Kolumna_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            doButton.IsEnabled = true;
        }

        private void Roles_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (roles.SelectedItem.Equals("Admin"))
                actualRole = admin;
            if (roles.SelectedItem.Equals("Editor"))
                actualRole = editor;
            if (roles.SelectedItem.Equals("User"))
                actualRole = user;
            if (roles.SelectedItem.Equals("Adder"))
                actualRole = adder;

            SqlCommand biblioteka = polaczenie.CreateCommand();
            biblioteka.CommandText = $"UPDATE Users SET Actual_role = {roles.SelectedItem} WHERE User_name = {login.Text}";
            if (biblioteka.ExecuteNonQuery() == 0)
            {
                biblioteka.CommandText = $"INSERT INTO Users VALUES({login.Text}, {roles.SelectedItem})";
                biblioteka.ExecuteNonQuery();
            }
        }

        private void ListBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {

        }

        private void DataTable_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {

        }

        private void addRow_Click(object sender, RoutedEventArgs e)
        {
            string title = titleTB.Text;
            string pubYear = pubYearTB.Text;
            string author = authorTB.Text;
            string bookId = bookIdTB.Text;


            try
            {
                if (ifUpdate == true)
                {
                    SqlCommand updateBook = polaczenie.CreateCommand();
                    updateBook.CommandText = $"UPDATE Ksiazka SET Tytul = '{title}', Rok_wydania = '{pubYear}', Autor = '{author}' WHERE Id_ksiazki = '{bookId}'";

                    if (updateBook.ExecuteNonQuery() == 0)
                        MessageBox.Show("Błędny format danych!");
                }
                else
                {
                    SqlCommand newBook = polaczenie.CreateCommand();
                    newBook.CommandText = $"INSERT INTO Ksiazka (Tytul, Rok_wydania, Autor, Id_ksiazki) VALUES('{title}', '{pubYear}', '{author}', '{bookId}')";

                    if (newBook.ExecuteNonQuery() == 0)
                        MessageBox.Show("Błędny format danych!");
                }

                addRow.Content = "Dodaj wiersz";
                bookIdTB.IsEnabled = true;
                ifUpdate = false;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void editButton_Click(object sender, RoutedEventArgs e)
        {
            DataRowView row = (DataRowView)dataTable.SelectedItem;

            titleTB.Text = row.Row.ItemArray[0].ToString();
            pubYearTB.Text = row.Row.ItemArray[1].ToString();
            authorTB.Text = row.Row.ItemArray[2].ToString();
            bookIdTB.Text = row.Row.ItemArray[3].ToString();
            bookIdTB.IsEnabled = false;

            addRow.Content = "Aktualizuj";
            ifUpdate = true;
            //MessageBox.Show("Ok!");
        }

        private void deleteButton_Click(object sender, RoutedEventArgs e)
        {
            DataRowView row = (DataRowView)dataTable.SelectedItem;
            string bookId = row.Row.ItemArray[3].ToString();

            SqlCommand deleteBook = polaczenie.CreateCommand();
            deleteBook.CommandText = $"DELETE FROM Ksiazka WHERE Id_Ksiazki = {bookId}";

            if (deleteBook.ExecuteNonQuery() == 0)
                MessageBox.Show("Błędny format danych!");

        }
    }
}

