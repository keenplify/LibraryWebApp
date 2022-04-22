<%@ Page Title="Book Viewer"  Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="AdminBookViewer.aspx.cs" Inherits="LibraryWebApp.AdminBookViewer" %>


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
                        <a href="/AdminReturnBookForm" class="active">
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
                            <asp:Panel ID="pnlUpdateImage" runat="server" DefaultButton="UpdateImageBtn">
                                <asp:Image runat="server" ID="CoverPhoto" class="rounded img-fluid" />
                                <div>
                                    <label for="UpdateCover" class="form-label">Update Cover Photo</label>
                                    <asp:FileUpload runat="server" ID="UpdateCover" /> 
                                    <asp:Button ID="UpdateImageBtn" type="submit" runat="server" class="btn btn-success mt-2" Text="Update Cover Photo" OnClick="UpdateImageBtn_Click" />
                                </div>
                            </asp:Panel>
                        </div>
                        <div class="col-md-offset-1 col-md-6">
                            <asp:Panel ID="pnlUpdateBook" runat="server" DefaultButton="UpdateBookBtn">
                                <div class="row">
                                    <div class="col-md-6 my-2">
                                        <label for="Publisher" class="form-label">Publisher</label>
                                        <asp:TextBox runat="server" ID="Publisher" TextMode="MultiLine" class="form-control" title="Publisher" required="true"/>
                                    </div>
                                    <div class="col-md-6 my-2">
                                        <label for="Author" class="form-label">Author</label>
                                        <asp:TextBox runat="server" ID="Author" TextMode="MultiLine" class="form-control" Rows="3" title="Author" required="true"/>
                                    </div>
                                    <div class="col-md-6 my-2">
                                        <label for="Stock" class="form-label">Stock</label>
                                        <asp:TextBox runat="server" ID="Stock" type="number" class="form-control" Rows="3" title="Stock" required="true"/>
                                    </div>
                                </div>
                                <asp:Button ID="UpdateBookBtn" type="submit" runat="server" class="btn btn-success w-50" Text="Update Book" OnClick="Update_Book" />
                            </asp:Panel>
                            <div class="mt-2">
                                <button type="button" class="btn btn-danger w-50" data-toggle="modal" data-target="#deleteModal">Delete Book</button>
                                <div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="deleteModalLabel" aria-hidden="true">
                                  <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                      <div class="modal-header">
                                        <h5 class="modal-title" id="deleteModalLabel">Delete Book</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                          <span aria-hidden="true">&times;</span>
                                        </button>
                                      </div>
                                      <div class="modal-body">
                                        Are you sure to delete this book?
                                      </div>
                                      <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                        <asp:Button runat="server" OnClick="Delete_Book" type="button" class="btn btn-danger" Text="Delete"/>
                                      </div>
                                    </div>
                                  </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <%} %>
            </div>
        </div>
</asp:Content>