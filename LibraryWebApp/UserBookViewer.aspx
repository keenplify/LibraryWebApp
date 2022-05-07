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
                        </div>
                        <div class="col-md-offset-1 col-md-6">
                            <div class="d-flex flex-column">
                                <label><b class="mr-2">Publisher:</b><%=Book["publisher"] %></label>
                                <label><b class="mr-2">Publisher ID:</b><%=Book["publisher_id"] %></label>
                                <label><b class="mr-2">Author:</b><%=Book["author"] %></label>
                                <label><b class="mr-2">ISBN:</b><%=Book["isbn"] %></label>
                                <label><b class="mr-2">Pages:</b><%=Book["pages"] %></label>
                                <label><b class="mr-2">Book Type:</b><%=Book["book_type"] %></label>
                                <label><b class="mr-2">Publishing Date:</b><%=Book["publishing_date"] %></label>

                                <label><b class="mr-2">Available Stocks:</b><%=Book["availableStocks"] %></label>
                            </div>
                        </div>
                    </div>
                </div>
                <%} %>
        </div>
    </div>
</asp:Content>