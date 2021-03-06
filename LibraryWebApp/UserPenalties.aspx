<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" Title="User Penalties" CodeBehind="UserPenalties.aspx.cs" Inherits="LibraryWebApp.UserPenalties" %>

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
                    <li>
                        <a href="/UserTransactions">
                            <i data-feather="list"></i>
                            Transactions
                        </a>
                    </li>
                    <li class="active">
                        <a href="/UserPenalties">
                            <i data-feather="alert-triangle"></i>
                            Penalties
                        </a>
                    </li>
                </ul>
            </nav>

            <!-- Page Content Holder -->
            <div id="content" class="mt-3 container">
                <div class="alert alert-success" role="alert">
                    <h4 class="alert-heading">Well done!</h4>
                    <p>Aww yeah, you successfully read this important alert message. This example text is going to run a bit longer so that you can see how spacing within an alert works with this kind of content.</p>
                    <hr>
                    <p class="mb-0">Whenever you need to, be sure to use margin utilities to keep things nice and tidy.</p>
                </div>
                <div class="d-md-flex">
                    <h2>Your Penalties</h2>
                    <div class="ml-auto">
                        <b>Active Penalties:</b> <h2><%=activePenalties %></h2>
                    </div>
                </div>
                <div class="form-inline">
                    <asp:Panel ID="pnlSearch" runat="server" DefaultButton="SearchBtn">
                        <asp:TextBox runat="server" ID="SearchKeyword" class="form-control mr-sm-1" type="search" placeholder="Search" aria-label="Search" />
                        <asp:Button ID="SearchBtn" type="submit" runat="server" class="btn btn-outline-success my-2 my-sm-0" Text="Search" OnClick="SearchBtn_Click" />
                    </asp:Panel>
                </div>
                
                <table class="table table-striped w-100 my-2">
                    <thead>
                        <tr>
                            <th scope="col">Punishment Description</th>
                            <th scope="col">Remarks</th>
                            <th scope="col">Punisher</th>
                            <th scope="col">Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%foreach (var Penalty in PenaltiesList)
                            { %>
                        <tr>
                            <td><%=Penalty["description"] %></td>
                            <td><%=Penalty["remarks"] %></td>
                            <td><%=Penalty["first_name"] %> <%=Penalty["last_name"] %></td>
                            <td>
                                <% if (Convert.ToInt32(Penalty["is_resolved"]) == 1)
                                    {%>
                                <div class="badge badge-success">Resolved</div>
                                <%}
                                    else
                                    {%>
                                <div class="badge badge-danger">Active</div>

                                <%} %>
                            </td>
                        </tr>
                        <%} %>
                    </tbody>
                </table>
            </div>
        </div>
</asp:Content>