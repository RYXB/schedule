<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/includes/head.jsp"%>
<html>
<head>
<title>数据导入</title>
</head>
<script type="text/javascript">
  function toSubmit(){ 
	   var str=document.all.file.value;
	   if(str!=null||str!=""){
		str = str.substring(str.lastIndexOf('.'));
		var filter = new String();
		var suffixRegex = new RegExp(".xls");
		if(!suffixRegex.test(str)){ 
			newAlertDiv("您好！模板文件上传文件的文件类型应为.xls",document.all.file,450,107);
			return ;
		}
		form.action="<c:url value="/importInfoController.op" />";
		form.submit();	  
	}
  }
  function returnClose(){
	  var file=document.getElementById("file");
	    var form=document.createElement('form');
	    document.body.appendChild(form);
	    //记住file在旧表单中的的位置
	    var pos=file.nextSibling;
	    form.appendChild(file);
	    form.reset();
	    pos.parentNode.insertBefore(file,pos);
	    document.body.removeChild(form);
  }

  function toExport(){
      form.action="<c:url value='/exportModelController.op' />";
      form.submit();   
	  }
  function toExportInfo(){
	  form.action="<c:url value='/exportInfoController.op'/>";
      form.submit();   
  }
</script>
<body background = "">   
<form action="<c:url value="/importInfoController.op" />" name="form" method="post" enctype="multipart/form-data">
    <br><br><br><br>
	 <table  align="center"   width="40%">
		<tr>
		  <td class="headtitle">数据批量导出导入</td>
		</tr>
		
    <table align="center"  width="40%" border="1" cellspacing="1" cellpadding="0">
    <tr> 
	<td  class="listhead">选择文件：</td>
	<td  class="listhead">
       	  <spring:bind path="command.file">
		     <input type="file" name="file" size="26" objName="上传文件" onkeydown="window.event.returnValue = false;" />
		  </spring:bind>
	</td>
	</tr> 
 	<tr>
	   <td class="listhead" colspan="2"><span style="color:red">注：支持Excel文件格式，数据量较大的需要等待一段时间！</span></td>
	</tr>
	<tr >
	<td  align="center"  class="listhead" colspan="2" >
 		 <input type="button" onclick="returnClose();" name="datareset" value="重置" class="button2" />&nbsp;
		 <input type="button" onclick="toSubmit();" name="import" value="导入"  class="button2" />&nbsp;
		 <input type="button" onclick="toExport();" name="export" value="模板下载"  class="button2" />&nbsp;
		 <input type="button" onclick="toExportInfo();" name="exportInfo" value="任务信息导出"  class="button2" />&nbsp;
    </td>
    </tr>
   </table>	
	</table>
</form>
</body>
</HTML>
