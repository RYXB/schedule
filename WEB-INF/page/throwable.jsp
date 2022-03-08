<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/includes/head.jsp"%>

<c:set var="problem" value="${requestScope['javax.servlet.error.exception']}"/>
<html>
<link rel="stylesheet" href="<c:url value='/css/style.css'/>" type="text/css">
<body bgcolor="#f3f9f2">
<br>
<br>
<table width="80%" border="0" align="center" cellpadding="5" cellspacing="1">
  <thead>
  <tr>
    <td height="25"><div align="center"><strong>系统异常！</strong></div></td>
  </tr>
  </thead>
  <tbody>
  <tr>
    <td> 
      <div align="center"><c:out value="${problem}"/></div>
      </td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  </tbody>
</table>
<br>
</body>
</html>