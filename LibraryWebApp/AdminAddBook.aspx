<%@ Page Title="Add Book"  Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="AdminAddBook.aspx.cs" Inherits="LibraryWebApp.AdminAddBook" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="wrapper">
            <nav id="sidebar">
                <ul class="list-unstyled components">
                    <li>
                        <a href="/AdminDashboard">
                            <i data-feather="home"></i>
                            Home
                        </a>
                    </li>
                    <li class="active">
                        <a href="/AdminBooks">
                            <i data-feather="book"></i>
                            Books
                        </a>
                    </li>
                    <li>
                        <a href="/AdminReturnBookForm">
                            <i data-feather="corner-down-left"></i>
                            Return Book
                        </a>
                    </li>
                    <li>
                        <a href="/AdminTransactions">
                            <i data-feather="list"></i>
                            Transactions
                        </a>
                    </li>
                    <li>
                        <a href="/AdminPenalties">
                            <i data-feather="alert-triangle"></i>
                            Penalties
                        </a>
                    </li>
                </ul>
            </nav>

            <!-- Page Content Holder -->
            <div id="content" class="container">
                <div class="my-3">
                    <h2 class="font-weight-bold">Add Book</h2>
                    <asp:Panel ID="pnlAddBook" runat="server" DefaultButton="AddBookBtn">
                        <div class="row">
                            <div class="col-md-12 my-2">
                                <label for="Cover" class="form-label">Cover Photo</label>
                                <asp:FileUpload runat="server" ID="Cover" required="true" /> 
                            </div>
                            <div class="col-md-12 my-2">
                                <label for="BookTitle" class="form-label">Book Title</label>
                                <asp:TextBox runat="server" ID="BookTitle" TextMode="MultiLine" class="form-control" required="true"/>
                            </div>
                            <div class="col-md-12 my-2">
                                <label for="Publisher" class="form-label">Publisher</label>
                                <asp:TextBox runat="server" ID="Publisher" TextMode="MultiLine" class="form-control" title="Publisher" required="true"/>
                            </div>
                            <div class="col-md-12 my-2">
                                <label for="Author" class="form-label">Author</label>
                                <asp:TextBox runat="server" ID="Author" TextMode="MultiLine" class="form-control" Rows="3" title="Author" required="true"/>
                            </div>
                            <div class="col-md-12 my-2">
                                <label for="Stock" class="form-label">Stock</label>
                                <asp:TextBox runat="server" ID="Stock" type="number" class="form-control" title="Stock" required="true"/>
                            </div>
                        </div>
                        <asp:Button ID="AddBookBtn" type="submit" runat="server" class="btn btn-success" Text="Add Book" OnClick="Add_Book" />
                    </asp:Panel>
            </div>
        </div>
    </div>
</asp:Content>