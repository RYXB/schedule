<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/includes/head.jsp"%>
<html>
<head>
<title>用户信息修改</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<script language="JavaScript" type="text/JavaScript">
var xmlHttp;
var returnflag="false";
function createXMLHttpRequest() {
  if (window.ActiveXObject) {
     xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
   } 
  else 
    if (window.XMLHttpRequest) {
        xmlHttp = new XMLHttpRequest();                
    }
}
function doSubmit(){
	if(validate()){
    if(confirm("您好、确定新增吗？")){  
       var connDbServer=document.form.dbServer.value;
       var connIp=document.form.ip.value;
       var connUsername=document.form.username.value;
       var connPasswd=document.form.passwd.value;
       createXMLHttpRequest();
       var url = "<c:url value='/connectTest.op'/>?connDbServer="+connDbServer+"&connIp="+connIp+"&connUsername="+connUsername+"&connPasswd="+connPasswd+"&date="+new Date();
       xmlHttp.open("post", url, true);
       xmlHttp.onreadystatechange = pollCallbackAdd;
       xmlHttp.send(null);   
      }
    }
}
function pollCallbackAdd(){
    if (xmlHttp.readyState == 4) {
     if (xmlHttp.status == 200) {    
       var runs = xmlHttp.responseXML.getElementsByTagName("run");  
       var run=runs[0];
       returnflag=run.getElementsByTagName("returnflag")[0].childNodes[0].nodeValue;
       if(returnflag=="true"){
          form.action="<c:url value='/addTabledata.op'/>";
          form.method="post";
    	  form.submit();	
       }else{
          alert("数据库连接失败！");
       }
     }
  }
}
function doConnTest(){
    var connDbServer=document.form.dbServer.value;
    var connIp=document.form.ip.value;
    var connUsername=document.form.username.value;
    var connPasswd=document.form.passwd.value;
    if(connDbServer==""||connIp==""||connUsername==""||connPasswd==""){
      alert("请输入连接数据库的参数！");
    }else{
       createXMLHttpRequest();
       var url = "<c:url value='/connectTest.op'/>?connDbServer="+connDbServer+"&connIp="+connIp+"&connUsername="+connUsername+"&connPasswd="+connPasswd+"&date="+new Date();
       xmlHttp.open("post", url, true);
       xmlHttp.onreadystatechange = pollCallback;
       xmlHttp.send(null);
    }
} 
function pollCallback() {
  if (xmlHttp.readyState == 4) {
     if (xmlHttp.status == 200) {    
       var runs = xmlHttp.responseXML.getElementsByTagName("run");  
       var run=runs[0];
       returnflag=run.getElementsByTagName("returnflag")[0].childNodes[0].nodeValue;
       if(returnflag=="true"){
          alert("数据库连接成功！");
       }else{
          alert("数据库连接失败！");
       }
     }
  }
}
function goBack(){
	form.action="<c:url value='/userController.op'/>";
	form.method="get";
	form.submit();	
}
</script>
</head>
<body>
<form name="form" action="<c:url value='/addTableInfo.op'/>" method="post">
<input name="operate" value="<c:out value='${operate}'/>" type="hidden">
<br>
<br>
<br>
<br>
<table align="center" width="60%">
	<tr>
		<td class="headtitle">数据源维护</td>
	</tr>
</table>
<table align="center" width="60%" border="1" cellspacing="1" cellpadding="0">
     <tr class="body">
		<td height="30" align="right" class="listhead">数据库ID：</td>
		<td align="left" class="listhead"><spring:bind path="command.dbTns">
		   <input type="text" name="<c:out value='${status.expression}'/>" objName="数据库ID" nullable="false" style="width:300" maxlength="20" value="<c:out value='${status.value}'/>"/>
		   <font color="red"><c:out value="${status.errorMessage}"></c:out></font></spring:bind>
	    </td>
	</tr>
	<tr class="body">
		<td height="30" align="right" class="listhead">数据库实例：</td>
		<td align="left" class="listhead"><spring:bind path="command.dbServer">
		   <input type="text" name="<c:out value='${status.expression}'/>" objName="数据库实例" nullable="false" style="width:300" maxlength="20" value="<c:out value='${status.value}'/>"/>
		   <font color="red"><c:out value="${status.errorMessage}"></c:out></font></spring:bind>
	    </td>
	</tr>
	<tr class="body">
		<td height="30" align="right" class="listhead">数据库IP地址：</td>
		<td align="left" class="listhead"> <spring:bind path="command.ip">
		   <input type="text" name="<c:out value='${status.expression }'/>" objName="数据库IP地址" nullable="false" style="width: 300" maxlength="40" value="<c:out value='${status.value }'/>" />
		   <font color="red"><c:out value="${status.errorMessage}"></c:out></font></spring:bind>
		</td>
	</tr>
	<tr class="body">
		<td height="30" align="right" class="listhead">数据库用户：</td>
		<td align="left" class="listhead"><spring:bind path="command.username">
		   <input type="text" name="<c:out value='${status.expression }'/>" objName="数据库IP地址" nullable="false" style="width: 300" maxlength="40" value="<c:out value='${status.value }'/>" />
		   <font color="red"><c:out value="${status.errorMessage}"></c:out></font></spring:bind>
		</td>
	</tr>
	<tr class="body">
		<td height="30" align="right" class="listhead">数据库密码：</td>
		<td align="left" class="listhead"><spring:bind path="command.passwd">
		   <input type="password" name="<c:out value='${status.expression }'/>" objName="数据库IP地址" nullable="false" style="width: 300" maxlength="40" value="<c:out value='${status.value }'/>" />
		   <font color="red"><c:out value="${status.errorMessage}"></c:out></font></spring:bind>
		</td>
	</tr>
	<tr class="body">
		<td height="30" align="right" class="listhead">文件存放目录：</td>
		<td align="left" class="listhead"><spring:bind path="command.filePath">
		   <input type="text" name="<c:out value='${status.expression }'/>"objName="文件存放目录" style="width: 300" maxlength="100" value="<c:out value='${status.value }'/>" />
		   <font color="red"><c:out value="${status.errorMessage}"></c:out></font></spring:bind>
		</td>
	</tr>
	<tr class="body">
		<td height="30" align="right" class="listhead">分隔方式：</td>
		<td align="left" class="listhead"><spring:bind path="command.splitType">
		   <select name="<c:out value='${status.expression }'/>" objName="分隔方式"  class="select" style="width: 300">
              <option value="">请选择</option>
              <option value="1" <c:if test="${'1'== status.value}">selected="selected"</c:if> >定长</option>
              <option value="2" <c:if test="${'2'== status.value}">selected="selected"</c:if>>分隔符</option>
		   </select></spring:bind>
	    </td>
	</tr>
	<tr class="body">
		<td height="30" align="right" class="listhead">分隔符：</td>
		<td align="left" class="listhead"><spring:bind path="command.splitChar">
		   <input type="text" name="<c:out value='${status.expression }'/>"objName="分隔符" style="width: 300" maxlength="5" value="<c:out value='${status.value }'/>" />
		   <font color="red"><c:out value="${status.errorMessage}"></c:out></font></spring:bind>
		</td>
	</tr>
	<tr class="body">
		<td height="30" align="center" colspan="2" class="listhead">
		<input name="button220" type="button" class="button2" value="测试连接" onclick="javascript:doConnTest();"> 
		<input name="button221" type="button" class="button2" value="确　　定" onclick="javascript:doSubmit();"> 
		<input name="button222" type="button" class="button2" value="返　　回" onclick="javascript:goBack();"></td>
	</tr>
</table>
</form>
</body>
</html>
