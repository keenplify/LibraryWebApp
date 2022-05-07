<%@ Page Title="Admin Users" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminUsers.aspx.cs" Inherits="LibraryWebApp.AdminUsers" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="wrapper">
            <nav id="sidebar">
                <ul class="list-unstyled components">
                    <li class="active">
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
                        <a href="/AdminUsers">
                            <i data-feather="users"></i>
                            Users
                        </a>
                    </li>
                </ul>
            </nav>

            <!-- Page Content Holder -->
            <div id="content">
                <div class="d-flex mt-2">
                    <h2>Users</h2>
                    <div class="ml-auto">
                        <a href="AdminUserForm" class="btn btn-primary">Add User</a>
                    </div>
                </div>
                 <div class="form-inline">
                    <asp:Panel ID="pnlSearch" runat="server" DefaultButton="SearchBtn">
                        <asp:TextBox runat="server" ID="SearchKeyword" class="form-control mr-sm-1" type="search" placeholder="Search" aria-label="Search" />
                        <asp:Button ID="SearchBtn" type="submit" runat="server" class="btn btn-outline-success my-2 my-sm-0" Text="Search" OnClick="SearchBtn_Click"/>
                    </asp:Panel>
                </div>
                <table class="table table-striped w-100 my-2">
                    <thead>
                        <tr>
                            <th scope="col">Full Name</th>
                            <th scope="col">Birthday</th>
                            <th scope="col">Gender</th>
                            <th scope="col">Strand</th>
                            <th scope="col">Address</th>
                            <th scope="col">Phone Number</th>
                            <th scope="col">Email</th>
                            <th scope="col">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% foreach (var User in UsersList)
                            {%>
                        <tr>
                            <td><%=User["first_name"]  %> <%=User["last_name"]  %></td>
                            <td><%=User["birthday"]  %></td>
                            <td><%=User["gender"]  %></td>
                            <td><%=User["strand"]  %></td>
                            <td><%=User["address"]  %></td>
                            <td><%=User["phone_number"]  %></td>
                            <td><%=User["email"]  %></td>
                            <td>
                                <div class="row">
                                    <div class="col-md-6">
                                        <a class="btn btn-primary btn-sm m-1" href="AdminUserForm?prefillup_id=<%=User["id"] %>" title="Edit User">
                                          <i data-feather="edit"></i>
                                        </a>
                                    </div>
                                    <div class="col-md-6">
                                        <a class="btn btn-info btn-sm m-1" href="AdminUserBorrowBook?user_id=<%=User["id"] %>" title="Borrow Book with this User">
                                          <i data-feather="book"></i>
                                        </a>
                                    </div>
                                    <div class="col-md-6">
                                        <!-- Button trigger modal -->
                                        <button type="button" class="btn btn-danger btn-sm m-1" data-toggle="modal" data-target="#deleteUser<%=User["id"] %>Modal" title="Delete User">
                                            <i data-feather="trash"></i>
                                        </button>

                                        <!-- Modal -->
                                        <div class="modal fade" id="deleteUser<%=User["id"] %>Modal" tabindex="-1" role="dialog" aria-labelledby="deleteUser<%=User["id"] %>ModalLabel" aria-hidden="true">
                                            <div class="modal-dialog" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                <h5 class="modal-title" id="deleteUser<%=User["id"] %>ModalLabel">Delete <%=User["first_name"]  %> <%=User["last_name"]  %></h5>
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                                </div>
                                                <div class="modal-body">
                                                This will delete this user. Are you sure to continue?
                                                </div>
                                                <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                <a href="AdminDeleteUserLogic?id=<%=User["id"] %>" class="btn btn-danger">Delete User</a>
                                                </div>
                                            </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <!-- Button trigger modal -->
                                        <button type="button" class="btn btn-secondary btn-sm m-1" data-toggle="modal" data-target="#viewUser<%=User["id"] %>IdModal" title="View User School ID">
                                            <i data-feather="image"></i>
                                        </button>

                                        <!-- Modal -->
                                        <div class="modal fade" id="viewUser<%=User["id"] %>IdModal" tabindex="-1" role="dialog" aria-labelledby="viewUser<%=User["id"] %>IdModalLabel" aria-hidden="true">
                                            <div class="modal-dialog" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                <h5 class="modal-title" id="viewUser<%=User["id"] %>IdModalLabel">School ID of <%=User["first_name"]  %> <%=User["last_name"]  %></h5>
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                                </div>
                                                <div class="modal-body">
                                                    <img src="<%=User["school_id_image_location"] %>" class="img-fluid rounded my-5" style="box-shadow: 0 1em 3em rgba(0,0,0,0.12), 0 1em 3em rgba(0,0,0,0.24);"/>
                                                </div>
                                                <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                </div>
                                            </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <%} %>
                    </tbody>
                </table>
            </div>
        </div>
</asp:Content>