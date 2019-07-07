<!-- LastUpdated : 2019/07/08 -->
<%@ Page Language="C#" Debug="true" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Net" %>
<%
   NameValueCollection pQueryString=Request.QueryString;
   string authToken=pQueryString.Get("authToken");
   string approverGuid=pQueryString.Get("approverGuid");
   
   var httpWebRequest = (HttpWebRequest)WebRequest.Create("http://localhost/Flow7WebApClient/Flow7ApClient.aspx");
   httpWebRequest.ContentType = "application/json";
   httpWebRequest.Method = "POST";
   
   string sJson="";
   
   sJson+="{";
   sJson+="   \"command\": \"peekNextAll\",";
   sJson+="   \"authToken\": \"%T\",";
   sJson+="   \"approverGuid\": \"%G\",";
   sJson+="   \"options\": {";
   sJson+="      \"comment\": \"By CallPeekNextAll.aspx\"";
   sJson+="   },";
   sJson+="   \"client_id\": \"WebEIP\",";
   sJson+="   \"client_secret\": \"newauth-1x087-a5gf3-a12et-webeip\"";
   sJson+="}";
   sJson=sJson.Replace("%G", approverGuid).Replace("%T", authToken);

   using (var streamWriter = new StreamWriter(httpWebRequest.GetRequestStream()))
   {
       streamWriter.Write(sJson);
       streamWriter.Flush();
       streamWriter.Close();
   }

   var httpResponse = (HttpWebResponse)httpWebRequest.GetResponse();
   using (var streamReader = new StreamReader(httpResponse.GetResponseStream()))
   {
      var result = streamReader.ReadToEnd();
      Response.Clear();
      Response.ContentType = "application/json; charset=utf-8";
      Response.Write(result);
   }
%>
