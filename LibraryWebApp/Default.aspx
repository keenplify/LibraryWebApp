<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/SiteNoNav.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="LibraryWebApp._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="d-flex justify-content-center align-items-center" style="height: calc(100vh - 50px)">
        <div class="d-flex flex-column">
            <h1>Welcome to Library System!</h1>
            <a runat="server" class="btn btn-primary mb-2" href="AdminLoginForm.aspx">Login as Admin</a>
            <a runat="server" class="btn btn-secondary mb-2" href="UserLoginForm.aspx">Login as User</a>
            <a runat="server" class="btn btn-info mb-2" href="RegisterForm.aspx">Register</a>
        </div>
    </div>

</asp:Content>
