<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/includes/head.jsp"%>
<HTML>
<HEAD>
<script  type="text/JavaScript">
 function doBack(){
  form.action="<c:url  value='${url}'/>";
  form.submit();	
 }
 function doNext(){
    form.action="<c:url  value='${nexturl}'/>";
    form.submit();	
 }
</script>
<TITLE>信息提示页面</TITLE>
</HEAD>
<BODY>
<form name="form" action="" method="get">
<input name="dbTns" value="<c:out value='${dbTns}'/>" type="hidden">
<input name="operate" value="<c:out value='${operate}'/>" type="hidden">
<table>
	<tr>
		<td class="remark">
		 <img SRC="<c:url value='/images/ok.png' />" WIDTH="18" HEIGHT="13">信息提示</td>
	</tr>
</table>
<br>
<br>
<table width="80%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="999999">
	<tr>
		<td height="25" bgcolor="f1f1f1" class="font9">
		<div align="center"><strong>提示内容</strong></div>
		</td>
	</tr>
	<tr>
		<td bgcolor="ffffff" class="font9">
		<div align="center"><br>
		<table border="0" cellpadding="0" cellspacing="1">
			<tr>
				<td align="center">
				<img src="<c:url value='/images/icon-warning.gif' />" width="20" height="20">
				<font color='#006030'><c:out value='${message}' /></font></td>
			</tr>
		</table>
		<br>
		<div align="center">
		<table class="top">
			<tr>
			    <td align="center"><input name="button22" type="button" class="button2" value="<c:out value='${nextOperateName}'/>" onclick="javascript:doNext();"></td>
				<td align="center"><input name="button22" type="button" class="button2" value="返 回" onclick="javascript:doBack();"></td>
			</tr>
		</table>
		</div>
		<br>
		</div>
		</td>
	</tr>
</table>
<br>
</form>
</BODY>
</HTML>
