using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Utilities;

namespace MusicStoreLibrary
{
    public class SongOrder
    {
        int songID;
        string songTitle;
        int quantity;
        decimal price;
        decimal totalCost;
        string formatType;
        Calculations calculate = new Calculations();

        public SongOrder(){
        }

        public SongOrder(int ID, string Title, int quantity, decimal price, string format)
        {
            this.songID = ID;
            this.songTitle = Title;
            this.quantity = quantity;
            this.formatType = format;
            this.price = calculate.calculatePrice(ID, format);
            this.totalCost = calculate.calculateTotal(quantity,this.price);
            updateQuantityDB(this.songID, this.quantity);
        }

        public int SongID
        {
            get { return songID; }
            set { songID = value; }
        }
       

        public String SongTitle
        {
            get { return songTitle; }
            set { songTitle = value; }
        }

        public int Quantity
        {
            get { return quantity; }
            set { quantity = value; }
        }

        public decimal Price
        {
            get { return price; }
            set { price = value; }
        }

        public decimal TotalCost
        {
            get { return totalCost; }
            set { totalCost = value; }
        }

        public String FormatType
        {
            get { return formatType; }
            set { formatType = value; }
        }
        public void updateQuantityDB(int ID, int quantity)
        {
            DBConnect objDB = new DBConnect();
            string command = "UPDATE dbo.Songs SET TotalPurchases = TotalPurchases + '" + quantity + "'" +
                            " WHERE SongID = '" + ID + "'";
            objDB.DoUpdate(command);
        }
    }

}
