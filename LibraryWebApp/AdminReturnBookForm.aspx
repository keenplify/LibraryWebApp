<%@ Page Language="C#" Title="Return Book" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminReturnBookForm.aspx.cs" Inherits="LibraryWebApp.AdminReturnBookForm" %>

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
                        <a href="/AdminTransactions">
                            <i data-feather="list"></i>
                            Transactions
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
            <div id="content" class="my-2 w-100">

                <h2>Return a Book</h2>
                <div class="row">
                    <div class="col-md-4">
                        <% if (isOnError)
                            {%>
                        <div class="alert alert-warning" role="alert">
                          The return code you've inputted is either incorrect or has already been returned.
                        </div>
                        <%} %>
                        <asp:Panel ID="pnlReturnLookup" runat="server" DefaultButton="ReturnLookupBtn">
                            <div class="form-group">
                                <label for="ReturnCode" class="font-weight-bold">Insert Book Return Code</label>
                                <asp:TextBox runat="server" type="text" MaxLength="6" ID="ReturnCode" style="font-size: 3em;" class="form-control mr-sm-2 input-lg" placeholder="000000" aria-label="Return Code" />

                                <small class="form-text text-muted">Please request the return code of the book.</small>
                            </div>
                            <asp:Button ID="ReturnLookupBtn" type="submit" runat="server" class="btn btn-success my-2 my-sm-0" Text="Search" OnClick="ReturnLookupBtn_Click" />
                        </asp:Panel>
                    </div>
                    <div class="col-md-6">
                        <% if (Transaction != null)
                            { %>
                        <h3 class="font-weight-bold">Book Information</h3>
                        <div class="row">
                           <div class="col-md-3">
                               <img src="<%=Transaction["cover_image_location"] %>" class="img-fluid"/>
                           </div>
                           <div class="col-md-8 my-2">
                               <h4 class="font-weight-bold badge badge-primary" style="font-size: 1.5em"><%=Transaction["title"] %></h4>
                               <div>
                                   <label class="font-weight-bold">Returnee: </label>
                                   <%=Transaction["first_name"] %> <%=Transaction["last_name"] %>
                               </div>
                               <div>
                                   <label class="font-weight-bold">Expected Date of Return: </label>
                                   <%=Transaction["date_of_return"] %>
                               </div>
                           </div>
                        </div>
                        <h3 class="font-weight-bold mt-3">Return this book</h3>
                        <asp:Panel ID="pnlReturnBookForm" runat="server" DefaultButton="ReturnBookBtn">
                            <div class="form-check">
                                <asp:CheckBox runat="server" class="form-check-input" type="checkbox" value="" name="IncludePenalty" ID="IncludePenaltyCheckbox" OnCheckedChanged="IncludePenalty_CheckedChanged" AutoPostBack="true" />
                                <label class="form-check-label" for="IncludePenalty">
                                Include a penalty
                                </label>
                            </div>
                            <%if (isOnPenalty)
                                { %>
                            <div class="form-group">
                                <% if (isOnLate)
                                    {%>
                                <div class="alert alert-warning" role="alert">
                                    We've detected that <b>this return is late</b> and have automatically set a penalty.
                                </div>
                                <%} %>
                                <label for="Description">Add Penalty Description</label>
                                <asp:TextBox runat="server" TextMode="MultiLine" ID="Description" name="Description" CssClass="form-control" required="true"/>
                                <small class="form-text text-muted">Please insert the reason for a penalty.</small>
                            </div>
                            <%} %>
                            
                            <asp:Button ID="ReturnBookBtn" type="submit" runat="server" class="btn btn-success my-2 my-sm-0" Text="Return Book" OnClick="ReturnBookBtn_Click" />
                        </asp:Panel>
                        <%} %>

                    </div>
                </div>
            </div>
        </div>
</asp:Content>