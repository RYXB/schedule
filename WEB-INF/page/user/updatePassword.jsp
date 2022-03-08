<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/includes/head.jsp"%>
<html>
<head>
<title>用户密码修改</title>
<script language="javascript" for="window" event="onunload"> window.returnValue = "colos" ; 
</script>
<script language="JavaScript" type="text/JavaScript">
		
function doSubmit(){
	if(validate()){
    if(document.form.old_password.value!=document.form.oldPassword.value){
        alert("请输入正确的旧密码！");
        document.form.oldPassword.value="";
        document.form.newPassword1.value="";
        document.form.newPassword2.value="";
     }else{
    	 if(document.form.newPassword1.value!=document.form.newPassword2.value){
    	        alert("请两次输入的新密码相同！");
    	        document.form.oldPassword.value="";
    	        document.form.newPassword1.value="";
    	        document.form.newPassword2.value="";
     }else{
    if(confirm("您好、确定修改吗？")){
        form.target="main";
    	form.submit();	
    	window.close();
      }
	}}}
}
 
function goBack(){
	window.close();
}
</script>
</head>
<body>
<form name="form" action="<c:url value='/updatePasswordController.op'/>" method="post">
<input type="hidden" name="userNo" value="<c:out value='${userNo}'/>">
<input type="hidden" name="old_password" value="<c:out value='${password}'/>">
<br>
<br>
<br>
<br>
<table align="center" width="60%">
	<tr>
		<td class="headtitle">用户密码修改</td>
	</tr>
</table>
<table align="center" width="60%" border="1" cellspacing="1"
	cellpadding="0">
	<tr class="body">
		<td height="30" align="right" class="listhead">用户名：</td>
		<td align="left" class="listhead">
		<input type="text" name="userId" onkeypress="maxAsciiLen(20)" objName="用户名" style="width:100" readOnly="readOnly" maxlength="20" value="<c:out value='${userId}'/>"/>
		<font color="red"><c:out value="${staatus.errorMessage}"></c:out></font>
		</td>
	</tr>
	<tr class="body">
		<td height="30" align="right" class="listhead">用户姓名：</td>
		<td align="left" class="listhead">
		<input type="text" name="userName"  onkeypress="maxAsciiLen(20)" objName="用户姓名" readOnly="readOnly" nullable="false" style="width: 100" maxlength="20" value="<c:out value='${userName}'/>" />
		<font color="red"><c:out value="${status.errorMessage}"></c:out></font>
		</td>
	</tr>
	<tr class="body">
		<td height="30" align="right" class="listhead">旧密码：</td>
		<td align="left" class="listhead">
			<input type="password" name="oldPassword" objName="旧密码" style="width: 100"  nullable="false" maxlength="15" value="" />
			<font color="red"><c:out value="${status.errorMessage}"></c:out></font>
         </td>
	</tr>
	<tr class="body">
		<td height="30" align="right" class="listhead">新密码：</td>
		<td align="left" class="listhead">
			<input type="password" name="newPassword1" objName="新密码" style="width: 100"  nullable="false" maxlength="15" value="" />
			<font color="red"><c:out value="${status.errorMessage}"></c:out></font>
       </td>
	</tr>
	<tr class="body">
		<td height="30" align="right" class="listhead">重新输入新密码：</td>
		<td align="left" class="listhead">
			<input type="password" name="newPassword2" objName="重新输入新密码" style="width: 100" nullable="false"  maxlength="15" value=""/>
			<font color="red"><c:out value="${status.errorMessage}"></c:out></font>
          </td>
	</tr>
	<tr>
		<td align="center"><font color='#006030'><c:out value='${message}' /></font></td>
	</tr>
	<tr class="body">
		<td height="30" align="center" colspan="2" class="listhead">
		<input name="button22" type="button" class="button2" value="修    改" onclick="javascript:doSubmit();">
	    <input name="button222" type="button" class="button2" value="关　闭"onclick="javascript:goBack();"></td>
	</tr>
</table>
</form>
</body>
</html>
