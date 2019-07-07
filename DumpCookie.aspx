<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Dump Cookie</title>
</head>
<!-- 2016/08/10 : 加上 HttpOnly 屬性及 Javascript -->
<%@ Page Language="C#" Debug="true" %>
<body onload="LoadMe()">
<table border=1 width='100%'>
  <tr BgColor='#CCCCCC'>
    <td colspan=3>Cookie (Use .NET Framework)</td>
  </tr>
  <tr BgColor='#CCCCCC'>
    <td width='40%'>Name</td>
    <td>Value</td>
    <td>HttpOnly</td>
  </tr>
<%
   HttpCookieCollection pCollection=Request.Cookies;
   int nSize=pCollection.Count;
   for (int i=0;i<nSize;i++)
   {
      HttpCookie cookie=pCollection[i];
      Response.Write("<tr><td>");
      Response.Write(cookie.Name);
      Response.Write("</td><td>");
      if (cookie.HasKeys)
      {
        string sContent="<table border=1 width='100%'>";
        string[] AllKey=cookie.Values.AllKeys;
        for (int j=0;j<AllKey.Length;j++)
        {
           string SubKey=AllKey[j];
           sContent+="<tr><td>" + SubKey + "</td><td>" + cookie.Values[SubKey] + "</td></tr>";
        }
        sContent+="</table>";
        Response.Write(sContent);
      }
      else
      {
         Response.Write(cookie.Value);
      }
      Response.Write("</td><td>");
      Response.Write(cookie.HttpOnly);
      Response.Write("</td></tr>");
   }
%>
</table>
<div id="CookieByJS">
</div>
<script language='Javascript'>
function MakeCookieTable()
{
  var sContent="<table border=1 width='100%'>";
  sContent+="<tr bgcolor='#C0C0C0'><td ColSpan=2>";
  sContent+="Cookie (Use Javascript)";
  sContent+="</td></tr>";
  sContent+="<tr bgcolor='#C0C0C0'><td width='40%'>Name</td><td>Value</td></tr>";
  var cookieNameValueArray = document.cookie.split(";");
  for (var i = 0; i < cookieNameValueArray.length; i++)
  {
    var thisNameValue=cookieNameValueArray[i];
    var p1=thisNameValue.indexOf('=');
    if (p1!=-1)
    {
      var thisName=thisNameValue.substring(0,p1);
      var thisValue=thisNameValue.substring(p1+1,thisNameValue.length);
      sContent+="<tr><td>" + unescape(thisName)+ "</td><td>";
      if (thisValue.indexOf('=')==-1)
      {
        sContent+=unescape(thisValue)
      }
      else
      {
        sContent+="<table border=1 width='100%'>";
        var keyValueArray = thisValue.split('&');
        for (var j = 0; j < keyValueArray.length; j++)
        {
          var thisKeyValue=keyValueArray[j].split('=');
          var cName = unescape(thisKeyValue[0]);
          var cValue = unescape(thisKeyValue[1]);
          sContent+="<tr><td>" + cName + "</td><td>" + cValue + "</td></tr>";
        }
        sContent+="</table>";
      }
      sContent+="</td></tr>";
    }
  }
  sContent+="</table>";
  return sContent;
}

function LoadMe()
{
  var CookieDIV = document.getElementById("CookieByJS");
  CookieDIV.innerHTML=MakeCookieTable();
}  
</script>

</body>
</html>