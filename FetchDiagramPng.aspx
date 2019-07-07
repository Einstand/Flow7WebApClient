<%@ Page Language="C#" Debug="false" %>
<%@ Import Namespace="NewType.AutoWeb.PageGenerator" %>
<%
   PageGenerator PageGen=new PageGenerator();
   PageGen.Run("Flow7","TwiceSubmitTest","FetchDiagramPng",Page);
%>
