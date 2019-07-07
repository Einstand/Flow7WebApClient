<%@ Page Language="C#" Debug="true" %>
<%
   string sKey="Flow7Token";
   string sToken=Request.QueryString["hiddenToken"];
   Response.Cookies.Remove(sKey);
   HttpCookie newCookie = new HttpCookie(sKey);
   newCookie.Value = sToken;
   Response.Cookies.Add(newCookie);
   
   sKey="AccountID";
   string sAccount=Request.QueryString["account"];
   Response.Cookies.Remove(sKey);
   newCookie = new HttpCookie(sKey);
   newCookie.Value = sAccount;
   Response.Cookies.Add(newCookie);

   string sRedirect=Request.QueryString["redirect"];
   if (!string.IsNullOrEmpty(sRedirect))
   {
      string referer = Request.UrlReferrer.ToString();
      Response.Redirect(referer);
   }
%>

<A href="DumpCookie.aspx">DumpCookie</A>
<A href="ccIndex.htm">ccIndex</A>
