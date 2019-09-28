using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utilities;
using MusicStoreLibrary;

namespace MusicStore
{
    public partial class MusicStore : System.Web.UI.Page
    {
        DBConnect objDB = new DBConnect();
        protected void Page_Load(object sender, EventArgs e)
        {
            lblSubscriptionNotification.Text = "Your subscription type was added to the Total Cost: $";
            lblSubscriptionNotification.Visible = false;
            lblValidation.Text = "";
            if (!IsPostBack)
            {
                String strSQL = "SELECT * FROM dbo.Songs";
                gvProducts.DataSource = objDB.GetDataSet(strSQL);
                gvProducts.DataBind();
            }
        }

        protected void BtnOrder_Click(object sender, EventArgs e)
        {
            Page.Validate();
            if (Page.IsValid)
            {
                validateNumbers();
                if (lblValidation.Text != "")
                {
                    return;
                }
                ArrayList arrProducts = new ArrayList();    // used to store the ProductNumber for each selected product
                int count = 0;                              // used to count the number of selected products
                                                            // Iterate through the rows (records) of the GridView and store the ProductNumber
                                                            // for each row that is checked
                int songID;
                string title;
                int quantity;
                decimal price;
                string format;
                int totalQuantity = 0;
                decimal grandTotal = 0m;
                lblSubscriptionNotification.Visible = true;
                for (int row = 0; row < gvProducts.Rows.Count; row++)
                {
                    CheckBox CBox;
                    TextBox TBox;
                    DropDownList DropDownFormat;

                    // Get the reference for the chkSelect control in the current row
                    CBox = (CheckBox)gvProducts.Rows[row].FindControl("chkSelect");
                    if (CBox.Checked)
                    {
                        // Get the ProductNumber from the BoundField from the GridView for the current row
                        // and store the value in the array of selected products.
                        TBox = (TextBox)gvProducts.Rows[row].FindControl("txtQtyAdd");
                        songID = Convert.ToInt32(gvProducts.DataKeys[row].Values[0]);
                        title = gvProducts.Rows[row].Cells[1].Text;
                        quantity = Convert.ToInt32(TBox.Text);
                        totalQuantity += quantity;
                        price = Convert.ToDecimal(gvProducts.DataKeys[row].Values[1]);
                        DropDownFormat = (DropDownList)gvProducts.Rows[row].FindControl("ddFormat");
                        format = DropDownFormat.Text;
                        SongOrder song = new SongOrder(songID, title, quantity, price, format);
                        grandTotal += song.TotalCost;
                        arrProducts.Add(song);
                        count = count + 1;
                    }
                }
                string subscription = drpdwnPayment.SelectedValue;
                switch (subscription)
                {
                    case "monthly":
                        grandTotal += 2;
                        lblSubscriptionNotification.Text += "2";
                        break;
                    case "annual":
                        grandTotal += 20;
                        lblSubscriptionNotification.Text += "20";
                        break;
                    case "one":
                        grandTotal += 5;
                        lblSubscriptionNotification.Text += "5";

                        break;
                }
                //Show customer info
                showUserOutput();
                updateSubscriptionStatistics();
                allElementsHide();
                gvUserOutput.DataSource = arrProducts;
                gvUserOutput.Columns[0].FooterText = "Totals:";
                gvUserOutput.Columns[2].FooterText = Convert.ToString(totalQuantity);
                gvUserOutput.Columns[4].FooterText = Convert.ToString(grandTotal);
                gvUserOutput.DataBind();
            }
        }

        public void validateNumbers()
        {
            bool anyCBox = false;
            for (int row = 0; row < gvProducts.Rows.Count; row++)
            {
                CheckBox CBox;
                TextBox TBox;
                // Get the reference for the chkSelect control in the current row
                CBox = (CheckBox)gvProducts.Rows[row].FindControl("chkSelect");
                if (CBox.Checked)
                {
                    anyCBox = true;
                    // Get the ProductNumber from the BoundField from the GridView for the current row
                    // and store the value in the array of selected products.
                    TBox = (TextBox)gvProducts.Rows[row].FindControl("txtQtyAdd");
                    int quantity;
                    if(Int32.TryParse(TBox.Text, out quantity) == false)
                    {
                        Response.Write("<script>alert('Quantity must only be numbers.')</script>");
                        lblValidation.Text += "Quantity must only be numbers.<br>";
                        return;
                    }
                    else if (TBox.Text == "")
                    {
                        Response.Write("<script>alert('Quantity must not be blank.')</script>");
                        lblValidation.Text += "Quantity must only be numbers.<br>";
                        return;
                    }
                }
            }
            if (anyCBox == false)
            {
                Response.Write("<script>alert('A song must be checked before ordering.')</script>");
                lblValidation.Text += "A song must be checked before ordering.<br>";
                return;
            }
        }

        public void updateSubscriptionStatistics()
        {
            DBConnect objDB = new DBConnect();
            string subscription = drpdwnPayment.SelectedValue;
            switch (subscription)
            {
                case "monthly":
                    string command = "UPDATE dbo.PurchaseTypes SET MonthlyTotal = MonthlyTotal + '" + 1 + "'";
                    objDB.DoUpdate(command);
                    break;
                case "annual":
                    string command2 = "UPDATE dbo.PurchaseTypes SET AnnualTotal = AnnualTotal + '" + 1 + "'";
                    objDB.DoUpdate(command2);
                    break;
                case "one":
                    string command3 = "UPDATE dbo.PurchaseTypes SET OneTimePurchaseTotal = OneTimePurchaseTotal + '" + 1 + "'";
                    objDB.DoUpdate(command3);
                    break;
            }
        }

        public void allElementsHide()
        {
            gvProducts.Visible = false;
            tblUserInput.Visible = false;
            btnOrder.Visible = false;
        }
        public void allElementsShow()
        {
            gvProducts.Visible = true;
            tblUserInput.Visible = true;
            btnOrder.Visible = true;
        }
        public void showUserOutput()
        {
            userOutputTable.Visible = true;
            lblName.Text = "Name: " + txtName.Text;
            lblAddress.Text = "Address: " + txtAddress.Text;
            lblPhoneNumber.Text = "Phone Number: "+ txtPhoneNumber.Text;
            lblCreditCardNumber.Text = "Credit Card Number: "+ txtCreditCardNumber.Text;
            lblCreditCardMonth.Text = "Credit Card Expiration Month: "+ txtCreditCardMonth.Text;
            lblCreditCardYear.Text = "Credit Card Expiration Year: " + txtCreditCardYear.Text;
            lblPurchaseType.Text = "Purchase Type: "+ drpdwnPayment.SelectedValue;
            gvUserOutput.Visible = true;
        }

        public void hideUserOutput()
        {
            for (int row = 0; row < gvProducts.Rows.Count; row++)
            {
                CheckBox CBox;
                TextBox TBox;
                DropDownList DropDownFormat;

                // Get the reference for the chkSelect control in the current row
                CBox = (CheckBox)gvProducts.Rows[row].FindControl("chkSelect");
                TBox = (TextBox)gvProducts.Rows[row].FindControl("txtQtyAdd");
                DropDownFormat = (DropDownList)gvProducts.Rows[row].FindControl("ddFormat");
                if (CBox.Checked)
                {
                    CBox.Checked = false;
                }
                if (TBox.Text != "")
                {
                    TBox.Text = "";
                }
                DropDownFormat.SelectedIndex = 0;
            }
            userOutputTable.Visible = false;
            lblName.Text = "";
            lblAddress.Text = "";
            lblPhoneNumber.Text = "";
            lblCreditCardNumber.Text = "";
            lblCreditCardMonth.Text = "";
            lblCreditCardYear.Text = "";
            lblPurchaseType.Text = "";
            drpdwnPayment.SelectedIndex = 0;
            gvUserOutput.Visible = false;
        }

        protected void btnSongStatistics1_Click(object sender, EventArgs e)
        {
            gvSongStatistics1.Visible = true;
            String strSQL = "SELECT SongTitle, MusicArtist, Genre, TotalPurchases FROM dbo.Songs ORDER BY TotalPurchases desc";
            gvSongStatistics1.DataSource = objDB.GetDataSet(strSQL);
            gvSongStatistics1.DataBind();
            allElementsHide();
            btnReturn1.Visible = true;
            btnSongStatistics1.Visible = false;
            btnSongStatistics2.Visible = false;
            userOutputTable.Visible = false;
            gvUserOutput.Visible = false;
            btnSubscriptionStatistics.Visible = false;

        }

        protected void btnReturn1_Click(object sender, EventArgs e)
        {
            allElementsShow();
            btnReturn1.Visible = false;
            btnSongStatistics1.Visible = true;
            btnSongStatistics2.Visible = true;
            gvSongStatistics1.Visible = false;
            hideUserOutput();
            btnSubscriptionStatistics.Visible = true;

        }

        protected void btnSongStatistics2_Click(object sender, EventArgs e)
        {
            gvSongStatistics2.Visible = true;
            String strSQL = "SELECT Genre, TotalPurchases FROM dbo.Songs GROUP BY Genre, TotalPurchases";
            gvSongStatistics2.DataSource = objDB.GetDataSet(strSQL);
            gvSongStatistics2.DataBind();
            allElementsHide();
            btnReturn2.Visible = true;
            btnSongStatistics1.Visible = false;
            btnSongStatistics2.Visible = false;
            userOutputTable.Visible = false;
            gvUserOutput.Visible = false;
            btnSubscriptionStatistics.Visible = false;

        }

        protected void btnReturn2_Click(object sender, EventArgs e)
        {
            allElementsShow();
            btnReturn2.Visible = false;
            btnSongStatistics1.Visible = true;
            btnSongStatistics2.Visible = true;
            gvSongStatistics2.Visible = false;
            hideUserOutput();
            btnSubscriptionStatistics.Visible = true;

        }

        protected void btnSubscriptionStatistics_Click(object sender, EventArgs e)
        {
            gvSubscriptionStatistics.Visible = true;
            String strSQL = "SELECT MonthlyTotal, OneTimePurchaseTotal, AnnualTotal FROM dbo.PurchaseTypes";
            gvSubscriptionStatistics.DataSource = objDB.GetDataSet(strSQL);
            gvSubscriptionStatistics.DataBind();
            allElementsHide();
            btnReturn3.Visible = true;
            btnSongStatistics1.Visible = false;
            btnSongStatistics2.Visible = false;
            userOutputTable.Visible = false;
            gvUserOutput.Visible = false;
            btnSubscriptionStatistics.Visible = false;
        }

        protected void btnReturn3_Click(object sender, EventArgs e)
        {
            allElementsShow();
            gvSubscriptionStatistics.Visible = false;
            btnReturn3.Visible = false;
            btnSongStatistics1.Visible = true;
            btnSongStatistics2.Visible = true;
            gvSongStatistics1.Visible = false;
            hideUserOutput();
            btnSubscriptionStatistics.Visible = true;
        }
    }
}