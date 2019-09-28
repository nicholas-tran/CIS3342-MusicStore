<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MusicStore.aspx.cs" Inherits="MusicStore.MusicStore" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="styles/MusicStoreStyleSheet.css" rel="stylesheet" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Music Store</title>
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />

    <!-- jQuery library -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

    <!-- Latest compiled JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
    <header>Nick's Music Store</header>
    <div class="container-fluid" id="content">
        <form id="form1" runat="server">
            <br />
            <div class="container-fluid" id="navigation">
                <ul class="nav">
                    <li>
                        <asp:Button ID="btnSongStatistics1" runat="server" Text="Song Statistics By Song" OnClick="btnSongStatistics1_Click" />
                        <asp:Button ID="btnReturn1" runat="server" Text="Return" OnClick="btnReturn1_Click" Visible="False" />
                    </li>
                    <li>
                        <asp:Button ID="btnSongStatistics2" runat="server" Text="Song Statistics By Genre" OnClick="btnSongStatistics2_Click" />
                        <asp:Button ID="btnReturn2" runat="server" Text="Return" OnClick="btnReturn2_Click" Visible="False" />
                    </li>
                    <li>
                        <asp:Button ID="btnSubscriptionStatistics" runat="server" Text="Subscription Statistics" OnClick="btnSubscriptionStatistics_Click" />
                        <asp:Button ID="btnReturn3" runat="server" Text="Return" OnClick="btnReturn3_Click" Visible="False" />
                    </li>
                </ul>
            </div>
            <br />
            <div class="input">
                <div class="container-fluid" id="validatorSummary">
                    <asp:ValidationSummary runat="server" HeaderText="There were errors on the page:" ValidationGroup="AllValidators" ForeColor="Red" />
                    <asp:Label ID="lblValidation" runat="server" ForeColor="Red"></asp:Label>
                </div>
                <div class="container-fluid" id="userInput">
                    <asp:Table ID="tblUserInput" runat="server" ControlToValidate="txtPhoneNumber">
                        <asp:TableRow>
                            <asp:TableCell>
                            Name:
                            </asp:TableCell>
                            <asp:TableCell>
                                <asp:TextBox ID="txtName" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="reqName" runat="server" ErrorMessage="Name cannot be blank." ValidationGroup="AllValidators" EnableClientScript="False" ControlToValidate="txtName" Text=" *" ForeColor="Red"></asp:RequiredFieldValidator>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>
                            Address:
                            </asp:TableCell>
                            <asp:TableCell>
                                <asp:TextBox ID="txtAddress" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="reqAddress" runat="server" ErrorMessage="Address cannot be blank." ValidationGroup="AllValidators" EnableClientScript="False" ControlToValidate="txtAddress" Text=" *" ForeColor="Red"></asp:RequiredFieldValidator>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>
                            Phone Number:
                            </asp:TableCell>
                            <asp:TableCell>
                                <asp:TextBox ID="txtPhoneNumber" runat="server" MaxLength="10"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="reqPhoneNumber" runat="server" ErrorMessage="Phone number cannot be blank." ValidationGroup="AllValidators" EnableClientScript="False" ControlToValidate="txtPhoneNumber" Text=" *" ForeColor="Red"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator runat="server" id="rexPhoneNumber" controltovalidate="txtPhoneNumber" ValidationGroup="AllValidators" EnableClientScript="False" validationexpression="^[0-9]{10}$" Text=" *" ForeColor="Red" errormessage="Please enter a 10 digit phone number!" />
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>
                            Credit Card Number:
                            </asp:TableCell>
                            <asp:TableCell>
                                <asp:TextBox ID="txtCreditCardNumber" runat="server" MaxLength="16"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="reqCreditCardNumber" runat="server" ErrorMessage="Credit card number cannot be blank." ValidationGroup="AllValidators" EnableClientScript="False" ControlToValidate="txtCreditCardNumber" Text=" *" ForeColor="Red"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator runat="server" id="rexCreditCardNumber" controltovalidate="txtCreditCardNumber" ValidationGroup="AllValidators" EnableClientScript="False" validationexpression="^[0-9]{16}$" Text=" *" ForeColor="Red" errormessage="Please enter a 16 digit credit card number!" />
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>
                Expiration Date:
                            </asp:TableCell>
                            <asp:TableCell>
                                Month:
                            <asp:TextBox ID="txtCreditCardMonth" runat="server" MaxLength="2"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="reqCreditCardMonth" runat="server" ErrorMessage="Credit card expiration month cannot be blank." ValidationGroup="AllValidators" EnableClientScript="False" ControlToValidate="txtCreditCardMonth" Text=" *" ForeColor="Red"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator runat="server" id="rexCreditCardMonth" controltovalidate="txtCreditCardMonth" ValidationGroup="AllValidators" EnableClientScript="False" validationexpression="^([1-9]|1[0-2])$" Text=" *" ForeColor="Red" errormessage="Please enter up to 2 digit month!" />
                                Year:<asp:TextBox ID="txtCreditCardYear" runat="server" MaxLength="4"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="reqCreditCardYear" runat="server" ErrorMessage="Credit card year cannot be blank." ValidationGroup="AllValidators" EnableClientScript="False" ControlToValidate="txtCreditCardYear" Text=" *" ForeColor="Red"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator runat="server" id="rexCreditCardYear" controltovalidate="txtCreditCardYear" ValidationGroup="AllValidators" EnableClientScript="False" validationexpression="^(2018|2019|20[2-9][0-9])$" Text=" *" ForeColor="Red" errormessage="Please enter a 4 digit year in range 2018-2100!" />
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>
                Payment Method:
                            </asp:TableCell>
                            <asp:TableCell>
                                <asp:DropDownList ID="drpdwnPayment" runat="server">
                                    <asp:ListItem Value="monthly">Monthly Auto-Pay ($2)</asp:ListItem>
                                    <asp:ListItem Value="annual">Annual Service ($20)</asp:ListItem>
                                    <asp:ListItem Value="one">One Time Charge ($5)</asp:ListItem>
                                </asp:DropDownList>
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </div>
                <br />
                <div class="container-fluid" id="gridViewSongs">
                    <asp:GridView ID="gvProducts" runat="server" AutoGenerateColumns="False" DataKeyNames="SongID,Price" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical">
                        <AlternatingRowStyle BackColor="#CCCCCC" />
                        <Columns>
                            <asp:TemplateField HeaderText="Select Song">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkSelect" runat="server" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="SongTitle" HeaderText="Song Title" />
                            <asp:BoundField DataField="MusicArtist" HeaderText="Music Artist" />
                            <asp:TemplateField HeaderText="Media Format">
                                <ItemTemplate>
                                    <asp:DropDownList ID="ddFormat" runat="server" AutoPostBack="True">
                                        <asp:ListItem Value="vinyl">Vinyl</asp:ListItem>
                                        <asp:ListItem Value="digital">Digital</asp:ListItem>
                                        <asp:ListItem Value="stream">Stream-only</asp:ListItem>
                                    </asp:DropDownList>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Add Qty">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtQtyAdd" runat="server" Height="20px" Width="64px"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <FooterStyle BackColor="#CCCCCC" />
                        <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                        <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                        <SortedAscendingCellStyle BackColor="#F1F1F1" />
                        <SortedAscendingHeaderStyle BackColor="#808080" />
                        <SortedDescendingCellStyle BackColor="#CAC9C9" />
                        <SortedDescendingHeaderStyle BackColor="#383838" />
                    </asp:GridView>
                    <br />
                    <asp:Button ID="btnOrder" runat="server" OnClick="BtnOrder_Click" Text="Submit Order" ValidationGroup="AllValidators" />
                </div>
            </div>
            <div class="output">
                <div class="container-fluid" id="userOutput">
                    <asp:Table ID="userOutputTable" runat="server" Visible="false">
                        <asp:TableRow>
                            <asp:TableCell>
                                <asp:Label runat="server" ID="lblName" value="Name"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>
                                <asp:Label runat="server" ID="lblAddress" value="Address"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>
                                <asp:Label runat="server" ID="lblPhoneNumber" value="Phone Number"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>
                                <asp:Label runat="server" ID="lblCreditCardNumber" value="Credit Card Number"></asp:Label>
                                <asp:Label runat="server" ID="lblCreditCardMonth" value="Credit Card Month"></asp:Label>
                                <asp:Label runat="server" ID="lblCreditCardYear" value="Credit Card Year"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>
                                <asp:Label runat="server" ID="lblPurchaseType" value="Purchase Type"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </div>
                <div class="container-fluid" id="gridViewOutput">
                    <asp:GridView ID="gvUserOutput" runat="server" AutoGenerateColumns="False" Visible="False" ShowFooter="True" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical">
                        <AlternatingRowStyle BackColor="#CCCCCC" />
                        <Columns>
                            <asp:BoundField DataField="songTitle" HeaderText="Song Title">
                                <FooterStyle Font-Bold="True" />
                            </asp:BoundField>
                            <asp:BoundField DataField="formatType" HeaderText="Format Type" />
                            <asp:BoundField DataField="quantity" HeaderText="Quantity">
                                <FooterStyle Font-Bold="True" />
                            </asp:BoundField>
                            <asp:BoundField DataField="price" HeaderText="Price" />
                            <asp:BoundField DataField="totalCost" HeaderText="TotalCost">
                                <FooterStyle Font-Bold="True" />
                            </asp:BoundField>
                        </Columns>
                        <FooterStyle BackColor="#CCCCCC" />
                        <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                        <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                        <SortedAscendingCellStyle BackColor="#F1F1F1" />
                        <SortedAscendingHeaderStyle BackColor="#808080" />
                        <SortedDescendingCellStyle BackColor="#CAC9C9" />
                        <SortedDescendingHeaderStyle BackColor="#383838" />
                    </asp:GridView>
                    <br />
                    <asp:Label ID="lblSubscriptionNotification" runat="server" Text="Your subscription type was added to the Total Cost: $" Visible="False"></asp:Label>
                </div>
            </div>
            <div class="statistics">
                <div class="container-fluid" id="songStatistics1">
                    <asp:GridView ID="gvSongStatistics1" runat="server" AutoGenerateColumns="False" Visible="False" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical">
                        <AlternatingRowStyle BackColor="#CCCCCC" />
                        <Columns>
                            <asp:BoundField DataField="SongTitle" HeaderText="Song Title"></asp:BoundField>
                            <asp:BoundField DataField="MusicArtist" HeaderText="artist" />
                            <asp:BoundField DataField="Genre" HeaderText="Genre"></asp:BoundField>
                            <asp:BoundField DataField="TotalPurchases" HeaderText="Quantity" />
                        </Columns>
                        <FooterStyle BackColor="#CCCCCC" />
                        <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                        <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                        <SortedAscendingCellStyle BackColor="#F1F1F1" />
                        <SortedAscendingHeaderStyle BackColor="#808080" />
                        <SortedDescendingCellStyle BackColor="#CAC9C9" />
                        <SortedDescendingHeaderStyle BackColor="#383838" />
                    </asp:GridView>
                </div>
                <div class="container-fluid" id="songStatistics2">
                    <asp:GridView ID="gvSongStatistics2" runat="server" AutoGenerateColumns="False" Visible="False" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical">
                        <AlternatingRowStyle BackColor="#CCCCCC" />
                        <Columns>
                            <asp:BoundField DataField="Genre" HeaderText="Genre"></asp:BoundField>
                            <asp:BoundField DataField="TotalPurchases" HeaderText="Quantity" />
                        </Columns>
                        <FooterStyle BackColor="#CCCCCC" />
                        <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                        <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                        <SortedAscendingCellStyle BackColor="#F1F1F1" />
                        <SortedAscendingHeaderStyle BackColor="#808080" />
                        <SortedDescendingCellStyle BackColor="#CAC9C9" />
                        <SortedDescendingHeaderStyle BackColor="#383838" />
                    </asp:GridView>
                </div>
                <div class="container-fluid" id="subscriptionStatistics">
                    <asp:GridView ID="gvSubscriptionStatistics" runat="server" AutoGenerateColumns="False" Visible="False" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical">
                        <AlternatingRowStyle BackColor="#CCCCCC" />
                        <Columns>
                            <asp:BoundField DataField="MonthlyTotal" HeaderText="Monthly Total"></asp:BoundField>
                            <asp:BoundField DataField="OneTimePurchaseTotal" HeaderText="One Time Purchase Total" />
                            <asp:BoundField DataField="AnnualTotal" HeaderText="Annual Total"></asp:BoundField>
                        </Columns>
                        <FooterStyle BackColor="#CCCCCC" />
                        <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                        <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                        <SortedAscendingCellStyle BackColor="#F1F1F1" />
                        <SortedAscendingHeaderStyle BackColor="#808080" />
                        <SortedDescendingCellStyle BackColor="#CAC9C9" />
                        <SortedDescendingHeaderStyle BackColor="#383838" />
                    </asp:GridView>
                </div>
            </div>
        </form>
    </div>
</body>
</html>
