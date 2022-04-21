<%@ Page Title="Browse Books" MasterPageFile="~/Site.Master" Language="C#" AutoEventWireup="true" CodeBehind="UserBooks.aspx.cs" Inherits="LibraryWebApp.UserBooks" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="wrapper">
            <nav id="sidebar">
                <ul class="list-unstyled components">
                    <li>
                        <a href="/UserDashboard">
                            <i data-feather="home"></i>
                            Home
                        </a>
                    </li>
                    <li class="active">
                        <a href="/UserBooks">
                            <i data-feather="book"></i>
                            Books
                        </a>
                    </li>
                    <li>
                        <a href="/UserTransactions">
                            <i data-feather="list"></i>
                            Transactions
                        </a>
                    </li>
                    <li>
                        <a href="/UserPenalties">
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
                    </div>
                </div>
                <div class="card-columns">
                <% foreach (var Book in BooksList)
                    { %>
                    <a href="/UserBookViewer?id=<%=Book["id"] %>">
                        <div class="card">
                        <img class="card-img-top book-image" src="<%=Book["cover_image_location"] %>" />
                        <div class="card-body">
                            <h5 class="card-title font-weight-bold"><%=Book["title"] %></h5>
                        </div>
                    </div>
                    </a>
                    <%} %>
                </div>
            </div>
        </div>
</asp:Content>