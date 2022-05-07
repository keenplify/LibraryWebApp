<%@ Page Title="Admin - Borrow Book" Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="AdminUserBorrowBook.aspx.cs" Inherits="LibraryWebApp.AdminUserBorrowBook" %>

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
                    <li>
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
                        <a href="/AdminUsers" class="active">
                            <i data-feather="users"></i>
                            Users
                        </a>
                    </li>
                </ul>
            </nav>

            <!-- Page Content Holder -->
            <div id="content" class="container">
                <div class="d-md-flex mt-2">
                    <div class="mr-auto text-center">
                        <h1>Borrowing book for:</h1>
                        <h2><%=user["first_name"] %> <%=user["last_name"] %></h2>
                    </div>
                    <div class="form-inline">
                        <asp:Panel ID="pnlSearch" runat="server" DefaultButton="SearchBtn">
                            <asp:TextBox runat="server" ID="SearchKeyword" class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search" />
                            <asp:Button ID="SearchBtn" type="submit" runat="server" class="btn btn-outline-success my-2 my-sm-0" Text="Search" OnClick="SearchClick" />
                        </asp:Panel>
                    </div>
                </div>
                <table class="table table-striped w-100 my-2">
                    <thead>
                        <tr>
                            <td>Image</td>
                            <td>Title</td>
                            <td>Author</td>
                            <td>Available Stocks</td>
                            <td>Action</td>
                        </tr>
                    </thead>
                    <tbody>
                        <%foreach (var book in booksList) { %>
                            <tr>
                                <td><img class="img-fluid" style="max-width: 4em" src="<%=book["cover_image_location"] %>" /></td>
                                <td><%=book["title"] %></td>
                                <td><%=book["author"] %></td>
                                <td><%=book["availableStocks"] %></td>
                                <td><a href="AdminBorrowBookForm?user_id=<%=user["id"] %>&book_id=<%=book["id"] %>" class="btn btn-primary <%=((int)book["availableStocks"]) <= 0 ? "disabled" : "" %>">Borrow Book</a></td>
                            </tr>
                        <%} %>
                    </tbody>
                </table>
            </div>
        </div>
</asp:Content>