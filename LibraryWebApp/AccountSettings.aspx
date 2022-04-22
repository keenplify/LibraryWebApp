<%@ Page Title="Account Settings" Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="AccountSettings.aspx.cs" Inherits="LibraryWebApp.AccountSettings" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
   <div class="container my-2" style="margin-top: 20px">
      <div class="row">
          <div class="col-md-4">
              <div class="mt-5 px-3">
                  <span class="font-weight-bold form-label">Your ID Image</span>
                  <div>
                      <img src="<%=user["school_id_image_location"] %>" class="img-fluid rounded" style="box-shadow: 0 1em 3em rgba(0,0,0,0.12), 0 1em 3em rgba(0,0,0,0.24);"/>
                  </div>
              </div>
          </div>
          <div class="col-md-8 px-5">
               <div class="w-100 text-center">
                    <h2 class="mt-5">Account Settings</h2>
                </div>
                <asp:Panel runat="server" ID="pnlUpdateAccount" DefaultButton="UpdateDetailsBtn">
                    <div class="d-flex justify-content-center align-items-center">
                        <div class="d-flex flex-column justify-content-center align-items-center">
                            <% if (ErrorStr.Text.Length>0)
                                { %>
                                <div class="alert alert-danger" role="alert">
                                    <asp:Label runat="server" ID="ErrorStr"/> 
                                </div>
                            <% } %>
                            <div class="row mt-3">
                                <div class="col-md-6 px-1">
                                    <div class="mb-2">
                                        <span class="font-weight-bold form-label">Name:</span>
                                        <div class="input-group d-flex justify-content-center">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text"><i data-feather="user"></i></span>
                                            </div>
                                            <asp:TextBox runat="server" type="text" ID="FirstName" class="form-control" placeholder="First Name" required="true" ToolTip="First Name"/>
                                            <asp:TextBox runat="server" type="text" ID="LastName" class="form-control" placeholder="Last Name" required="true" ToolTip="Last Name"/>
                                        </div>
                                    </div>
                                    <div class="mb-2">
                                        <span class="font-weight-bold form-label">Birthday:</span>
                                        <div class="input-group d-flex justify-content-center">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text"><i data-feather="calendar"></i></span>
                                            </div>
                                            <asp:TextBox runat="server" type="date" ID="Birthday" class="form-control" placeholder="Birthday" required="true" ToolTip="Birthday"/>
                                        </div>
                                    </div>
                                    <div class="mb-2">
                                        <span class="font-weight-bold form-label">Section:</span>
                                        <div class="input-group d-flex justify-content-center">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text"><i data-feather="info"></i></span>
                                            </div>
                                            <asp:TextBox runat="server" type="text" ID="Section" class="form-control" placeholder="Section" required="true" ToolTip="Section"/>
                                        </div>
                                    </div>
                                    <div class="mb-2">
                                        <span class="font-weight-bold form-label">Address:</span>
                                        <div class="input-group d-flex justify-content-center">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text"><i data-feather="map-pin"></i></span>
                                            </div>
                                            <asp:TextBox TextMode="MultiLine" runat="server" type="text" ID="Address" class="form-control " placeholder="Address" required="true" ToolTip="Address"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6 px-1">
                                    <div class="mb-2">
                                        <span class="font-weight-bold form-label">Phone Number:</span>
                                        <div class="input-group d-flex justify-content-center">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text"><i data-feather="phone"></i></span>
                                            </div>
                                            <asp:TextBox runat="server" type="tel" ID="PhoneNumber" class="form-control" placeholder="Your 11 Digit Number" required="true" ToolTip="Phone Number"/>
                                        </div>
                                    </div>
                                    <div class="mb-2">
                                        <span class="font-weight-bold form-label">Guardian's Phone Number:</span>
                                        <div class="input-group d-flex justify-content-center">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text"><i data-feather="phone"></i></span>
                                            </div>
                                            <asp:TextBox runat="server" type="tel" ID="GuardianPhoneNumber" class="form-control" placeholder="Guardian's 11 Digit Number" required="true" ToolTip="Guardian's Phone Number"/>
                                        </div>
                                    </div>
                                    <div class="mb-2">
                                        <span class="font-weight-bold form-label">Email:</span>
                                        <div class="input-group d-flex justify-content-center">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text"><i data-feather="mail"></i></span>
                                            </div>
                                            <asp:TextBox runat="server" type="email" ID="email" class="form-control" placeholder="Email" required="true" ToolTip="Your Email"/>
                                        </div>
                                    </div>
                                    <div class="mb-2">
                                        <span for="Gender" class="font-weight-bold form-label">Gender:</span>
                                        <asp:RadioButtonList ID="Gender" runat="server" required="true" CssClass="mx-5">
                                            <asp:ListItem Value="MALE">Male</asp:ListItem>
                                            <asp:ListItem Value="FEMALE">Female</asp:ListItem>
                                        </asp:RadioButtonList>
                                    </div>
                                </div>
                            </div>
                            <asp:Button runat="server" text="Update Account" CssClass="btn btn-primary w-100" ID="UpdateDetailsBtn" OnClick="UpdateBtn_Click"/>
                        </div>
                    </div>
                </asp:Panel>
                <asp:Panel runat="server" ID="pnlUpdatePassword" DefaultButton="UpdatePasswordBtn">
                    <div class="d-flex flex-column justify-content-center align-items-center my-3">
               
                        <div class="w-100 text-center">
                            <h2>Update Password</h2>
                        </div>
                        <% if (NewPasswordError.Text.Length > 0)
                            { %>
                        <div class="alert alert-warning" role="alert">
                            <asp:Label runat="server" ID="NewPasswordError"></asp:Label>
                        </div>
                        <%} %>
                        <div class="form-group">
                            <label for="NewPassword">New Password</label>
                            <asp:TextBox runat="server" type="password" class="form-control" ID="NewPassword" placeholder="Password" />
                        </div>
                        <div class="form-group">
                            <label for="NewPassword">Confirm New Password</label>
                            <asp:TextBox runat="server" type="password" class="form-control" ID="NewPasswordConfirm" placeholder="Confirm Password" />
                        </div>
                        <asp:Button runat="server" text="Update Password" CssClass="btn btn-primary w-100" ID="UpdatePasswordBtn" OnClick="UpdatePasswordBtn_Click"/>
                    </div>
                </asp:Panel>
          </div>
      </div>
   </div>
</asp:Content>