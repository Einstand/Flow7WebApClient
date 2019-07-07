<!-- LastUpdated : 2018/07/16 -->
<%@ Page Language="C#" Debug="true" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Net" %>
<%
   NameValueCollection pQueryString=Request.QueryString;
   string authToken=pQueryString.Get("authToken");
   string diagramGuid=pQueryString.Get("diagramGuid");
   string applicantId=pQueryString.Get("applicantId");
   string applicantDept=pQueryString.Get("applicantDept");
   
   System.Guid desiredGuid = System.Guid.NewGuid();
   string requisitionId=desiredGuid.ToString();
   
   var httpWebRequest = (HttpWebRequest)WebRequest.Create("http://localhost/Flow7WebApClient/Flow7ApClient.aspx");
   httpWebRequest.ContentType = "application/json";
   httpWebRequest.Method = "POST";
   
   string sJson="";
   
   sJson+="{";
   sJson+="   \"command\": \"start\",";
   sJson+="   \"authToken\": \"%T\",";
   sJson+="   \"applicantId\": \"%A\",";
   sJson+="   \"applicantDept\": \"%B\",";
   sJson+="   \"options\": {";
   sJson+="      \"diagramGuid\": \"%D\",";
   sJson+="      \"requisitionId\": \"%R\"";
   sJson+="   },";
   sJson+="   \"client_id\": \"WebEIP\",";
   sJson+="   \"client_secret\": \"newauth-1x087-a5gf3-a12et-webeip\"";
   sJson+="}";
   sJson=sJson.Replace("%A", applicantId).Replace("%B", applicantDept).Replace("%D", diagramGuid).Replace("%T", authToken).Replace("%R", requisitionId);

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
      Response.Write(result);
   }
%>
