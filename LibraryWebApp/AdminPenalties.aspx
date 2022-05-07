<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" Title="Admin Penalties" CodeBehind="AdminPenalties.aspx.cs" Inherits="LibraryWebApp.AdminPenalties" %>

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
                    <li class="active">
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
            <div id="content" class="mt-3 container">
                <div class="alert alert-success" role="alert">
                    <h4 class="alert-heading">Well done!</h4>
                    <p>Aww yeah, you successfully read this important alert message. This example text is going to run a bit longer so that you can see how spacing within an alert works with this kind of content.</p>
                    <hr>
                    <p class="mb-0">Whenever you need to, be sure to use margin utilities to keep things nice and tidy.</p>
                </div>
                <h2>Penalties</h2>
                <div class="form-inline">
                    <asp:Panel ID="pnlSearch" runat="server" DefaultButton="SearchBtn">
                        <asp:TextBox runat="server" ID="SearchKeyword" class="form-control mr-sm-1" type="search" placeholder="Search" aria-label="Search" />
                        <asp:Button ID="SearchBtn" type="submit" runat="server" class="btn btn-outline-success my-2 my-sm-0" Text="Search" />
                    </asp:Panel>
                </div>
                
                <table class="table table-striped w-100 my-2">
                    <thead>
                        <tr>
                            <th scope="col">Punishment Description</th>
                            <th scope="col">Remarks</th>
                            <th scope="col">Punished Student</th>
                            <th scope="col">Status</th>
                            <th scope="col">Change Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% foreach (var Penalty in PenaltiesList)
                            {%>
                        <tr>
                            <td><%=Penalty["description"] %></td>
                            <td><%=Penalty["remarks"] %></td>
                            <td><%=Penalty["first_name"]  %> <%=Penalty["last_name"]  %></td>
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
                            <td>
                                <a href="?toggleStatus=<%=Penalty["id"] %>&toggleStatusTo=<%=Convert.ToInt32(Penalty["is_resolved"]) == 0 ? 1 : 0%>" class="btn btn-primary">Toggle Status</a>
                            </td>
                        </tr>
                        <%} %>
                    </tbody>
                </table>
            </div>
        </div>
</asp:Content>