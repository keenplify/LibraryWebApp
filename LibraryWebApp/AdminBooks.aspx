<%@ Page Title="Admin Books" Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="AdminBooks.aspx.cs" Inherits="LibraryWebApp.AdminBooks" %>

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
                <div class="d-md-flex">
                    <h1 class="mr-auto text-center">Books</h1>
                    <div class="form-inline">
                        <asp:Panel ID="pnlSearch" runat="server" DefaultButton="SearchBtn">
                            <asp:TextBox runat="server" ID="SearchKeyword" class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search" />
                            <asp:Button ID="SearchBtn" type="submit" runat="server" class="btn btn-outline-success my-2 my-sm-0" Text="Search" OnClick="SearchClick" />
                        </asp:Panel>
                        <a href="AdminAddBook" class="btn btn-primary ml-2"><i data-feather="plus"></i>Add Book</a>
                    </div>
                </div>
                <div class="card-columns">
                <% foreach (var Book in BooksList)
                {%>
                    <a href="/AdminBookViewer?id=<%=Book["id"] %>">
                        <div class="card">
                        <img class="card-img-top book-image" src="<%=Book["cover_image_location"] %>" />
                        <div class="card-body">
                            <h5 class="card-title font-weight-bold"><%=Book["title"] %></h5>
                            <p class="card-text">
                                Borrowed: <b class="font-weight-bold"><%=Book["transactionsActiveCount"] %></b> <br />
                                Available Stocks: <b class="font-weight-bold"><%=Book["availableStocks"] %></b> <% if ((int)Book["availableStocks"] != (int)Book["stock"] && (int)Book["availableStocks"] <= 2) { %>
                                    <span class="badge badge-danger">LOW STOCK</span>
                                <%} %>
                            </p>
                        </div>
                    </div>
                    </a>
                <%} %>
                </div>
            </div>
        </div>
</asp:Content>