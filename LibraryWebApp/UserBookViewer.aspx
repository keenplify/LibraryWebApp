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
                            <asp:Panel ID="pnlCreateTransaction" runat="server" DefaultButton="CreateTransaction">
                                <h3 class="font-weight-bold">Borrow this Book</h3>
                                <% if (Convert.ToInt32(Book["availableStocks"]) <= 0)
                                    { %>
                                <div class="alert alert-danger" role="alert">
                                    <h4 class="alert-heading">Not enough stock!</h4>
                                    <p>This book is unavailable for borrowing.</p>
                                </div>
                                <%}
                                    else
                                    {%>
                                <div class="alert alert-info" role="alert">
                                    <h4 class="alert-heading">Additional Information</h4>
                                    <p>You can only borrow a book for less than 7 days. If you didn't return the book in the date that you have chosen, you will get a <a href="UserPenalties" class="alert-link">penalty</a>.</p>
                                </div>
                                <div class="row">
                                    <div class="col-md-6 my-2">
                                        <label for="DateOfReturn" class="form-label">Date Of Return
                                        </label>
                                        <asp:TextBox runat="server" type="date" ID="DateOfReturn" class="form-control" placeholder="Date of Return" required="true" ToolTip="Date of Return"/>
                                    </div>
                                </div>
                                <asp:Button ID="CreateTransaction" type="submit" runat="server" class="btn btn-success w-50" Text="Borrow Book" OnClick="CreateTransaction_Click" />
                                <%} %>
                                
                            </asp:Panel>
                        </div>
                    </div>
                </div>
                <%} %>
        </div>
    </div>
</asp:Content>