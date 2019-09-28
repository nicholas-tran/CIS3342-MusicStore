using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Utilities;

namespace MusicStoreLibrary
{
    class Calculations
    {

        internal decimal calculatePrice(int ID, string format)
        {
            DBConnect objDB = new DBConnect();
            string command = "SELECT Price FROM dbo.Songs WHERE SongID =" + ID;
            DataSet ds = objDB.GetDataSet(command);
            decimal basePrice = Convert.ToDecimal(ds.Tables[0].Rows[0]["Price"]);
            decimal price = 0;
            switch (format)
            {
                case "vinyl":
                    price = basePrice + 3.00m;
                    break;
                case "digital":
                    price = basePrice + 2.00m;
                    break;
                case "stream":
                    price = basePrice + 1.00m;
                    break;
            }
            return price;
        }

        internal decimal calculateTotal(int quantity, decimal price)
        {
            return price * quantity;
        }
    }
}
