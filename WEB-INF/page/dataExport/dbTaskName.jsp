<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/includes/head.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>批量任务名</title>
<script type="text/JavaScript">	

function goBack(){
	window.close();
}
function doSubmit(){
  var taskId= document.form.taskId.value;
  var taskName= document.form.taskName.value;
   var allkeys=window.dialogArguments;
  if(taskId!=""&&taskName!=""){
	document.form.allKeys.value=allkeys;
	form.target="main";
	form.submit();
	window.close();
  }else{
    alert("请输入任务名和任务编号！");
  }
}
</script>
</head>
<body style="background:#eef3fa;">
<form name="form" action="<c:url value='/addDbTask.op'/>" method="post">
<input name="allKeys" value="" type="hidden">
<table align="center" width="100%">
	<tr>
		<td class="headtitle">运行编号：</td>
		<td align="left" class="listhead">
			<input type="text" name="taskId" style="width: 160" maxlength="20" value="" />
	   </td>
	   </tr>
	   <tr>
	   <td class="headtitle">运行名称：</td>
		<td align="left" class="listhead">
			<input type="text" name="taskName" style="width: 160" maxlength="20" value="" />
	   </td>
	</tr>
</table>
	<table align="center" width="100%">
	<tr class="body">
		<td height="30" align="center" colspan="2" class="listhead">
		<input name="button22" type="button" class="button2" value="　确　　定　" onclick="javascript:doSubmit();"> 
		<input name="button222" type="button" class="button2" value="　关　　闭　" onclick="javascript:goBack();">
		</td>
	</tr>
	</table>
</form>
</body>
</html>