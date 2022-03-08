<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>依赖关系</title> 
</head>
	 <frameset cols="*,*"> 
		<frame name="top" src="<c:url value='/getGeneralTreeUpView.op'><c:param name='taskId' value="${taskId}"/><c:param name='jobId' value="${jobId}"/></c:url>">
		<frame name="bottom" src="<c:url value='/getGeneralTreeView.op'><c:param name='taskId' value="${taskId}"/><c:param name='jobId' value="${jobId}"/></c:url>">
	 </frameset> 
</html>