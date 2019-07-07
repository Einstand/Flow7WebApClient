<%@ Page Language="C#" Debug="true" %>
<%@ Import Namespace="NewType.AutoWeb.NewAuth3ty" %>
<%
   NewAuth3Receiver api=new NewAuth3Receiver();
   api.JsonFetch(Page,"Flow7WebAPI");
%>
