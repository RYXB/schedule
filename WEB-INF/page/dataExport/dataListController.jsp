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
     dataForm.action="<c:url value='/addTabledata.op'/>";
     document.dataForm.operate.value="add";
     dataForm.method="get";
     dataForm.submit();
  }
  function doStart(){
     dataForm.action="<c:url value='/tabledataExport.op'/>";
     dataForm.method="get";
     dataForm.submit();
  }
  function doUpdateInfo(Dbtns){
	  document.dataForm.dbTns.value=Dbtns;
	  dataForm.action="<c:url value='/addTabledata.op'/>";
	  document.dataForm.operate.value="update";
	  dataForm.method="get";
	  dataForm.submit();
  }
  function doDetailInfo(Dbtns){
      document.dataForm.querydbTns.value=Dbtns;
	  dataForm.action="<c:url value='/getDbTableList.op'/>";
	  dataForm.method="get";
	  dataForm.submit();
  }
  function doDeleteInfo(Dbtns){
     if(confirm("您好，将删除所有该数据源的表，确认删除？")){
        document.dataForm.querydbTns.value=Dbtns;
	    dataForm.action="<c:url value='/deleteDb.op'/>";
	    dataForm.method="post";
	    dataForm.submit();
	 }
  }    
</script>

<body>
<form name="dataForm" action="<c:url value='/tabledataExport.op' />" method="post">
<input name="operate" value="" type="hidden">
<input name="querydbTns" value="" type="hidden">
<table class="top">
	<tr>
		<td class="headtitle">数据源列表</td>
	</tr>
</table>
<table class="content">
	<tr class="body">
	    <td class="listhead">数据源ID：</td>
		<td class="listhead"><spring:bind path="command.dbTns">
			<input type="text" name="<c:out value='${status.expression }'/>"
				style="width: 160" maxlength="20"
				value="<c:out value='${status.value }'/>" />
			<font color="red"><c:out value="${status.errorMessage}"></c:out></font>
		</spring:bind></td>
		<td class="listhead">数据源实例：</td>
		<td class="listhead"><spring:bind path="command.dbServer">
			<input type="text" name="<c:out value='${status.expression }'/>"
				style="width: 160" maxlength="20"
				value="<c:out value='${status.value }'/>" />
			<font color="red"><c:out value="${status.errorMessage}"></c:out></font>
		</spring:bind></td>
		<td class="listhead"></td>
		<td class="listhead"></td>
		<td align="center" colspan="2">
		<input align="center" type="button" value="   查 询     " id="go" onclick="doStart();"class="button2" />
		<input align="center" type="button" value="   新 增     " id="add" onclick="doAdd();"class="button2" />
		</td>
	</tr>
</table>

<table class="top">
	<tr>
		<td class="headtitle">数据源列表</td>
	</tr>
</table>

<table id="resultsTable" width="100%" border="1">
	<tbody id="resultsBody">
		<tr>
			<td class="headtitle" nowrap>数据源ID</td>
			<td class="headtitle" nowrap>数据库实例</td>
			<td class="headtitle" nowrap>IP地址</td>
			<td class="headtitle" nowrap>用户</td>
			<td class="headtitle" nowrap>文件存放目录</td>
			<td class="headtitle" nowrap>分隔方式</td>
			<td class="headtitle" nowrap>分隔符</td>
			<td class="headtitle" nowrap>操作</td>
		</tr>
		<c:forEach var="item" items="${list}">
			<tr class="body">
				<td class="listhead"><c:out value='${item.DB_TNS}' /></td>
				<td class="listhead">
			    	<c:choose>
					  <c:when test="${item.DB_SERVER!=null}">
						<c:out value='${item.DB_SERVER}' />
					  </c:when>
					  <c:otherwise>
							&nbsp;
					  </c:otherwise>
				    </c:choose>
				</td>
				<td class="listhead">
				    <c:choose>
					  <c:when test="${item.IP!=null}">
						<c:out value='${item.IP}' />
					  </c:when>
					  <c:otherwise>
							&nbsp;
					  </c:otherwise>
				    </c:choose>
				</td>
				<td class="listhead">
				   <c:choose>
					  <c:when test="${item.USERNAME!=null}">
						<c:out value='${item.USERNAME}' />
					  </c:when>
					  <c:otherwise>
							&nbsp;
					  </c:otherwise>
				    </c:choose>
				</td>
				<td class="listhead">
				    <c:choose>
					  <c:when test="${item.FILE_PATH!=null}">
						<c:out value='${item.FILE_PATH}' />
					  </c:when>
					  <c:otherwise>
							&nbsp;
					  </c:otherwise>
				    </c:choose>
				</td>
				<td class="listhead">
				    <c:choose>
					  <c:when test="${item.SPLIT_TYPE!=null}">
					   <c:choose>
					     <c:when test="${item.SPLIT_TYPE=='1'}">
					         定长
					      </c:when>
					    <c:otherwise>
							分隔符
					     </c:otherwise>
					  </c:choose>
					  </c:when>
					  <c:otherwise>
							&nbsp;
					  </c:otherwise>
				    </c:choose>
				</td>
				<td class="listhead">
				    <c:choose>
					  <c:when test="${item.SPLIT_CHAR!=null}">
						<c:out value='${item.SPLIT_CHAR}' />
					  </c:when>
					  <c:otherwise>
							&nbsp;
					  </c:otherwise>
				    </c:choose>
				</td>
				<td class="listhead">
				   <A class="listhead" href="#" onclick="javascript:doDetailInfo('<c:out value='${item.DB_TNS}'/>');"><u>明细</u></A>&nbsp;
				   <A class="listhead" href="#" onclick="javascript:doUpdateInfo('<c:out value='${item.DB_TNS}'/>');"><u>修改</u></A>&nbsp;
			       <A class="listhead" href="#" onclick="javascript:doDeleteInfo('<c:out value='${item.DB_TNS}'/>');"><u>删除</u></A>
			    </td>
			</tr>
		</c:forEach>
	</tbody>
</table>
</form>
</body>
</html>