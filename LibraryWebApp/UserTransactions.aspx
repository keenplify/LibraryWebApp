<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" Title="User Transactions" CodeBehind="UserTransactions.aspx.cs" Inherits="LibraryWebApp.UserTransactions" %>

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
                    <li>
                        <a href="/UserBooks">
                            <i data-feather="book"></i>
                            Books
                        </a>
                    </li>
                    <li class="active">
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
            <div id="content" class="mt-3 container">
                <h2>Your Transactions</h2>
                <div class="form-inline">
                    <asp:Panel ID="pnlSearch" runat="server" DefaultButton="SearchBtn">
                        <asp:TextBox runat="server" ID="SearchKeyword" class="form-control mr-sm-1" type="search" placeholder="Search" aria-label="Search" />
                        <asp:Button ID="SearchBtn" type="submit" runat="server" class="btn btn-outline-success my-2 my-sm-0" Text="Search" />
                    </asp:Panel>
                </div>
                
                <table class="table table-striped w-100 ">
                    <thead>
                        <tr>
                            <th scope="col">Book Cover</th>
                            <th scope="col">Book Name</th>
                            <th scope="col">Day of Return</th>
                            <th scope="col">Status</th>
                            <th scope="col">Return Code</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% foreach (var Transaction in TransactionsList)
                            { %>
                        <tr>
                            <td class="transaction-cover-td"><img src="<%=Transaction["cover_image_location"] %>" class="transaction-cover-image img-fluid"/></td>
                            <td><%=Transaction["title"] %></td>
                            <td>
                                <% if (Transaction["state"].ToString() == "BORROWED")
                                    {
                                        if (!(bool)Transaction["isLate"])
                                        { %>
                                    <div class="badge badge-primary text-size-large">
                                        Return <%=Transaction["timeago"] %>
                                    </div>
                                    <%}
                                        else
                                        { %>
                                    <div class="badge badge-danger text-size-large">
                                        LATE
                                    </div>
                                    <%}
                                        } %>
                                <div>
                                    <%=Transaction["date_of_return"] %>
                                </div>
                            </td>
                            <td><% if (Transaction["state"].ToString() == "BORROWED")
                                    { %>
                                <div class="badge badge-warning">
                                    <%=Transaction["state"] %>
                                </div>
                                <%}
                                    else
                                    { %>
                                <div class="badge badge-success">
                                    <%=Transaction["state"] %>
                                </div>
                                <%} %>
                            </td>
                            <td><h1 class="badge badge-success" style="font-size: 150%"><%=Transaction["return_code"] %></h1></td>
                        </tr>
                        <%} %>
                    </tbody>
                </table>
            </div>
        </div>
</asp:Content>