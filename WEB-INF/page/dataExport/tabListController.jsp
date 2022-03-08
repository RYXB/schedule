<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/includes/head.jsp"%>
<html>
<head>
<title>导出查询</title>
</head>
<script type="text/javascript">
      
      function createMask() {
  		document.body.appendChild(document.createElement("<div id='shield' style='visibility:hidden;position:absolute;top:0px;left:0px;text-align:center;vertical-align:middle;background-color:#DDD;z-index:10001;filter:alpha(opacity=75);' + shieldStyle + '></div>"));
  		document.getElementById("shield").innerHTML = "<iframe id='shieldIframe' style='width:100%;height:100%;border:none;filter:alpha(opacity=0);'></iframe>";
  		document.body.appendChild(document.createElement("<div id='loadcontent' style='visibility:hidden;position:absolute;top:0px;left:0px;background-color:#E5E5E5;text-align:center;vertical-align:middle;z-index=10002'></div>"));
  		var docHeight, docWidth;
  		with(document.body) {
  			docHeight = scrollHeight < clientHeight ? clientHeight - 4 : scrollHeight;
  			docWidth = scrollWidth < clientWidth ? clientWidth: scrollWidth;
  		} 
  		//document.getElementById('loadimg').src = "<c:url value ='/images/dialog-loading.gif' />";
  		document.getElementById("shield").style.width = (docWidth) + "px";		
  		document.getElementById("shield").style.height = (docHeight) + "px";
  		document.getElementById('loadcontent').style.left = (document.body.clientWidth - document.getElementById('loadcontent').clientWidth) / 2 + "px";
  		document.getElementById('loadcontent').style.top = (document.body.clientHeight - document.getElementById('loadcontent').clientHeight) / 2 + "px";
  		document.getElementById("shield").style.visibility = "";
  		document.getElementById("loadcontent").style.visibility = "";
  		//document.getElementById("shield").focus();
        }
      /*
      *遮盖对话框删除模块
      */
      function removeMaskStub(winObj) {
      	try {
      		with (((winObj == undefined) ? window : winObj).document) {
      			
      			getElementById("shield").removeNode(true);
      			getElementById("loadcontent").removeNode(true);
      		}
      	} catch (e) {}
      }
  function doAdd(){
     dataForm.action="<c:url value='/addSysTabInfo.op'/>";
     document.dataForm.operate.value="add";
     dataForm.method="get";
     dataForm.submit();
  }
  function doStart(){
     dataForm.action="<c:url value='/getDbTableList.op'/>";
     dataForm.method="post";
     dataForm.submit();
  }
  function doUpdateInfo(key,Dbtns){
	  document.dataForm.dbTns.value=Dbtns;
	  document.dataForm.key.value=key;
	  dataForm.action="<c:url value='/updateSysTabInfo.op'/>";
	  document.dataForm.operate.value="update";
	  dataForm.method="get";
	  dataForm.submit();
  }
  function doDeleteInfo(key,Dbtns){
    if(confirm("您好，确认删除吗？")){
       dataForm.action="<c:url value='/deleteSysTabInfo.op'/>";
	  dataForm.method="post";
	  dataForm.submit();
    }
  }
     function getAllJob(){
    	  var obj = document.getElementsByName("tableKey");    
    	  var alljob=document.getElementsByName("tableall");  
    	  if(alljob[0].checked){
    	  for(var i=0;i<obj.length;i++){
    		  obj[i].status="true";
            }
    	  }else{
    		  for(var i=0;i<obj.length;i++){
    			  obj[i].status=null;
             }
          }
      }
  function checkboxValidata(){
      var obj = document.getElementsByName("tableKey");     
 	  for(var i=0;i<obj.length;i++){
   	   if(obj[i].checked){
 		     return true;
        }
   }
      return false;
 } 
  function doExport(){
   if(checkboxValidata()){
       var obj = document.getElementsByName("tableKey");
            
 	  for(var i=0;i<obj.length;i++){
   	   if(obj[i].checked){
 		     document.dataForm.exportTables.value=obj[i].value+";"+document.dataForm.exportTables.value;
        }
      }
     var exportTables=document.dataForm.exportTables.value;
     var url ="<c:url value='/addDbTask.op'/>?now="+new Date();
     window.showModalDialog(url,exportTables, "dialogWidth:500px;dialogHeight:100px;center:yes;help:no;status:no;resizable:no");
   }else{
     alert("请选择要导出的表！");
   }
  }
</script>

<body>
<form name="dataForm" action="<c:url value='/getDbTableList.op' />" method="post">
<input name="key" value="" type="hidden">
<input name="exportTables" value="" type="hidden">
<input name="operate" value="" type="hidden">
<input name="querydbTns" value="" type="hidden">
<table class="top">
	<tr>
		<td class="headtitle">导出数据表列表</td>
	</tr>
</table>
<table class="content">
	<tr class="body">
	    <td class="listhead">数据源ID：</td>
		<td class="listhead">
			<select name="dbTns" style="width: 160" >
			   <option value="">全部</option>
				<c:forEach var="item" items="${dbTnsList}">
					<option value='<c:out value="${item.CODE}"/>'
						<c:if test="${item.CODE == dbTns}">selected="selected"</c:if>><c:out
						value="${item.VALUE}" /></option>
				</c:forEach>
			</select>
			<font color="red"><c:out value="${status.errorMessage}"></c:out></font>
		</td>
		<td class="listhead">数据源用户：</td>
		<td class="listhead">
			<input type="text" name="username"
				style="width: 160" maxlength="20"
				value="<c:out value='${username }'/>" />
		</td>
		<td class="listhead">表英文名：</td>
		<td class="listhead">
			<input type="text" name="tabName"
				style="width: 160" maxlength="80"
				value="<c:out value='${tabName}'/>" />
		</td>
		<td align="center" colspan="2">
		<input align="center" type="button" value="   查 询     " id="go" onclick="doStart();"class="button2" />
		<input align="center" type="button" value="   新 增     " id="add" onclick="doAdd();"class="button2" />
		<input align="center" type="button" value="导入批量 " id="export" onclick="doExport();"class="button2" />
		</td>
	</tr>
</table>

<table class="top">
	<tr>
		<td class="headtitle">导出数据表列表</td>
	</tr>
</table>

<table id="resultsTable" width="100%" border="1">
	<tbody id="resultsBody">
		<tr>
		    <td class="headtitle" style="width:3%" nowrap><input type="checkbox" name="tableall" onclick="getAllJob();" value="1" />选择</td>
			<td class="headtitle" nowrap>数据源</td>
			<td class="headtitle" nowrap>用户</td>
			<td class="headtitle" nowrap>表英文名</td>
			<td class="headtitle" nowrap>表中文名</td>
			<td class="headtitle" nowrap>表字段</td>
			<td class="headtitle" nowrap>文件名</td>
			<td class="headtitle" nowrap>操作</td>
		</tr>
		<c:forEach var="item" items="${list}">
			<tr class="body">
			    <td class="listhead" style="width:3%"><input type="checkbox" name="tableKey" value="<c:out value='${item.KEY}'/>" /></td>
				<td class="listhead"><c:out value='${item.DB_TNS}' /></td>
				<td class="listhead">
			    	<c:choose>
					  <c:when test="${item.TAB_SCHEMA !=null}">
						<c:out value='${item.TAB_SCHEMA}' />
					  </c:when>
					  <c:otherwise>
							&nbsp;
					  </c:otherwise>
				    </c:choose>
				</td>
				<td class="listhead">
				    <c:choose>
					  <c:when test="${item.TAB_NAME !=null}">
						<c:out value='${item.TAB_NAME}' />
					  </c:when>
					  <c:otherwise>
							&nbsp;
					  </c:otherwise>
				    </c:choose>
				</td>
				<td class="listhead">
				   <c:choose>
					  <c:when test="${item.TAB_CN_NAME !=null}">
						<c:out value='${item.TAB_CN_NAME}' />
					  </c:when>
					  <c:otherwise>
							&nbsp;
					  </c:otherwise>
				    </c:choose>
				</td>
				<td class="listhead">
				    <c:choose>
					  <c:when test="${item.COL_LIST !=null}">
						<c:out value='${item.COL_LIST}' />
					  </c:when>
					  <c:otherwise>
							&nbsp;
					  </c:otherwise>
				    </c:choose>
				</td>
				<td class="listhead">
				    <c:choose>
					  <c:when test="${item.FILE_NAME!=null}">
						<c:out value='${item.FILE_NAME}' />
					  </c:when>
					  <c:otherwise>
							&nbsp;
					  </c:otherwise>
				    </c:choose>
				</td>
				<td class="listhead">
				   <A class="listhead" href="#" onclick="javascript:doUpdateInfo('<c:out value='${item.KEY}'/>','<c:out value='${item.DB_TNS}'/>');"><u>修改</u></A>&nbsp;
			       <A class="listhead" href="#" onclick="javascript:doDeleteInfo('<c:out value='${item.KEY}'/>','<c:out value='${item.DB_TNS}'/>');"><u>删除</u></A>
			    </td>
			</tr>
		</c:forEach>
	</tbody>
</table>
</form>
</body>
</html>