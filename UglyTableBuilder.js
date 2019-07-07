//需使用 jQuery
//2017/11/25 : 初建立

// Builds the HTML Table out of myList.
function buildHtmlTable(myList,selector,buildOption)
{
  var columns = addAllColumnHeaders(myList, selector,buildOption);

  for (var i = 0; i < myList.length; i++)
  {
    var jsonRow=myList[i];
    var row$ = $('<tr/>');
    for (var colIndex = 0; colIndex < columns.length; colIndex++)
    {
      var columnName=columns[colIndex];
      var columnValue = jsonRow[columnName];
      if (columnValue == null) columnValue = "";
      var cellValue=columnValue;
      if (buildOption)
      {
        var buildOpt=buildOption[columnName];
        if (buildOpt)
        {
          if (buildOpt.url)
          {
             cellValue=buildLink(jsonRow,buildOpt,columnValue);
          }
        }
      }
      row$.append($('<td/>').html(cellValue));
    }
    $(selector).append(row$);
  }
}

function buildLink(jsonRow,linkOpt,columnValue)
{
  var sRet="<a href='"+linkOpt.url;
  if (linkOpt.parameter.length>0)
  {
    sRet+="?";
    for (var i = 0; i < linkOpt.parameter.length; i++)
    {
      if (i>0) sRet+="&";
      var paramName=linkOpt.parameter[i].key;
      var paramValue = null;
      if (linkOpt.parameter[i].field)
      {
        paramValue = jsonRow[paramName];
      }
      else if (linkOpt.parameter[i].value)
      {
        paramValue = linkOpt.parameter[i].value;
      }
      if (paramValue == null) paramValue = "";
      sRet+=paramName+"="+paramValue;
    }
  }
  sRet+="'>"+columnValue+"</a>";
  return sRet;
}

// Adds a header row to the table and returns the set of columns.
// Need to do union of keys from all records as some records may not contain
// all records.
function addAllColumnHeaders(myList, selector,buildOption)
{
  var columnSet = [];
  var headerTRs = $('<tr/>');

  for (var i = 0; i < myList.length; i++)
  {
    var rowHash = myList[i];
    for (var key in rowHash)
    {
      if ($.inArray(key, columnSet) == -1)
      {
        var bPushThis=true;
        if (buildOption)
        {
          var buildOpt=buildOption[key];
          if (buildOpt)
          {
            if (buildOpt.hidden===true) bPushThis=false;
          }
        }
        if (bPushThis)
        {
          columnSet.push(key);
          headerTRs.append($('<th/>').html(key));
        }
      }
    }
  }
  $(selector).append(headerTRs);
  return columnSet;
}