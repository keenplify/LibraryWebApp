<%@ Page Title="Book Viewer"  Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="UserBookViewer.aspx.cs" Inherits="LibraryWebApp.UserBookViewer" %>

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
            <% if (!bookFound)
                    { %>
                    <h1>Book not found!</h1>
                <%}
                    else
                    { %>
                <div class="my-3">
                    <h2 class="font-weight-bold"><%=Book["title"] %></h2>
                     <div>
                        Added By: <b class="font-weight-bold"><%=Book["first_name"] %> <%=Book["last_name"] %></b>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <img src="<%=Book["cover_image_location"] %>" class="rounded img-fluid" />
                            <div class="d-flex flex-column">
                                <label><b>Publisher:</b><br /><%=Book["publisher"] %></label>
                                <label><b>Author:</b><br /><%=Book["author"] %></label>
                                <label><b>Available Stocks:</b><br /><%=Book["availableStocks"] %></label>
                            </div>
                        </div>
                        <div class="col-md-offset-1 col-md-6">
                            
                        </div>
                    </div>
                </div>
                <%} %>
        </div>
    </div>
</asp:Content>