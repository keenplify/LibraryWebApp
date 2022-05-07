<%@ Page Title="Register User" Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="AdminUserForm.aspx.cs" Inherits="LibraryWebApp.AdminUserForm" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="d-flex justify-content-center align-items-center my-2" style="height: calc(100vh - 50px)">
        <div class="d-flex flex-column justify-content-center align-items-center">
            <h1><asp:Label runat="server" ID="FormType" Text="Register"/> User</h1>
            <% if (ErrorStr.Text.Length>0)
                { %>
               <div class="alert alert-danger" role="alert">
                  <asp:Label runat="server" ID="ErrorStr"/> 
               </div>
            <% } %>
            <div class="row mt-3">
                <div class="col-md-6 px-4">
                    <div class="mb-2">
                        <span for="Gender" class="font-weight-bold form-label">Name:</span>
                        <div class="input-group d-flex justify-content-center">
                            <div class="input-group-prepend">
                                <span class="input-group-text"><i data-feather="user"></i></span>
                            </div>
                            <asp:TextBox runat="server" type="text" ID="FirstName" class="form-control" placeholder="First Name" required="true" ToolTip="First Name"/>
                            <asp:TextBox runat="server" type="text" ID="LastName" class="form-control" placeholder="Last Name" required="true" ToolTip="Last Name"/>
                        </div>
                    </div>
                    <div class="mb-2">
                        <span for="Gender" class="font-weight-bold form-label">Birthday:</span>
                        <div class="input-group d-flex justify-content-center">
                            <div class="input-group-prepend">
                                <span class="input-group-text"><i data-feather="calendar"></i></span>
                            </div>
                            <asp:TextBox runat="server" type="date" ID="Birthday" class="form-control" placeholder="Birthday" required="true" ToolTip="Birthday"/>
                        </div>
                    </div>
                    <div class="mb-2">
                        <span for="Strand" class="font-weight-bold form-label">Strand:</span>
                        <div class="input-group d-flex justify-content-center">
                            <div class="input-group-prepend">
                                <span class="input-group-text"><i data-feather="info"></i></span>
                            </div>
                            <asp:TextBox runat="server" type="text" ID="Strand" class="form-control" placeholder="Strand" required="true" ToolTip="Strand"/>
                        </div>
                    </div>
                    <div class="mb-2">
                        <span for="Gender" class="font-weight-bold form-label">Address:</span>
                        <div class="input-group d-flex justify-content-center">
                            <div class="input-group-prepend">
                                <span class="input-group-text"><i data-feather="map-pin"></i></span>
                            </div>
                            <asp:TextBox TextMode="MultiLine" runat="server" type="text" ID="Address" class="form-control " placeholder="Address" required="true" ToolTip="Address"/>
                        </div>
                    </div>
                </div>
                <div class="col-md-6  px-4">
                    <div class="mb-2">
                        <span for="Gender" class="font-weight-bold form-label">Phone Number:</span>
                        <div class="input-group d-flex justify-content-center">
                            <div class="input-group-prepend">
                                <span class="input-group-text"><i data-feather="phone"></i></span>
                            </div>
                            <asp:TextBox runat="server" type="tel" ID="PhoneNumber" class="form-control" placeholder="Your 11 Digit Number" required="true" ToolTip="Phone Number"/>
                        </div>
                    </div>
                    <div class="mb-2">
                        <span for="Gender" class="font-weight-bold form-label">Guardian's Phone Number:</span>
                        <div class="input-group d-flex justify-content-center">
                            <div class="input-group-prepend">
                                <span class="input-group-text"><i data-feather="phone"></i></span>
                            </div>
                            <asp:TextBox runat="server" type="tel" ID="GuardianPhoneNumber" class="form-control" placeholder="Guardian's 11 Digit Number" required="true" ToolTip="Guardian's Phone Number"/>
                        </div>
                    </div>
                    <div class="mb-2">
                        <span for="Gender" class="font-weight-bold form-label">Email:</span>
                        <div class="input-group d-flex justify-content-center">
                            <div class="input-group-prepend">
                                <span class="input-group-text"><i data-feather="mail"></i></span>
                            </div>
                            <asp:TextBox runat="server" type="email" ID="email" class="form-control" placeholder="Email" required="true" ToolTip="Your Email"/>
                        </div>
                    </div>
                    <% if (prefillup_id == null) {%>
                        <div class="mb-2">
                            <span for="Gender" class="font-weight-bold form-label">Password:</span>
                            <div class="input-group d-flex justify-content-center">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i data-feather="key"></i></span>
                                </div>
                                <asp:TextBox runat="server" type="password" ID="password" class="form-control" placeholder="Password" required="true" ToolTip="Your Password"/>
                            </div>
                        </div>
                    <%} %>
                </div>
            </div>
            <div class="mb-2 row w-100">
                <div class="col-md-6">
                    <span for="Gender" class="font-weight-bold form-label">Gender:</span>
                    <asp:RadioButtonList ID="Gender" runat="server" required="true" CssClass="mx-5">
                        <asp:ListItem Value="MALE" required="true">Male</asp:ListItem>
                        <asp:ListItem Value="FEMALE">Female</asp:ListItem>
                    </asp:RadioButtonList>
                </div>
                <% if (prefillup_id == null)
                    { %>
                <div class="col-md-6">
                    
                    <label for="SchoolIdImage" class="font-weight-bold form-label">School ID Image</label>
                    <asp:FileUpload runat="server" class="form-control-lg" ID="SchoolIdImage" required="true" />
                </div>
                <%} %>
                
            </div>
            <asp:Button runat="server" text="Submit" ID="SubmitBtn" CssClass="btn btn-primary w-100" OnClick="SubmitBtn_Click"/>
        </div>
    </div>

</asp:Content>
