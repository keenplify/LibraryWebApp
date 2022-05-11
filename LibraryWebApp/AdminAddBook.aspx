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
                        <a href="/AdminPenalties">
                            <i data-feather="alert-triangle"></i>
                            Penalties
                        </a>
                    </li>
                    <li>
                        <a href="/AdminUsers">
                            <i data-feather="users"></i>
                            Users
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
                            <div class="col-md-6 my-2">
                                <label for="BookTitle" class="form-label">Book Title</label>
                                <asp:TextBox runat="server" ID="BookTitle" TextMode="MultiLine" class="form-control" required="true"/>
                            </div>
                            <div class="col-md-6 my-2">
                                <label for="Publisher" class="form-label">Publisher</label>
                                <asp:TextBox runat="server" ID="Publisher" TextMode="MultiLine" class="form-control" title="Publisher" required="true"/>
                            </div>
                            <div class="col-md-6 my-2">
                                <label for="Author" class="form-label">Author</label>
                                <asp:TextBox runat="server" ID="Author" TextMode="MultiLine" class="form-control" title="Author"/>
                            </div>
                            <div class="col-md-6 my-2">
                                <label for="ISBN" class="form-label">ISBN</label>
                                <asp:TextBox runat="server" ID="ISBN" TextMode="MultiLine" class="form-control" title="ISBN" />
                            </div>
                            <div class="col-md-6 my-2">
                                <label for="PublisherID" class="form-label">Publisher ID</label>
                                <asp:TextBox runat="server" ID="PublisherID" TextMode="MultiLine" class="form-control" title="PublisherID"/>
                            </div>
                            <div class="col-md-6 my-2">
                                <label for="Pages" class="form-label">Pages</label>
                                <asp:TextBox runat="server" ID="Pages" type="number" class="form-control" title="Pages"/>
                            </div>
                            <div class="col-md-6 my-2">
                                <label for="BookType" class="form-label">Book Type</label>
                                <asp:TextBox runat="server" ID="BookType" TextMode="MultiLine" class="form-control" title="BookType"/>
                            </div>
                            <div class="col-md-6 my-2">
                                <label for="PublishingDate" class="form-label">Publishing Date</label>
                                <asp:TextBox runat="server" ID="PublishingDate" TextMode="Date" class="form-control" title="PublishingDate"/>
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