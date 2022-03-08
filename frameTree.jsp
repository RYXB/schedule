<%@ page contentType = "text/html; charset=UTF-8" %>
<%@ include file="/includes/head.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>依赖关系</title> 
</head>
<body >
 
	<div region="center"  style="width:350px;padding:0px;"> 
	  <table height="100%" width="100%" cellspacing="0" cellpadding="0">
		<tr height="100%" valign="top">
			<td width="100%"><iframe style="overflow:auto;width:100%;height:100%;margin:0;padding:0" frameborder="0" 
			 src="<c:url value='/getGeneralTreeView.op'/>"></iframe></td>
		</tr>
      </table>
    </div>
	 
	<div region="center" style="width:350px;padding:0px;"> 
	  <table height="100%" width="100%" cellspacing="0" cellpadding="0">
		<tr height="100%" valign="top">
			<td width="100%"><iframe style="overflow:auto;width:100%;height:100%;margin:0;padding:0" frameborder="0" 
			 src="<c:url value='/xloadTreeMenu.op'/>"></iframe></td>
		</tr>
      </table>
    </div>
</body>
</html>