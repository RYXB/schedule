<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/includes/head.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<TITLE></TITLE>
<script language="JavaScript" type="text/JavaScript">
function firstView(){
	document.form.action="<c:url value='/taskMonitor.op'/>";
	document.form.method="get";
	form.submit();
}
</script>
</HEAD>
<style>
BODY {
	BACKGROUND: url(./images/login-head-bg.gif) #fff repeat-x 100% top;
	OVERFLOW: hidden;
	FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif
} 
.bg_once_center {
	background: url("./images/welcome.gif") no-repeat center center
}
</STYLE>
<form name="form" method="get" action="">
<BODY id="locker-name" style="OVERFLOW: hidden" count="0" onload="firstView()">
<DIV class="page" id="ePage" typeId="page">
<TABLE height="100%" cellSpacing="1" cellPadding="1" width="100%" align="center" border="0" class="bg_once_center">
	<iframe marginheight="0" marginwidth="0" frameborder="0" width="100%" height="100%"
				scrolling="auto">
	</iframe>
</TABLE>
</DIV>
</BODY>
</form>
</HTML>
