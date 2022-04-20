<%@ Page Title="Admin Login" Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="AdminLoginForm.aspx.cs" Inherits="LibraryWebApp.AdminLoginForm" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="d-flex justify-content-center align-items-center" style="height: calc(100vh - 50px)">
        <div class="d-flex flex-column justify-content-center align-items-center">
            <h1>Login as Administrator</h1>
            <div class="mb-3">
                <div class="input-group d-flex justify-content-center">
                    <div class="input-group-prepend">
                        <span class="input-group-text"><i data-feather="mail"></i></span>
                    </div>
                    <asp:TextBox runat="server" type="email" ID="email" class="form-control" placeholder="Email" />
                </div>
                <%if (EmailErrorLabel.Text.Length > 0)
                    {%>
                <small class="form-text text-danger"><asp:Label runat="server" ID="EmailErrorLabel"/></small>
                <%}%>
            </div>
            <div class="mb-3">
                <div class="input-group d-flex justify-content-center">
                    <div class="input-group-prepend">
                        <span class="input-group-text"><i data-feather="key"></i></span>
                    </div>
                    <asp:TextBox runat="server" type="password" ID="password" class="form-control" placeholder="Password" />
                </div>
                <%if (PasswordErrorLabel.Text.Length > 0)
                    {%>
                <small class="form-text text-danger"><asp:Label runat="server" ID="PasswordErrorLabel"/></small>
                <%}%>
            </div>
            <asp:Button runat="server" text="Login" CssClass="btn btn-primary w-100" OnClick="Login"/>
        </div>
    </div>

</asp:Content>
