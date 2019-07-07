<!-- LastUpdated : 2018/07/16 -->
<%@ Page Language="C#" Debug="true" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Net" %>
<%@ Import Namespace="System.Web.Script.Serialization" %>
<%
   NameValueCollection pQueryString=Request.QueryString;
   string accountId=pQueryString.Get("accountId");
   
   var httpWebRequest = (HttpWebRequest)WebRequest.Create("http://localhost/Flow7WebApClient/Flow7ApClient.aspx");
   httpWebRequest.ContentType = "application/json";
   httpWebRequest.Method = "POST";
   
   string sJson="";
   
   sJson+="{";
   sJson+="   \"command\": \"login\",";
   sJson+="   \"accountID\": \"%A\",";
   sJson+="   \"client_id\": \"WebEIP\",";
   sJson+="   \"client_secret\": \"newauth-1x087-a5gf3-a12et-webeip\"";
   sJson+="}";
   sJson=sJson.Replace("%A", accountId);

   using (var streamWriter = new StreamWriter(httpWebRequest.GetRequestStream()))
   {
       streamWriter.Write(sJson);
       streamWriter.Flush();
       streamWriter.Close();
   }

   string sJsonText="";
   var httpResponse = (HttpWebResponse)httpWebRequest.GetResponse();
   using (var streamReader = new StreamReader(httpResponse.GetResponseStream()))
   {
      sJsonText = streamReader.ReadToEnd();
      //Response.Write(result);
   }
   JavaScriptSerializer ser=new JavaScriptSerializer();//DeserializeObject null check OK
   object TmpObj=null;
   try
   {
      TmpObj=ser.DeserializeObject(sJsonText);
      if (TmpObj is Dictionary<string,object>) // 另一個 Json-Object
      {
         Dictionary<string,object> dict1=(Dictionary<string,object>)TmpObj;
         foreach (string sKey1 in dict1.Keys)
         {
            if (sKey1=="flow7data")
            {
               object oFlow7data=dict1[sKey1];
               if (oFlow7data is Dictionary<string,object>) // 另一個 Json-Object
               {
                  Dictionary<string,object> dict2=(Dictionary<string,object>)oFlow7data;
                  foreach (string sKey2 in dict2.Keys)
                  {
                     if (sKey2=="token")
                     {
                        object o2=dict2[sKey2];
                        string sCookieKey="Flow7Token";
                        string sToken=o2.ToString();
                        Response.Cookies.Remove(sCookieKey);
                        HttpCookie newCookie = new HttpCookie(sCookieKey);
                        newCookie.Value = sToken;
                        Response.Cookies.Add(newCookie);
                        
                        sCookieKey="AccountID";
                        Response.Cookies.Remove(sCookieKey);
                        newCookie = new HttpCookie(sCookieKey);
                        newCookie.Value = accountId;
                        Response.Cookies.Add(newCookie);
                        Response.Write("Login Success '"+sToken+"'");
                     }
                  }
               }
            }
         }
      }
   }
   catch (Exception e)
   {
      string sErrMsg=e.Message;
      Response.Write(sErrMsg);
   }
%>
<BR>
<A href="DumpCookie.aspx">DumpCookie</A>&nbsp;|&nbsp;
<A href="ccIndex.htm">ccIndex</A>
