<?xml version="1.0" encoding="UTF-8"?>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType = "text/xml; charset=UTF-8" %>

<tree>
	<c:forEach items="${childrenList}" var="item" varStatus="s">
	
		<c:url value="/getGeneralTreeSource.op" var="srcUrl">
			<c:param name='taskId' value='${item.TASKID}'/>
			<c:param name='jobId' value="${item.JOBID}"/>
		</c:url>
	  <tree text=" <c:out value='${item.JOBID}'/>" src="<c:out value='${srcUrl}'/>" action=""/>
	</c:forEach>
	
</tree>
 
 