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
                                        <asp:TextBox runat="server" ID="Author" TextMode="MultiLine" class="form-control" title="Author"/>
                                    </div>
                                    <div class="col-md-6 my-2">
                                        <label for="ISBN" class="form-label">ISBN</label>
                                        <asp:TextBox runat="server" ID="ISBN" TextMode="MultiLine" class="form-control" title="ISBN" />
                                    </div>
                                    <div class="col-md-6 my-2">
                                        <label for="PublisherID" class="form-label">Publisher ID</label>
                                        <asp:TextBox runat="server" ID="PublisherID" TextMode="MultiLine" class="form-control" title="PublisherID"/>
                                    </div>
                                    <div class="col-md-6 my-2">
                                        <label for="Pages" class="form-label">Pages</label>
                                        <asp:TextBox runat="server" ID="Pages" type="number" class="form-control" title="Pages"/>
                                    </div>
                                    <div class="col-md-6 my-2">
                                        <label for="BookType" class="form-label">Book Type</label>
                                        <asp:TextBox runat="server" ID="BookType" TextMode="MultiLine" class="form-control" title="BookType"/>
                                    </div>
                                    <div class="col-md-6 my-2">
                                        <label for="PublishingDate" class="form-label">Publishing Date</label>
                                        <asp:TextBox runat="server" ID="PublishingDate" TextMode="Date" class="form-control" title="PublishingDate"/>
                                    </div>
                                    <div class="col-md-6 my-2">
                                        <label for="Stock" class="form-label">Stock</label>
                                        <asp:TextBox runat="server" ID="Stock" type="number" class="form-control disabled" title="Stock" disabled="true"/>
                                    </div>
                                    <div class="col-md-6 my-2">
                                        <asp:Panel runat="server" ID="ModifyStockPnl">
                                            <div class="font-weight-bold text-center">Modify Stock</div>
                                            <asp:RadioButtonList runat="server" ID="StockMode" RepeatLayout="Flow" CssClass="btn-group colors w-100" data-toggle="buttons">
                                                <asp:ListItem Text="Add" Value="+" class="btn btn-success active" Selected="True"/>
                                                <asp:ListItem Text="Remove" Value="-" class="btn btn-danger"/>
                                            </asp:RadioButtonList>
                                            <asp:TextBox runat="server" ID="StockModTbx" type="number" class="form-control disabled my-1" min="0" title="Stock" required="true"/>
                                            <asp:Button ID="UpdateStockBtn" type="submit" runat="server" class="btn btn-success w-100" Text="Update Stock" OnClick="UpdateStockBtn_Click" />
                                        </asp:Panel>
                                    </div>
                                    <div class="col-md-6 my-2">
                                        <asp:Button ID="UpdateBookBtn" type="submit" runat="server" class="btn btn-success w-100 my-1" Text="Update Book" OnClick="Update_Book" />
                                        <button type="button" class="btn btn-danger w-100 my-1" data-toggle="modal" data-target="#deleteModal">Delete Book</button>
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
                            </asp:Panel>
                            <div class="mt-2">
                                
                            </div>
                        </div>
                    </div>
                </div>
                <%} %>
            </div>
        </div>
</asp:Content>