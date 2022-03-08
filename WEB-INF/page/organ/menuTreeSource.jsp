<?xml version="1.0" encoding="UTF-8"?>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType = "text/xml; charset=UTF-8" %>

<tree>
	<c:forEach items="${childrenList}" var="item" varStatus="s">
		<c:url value="/menuTreeSource.op" var="srcUrl">
			<c:param name='MENUCODE' value='${item.MENUCODE}'/>
		</c:url>
	  <tree text="<c:out value='${item.MENUNAME}'/>" src="<c:if test='${empty item.MENUURL}'><c:out value='${srcUrl}'/></c:if>" 
	    action="<c:if test='${not empty item.MENUURL}'>javascript:onclickMenu('<c:url value='${item.MENUURL}'/>')</c:if>"
	  />
	</c:forEach>
</tree>
 
 