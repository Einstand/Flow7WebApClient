<%@ Page Language="C#" Debug="true" %>
<%@ Import Namespace="NewType.FlowSe7en.WebAPI" %>
<%
   EngineAPI api=new EngineAPI();
   api.CredentialClientCall(Page,"Flow7WebAPI","Jessica");
%>
