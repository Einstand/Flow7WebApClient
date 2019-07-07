<%@ Page Language="C#" Debug="true" %>
<TABLE border=1 width='80%'>
  <TR>
    <TD colspan=2 BgColor='#CCCCCC'>Form</TD>
  </TR>
<%
   NameValueCollection pForm=Request.Form;
   for (int i=0;i<pForm.AllKeys.Length;i++)
   {
      string sKey=pForm.AllKeys[i];
      Response.Write("<TR><TD>");
      Response.Write(sKey);
      Response.Write("</TD><TD>");
      Response.Write(pForm.Get(sKey));
      Response.Write("</TD>");
   }
%>
</TABLE>

<TABLE border=1 width='80%'>
  <TR>
    <TD colspan=2 BgColor='#CCCCCC'>QueryString</TD>
  </TR>
<%
   NameValueCollection pQueryString=Request.QueryString;
   for (int i=0;i<pQueryString.AllKeys.Length;i++)
   {
      string sKey=pQueryString.AllKeys[i];
      Response.Write("<TR><TD>");
      Response.Write(sKey);
      Response.Write("</TD><TD>");
      Response.Write(pQueryString.Get(sKey));
      Response.Write("</TD>");
   }
%>
</TABLE>

<TABLE border=1 width='80%'>
  <TR>
    <TD colspan=2 BgColor='#CCCCCC'>Others</TD>
  </TR>
<%
   Response.Write("<TR><TD>");
   Response.Write("UserAgent");
   Response.Write("</TD><TD>");
   Response.Write(Request.UserAgent);
   Response.Write("</TD>");
%>
<%
   Response.Write("<TR><TD>");
   Response.Write("UserHostAddress");
   Response.Write("</TD><TD>");
   Response.Write(Request.UserHostAddress);
   Response.Write("</TD>");
%>
<%
   Response.Write("<TR><TD>");
   Response.Write("UserHostName");
   Response.Write("</TD><TD>");
   Response.Write(Request.UserHostName);
   Response.Write("</TD>");
%>
<%
   Response.Write("<TR><TD>");
   Response.Write("UrlReferrer");
   Response.Write("</TD><TD>");
   Uri MyUrl = Request.UrlReferrer;
   if (MyUrl!=null)
   {
      Response.Write("Referrer URL Port: " + Server.HtmlEncode(MyUrl.Port.ToString()) + "<br>");
      Response.Write("Referrer URL Protocol: " + Server.HtmlEncode(MyUrl.Scheme) + "<br>");
   }
   else
   {
      Response.Write("NULL");
   }
   Response.Write("</TD>");
%>
</TABLE>