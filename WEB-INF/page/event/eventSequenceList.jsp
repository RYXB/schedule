<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/includes/head.jsp" %>
<html>
<head>
<title>任务执行计划维护列表</title>
<script type="text/javascript"> 
   $(function(){     
	  $("#table").datagrid({  
	    columns:[[  {field:'EVENTDATE',title:'事件产生时间',width:150,align:'left',formmatter:function(value,rec){
	                      return date.Format("yyyy-MM-dd HH:mm:ss")+"";
	                }},
			        {field:'EVENTID',title:'事件标识',width:200,align:'left'},
			        {field:'EVENTTYPE',title:'事件类型',width:120,align:'left',formatter:function(value,rec){
			           <c:forEach var="item" items="${eventTypeList}">
			              if(value=="<c:out value='${item.key}'/>")
				            return "<c:out value='${item.value}' />";
			           </c:forEach> 
			        }},
			        {field:'BATCHDATE',title:'批量时间',width:150,align:'left'} 
 				]],
		pagination:true,
		rownumbers:true,
		url:"<c:url value='/eventSequenceController.op'/>",
 		fit:true,
		nowrap: true,
		striped: true,
		border : false,
		title:"事件序列列表",
		singleSelect:true,
		singleSelect:true, 
		checkbox:true,
		pageList:[50,80,100,150],
		pageSize:80,
		onLoadSuccess:function(){
		   removeMaskStub();
		}  
	   }); 
      });  
       function doquery(){ 
          var eventType = $("#Text_eventType").combobox("getValue");
          var eventId = $("#Text_eventId").val();
          $("#table").datagrid("load",{"eventId":eventId,"eventType":eventType});
       }
      function doRefresh(){
          var eventType = $("#Text_eventType").combobox("getValue");
          var eventId = $("#Text_eventId").val();
          $("#table").datagrid("reload",{"eventId":eventId,"eventType":eventType});
      } 
</script>
</head>
<body  class="easyui-layout" style="background:#eef3fa;">

<div id='shield' style='width:100%;height:100%;position:absolute;text-align:center;vertical-align:middle;background-color:#DDDDDD;z-index:10001;filter:alpha(opacity=75);'>
<iframe id='shieldIframe' style='width:100%;height:100%;border:none;frameborder:0;filter:alpha(opacity=0);'></iframe>
</div>
<div id='loadcontent' style='position:absolute;top:40%;left:45%;background-color:#E5E5E5;text-align:center;vertical-align:middle;z-index=10002'>
<img id='loadimg' align="center"  src="<c:url value='/images/dialog-loading.gif'/>"></img><br></br><div id='loadtext' >正在加载，请稍候……</div>
</div>

<div region="north"    style="width: 100%; height: 55px;background:#eef3fa;">
<form  id="searchForm" name="searchForm"   method="post">  
<table>  
	<tr >
	     <td  align="right"   width=" 10%">事件标识：</td>
	     <td width="15%"  align="left"  >
	        <input type="text" name="eventId"   id="Text_eventId"  style="width: 160"  class="easyui-validatebox" />
	     </td>
	     <td  align="right"   width=" 10%">事件类型：</td>
	     <td width="15%"  align="left"  >
	        <select name="eventType" id="Text_eventType" style="width: 160" class="easyui-combobox" panelHeight="auto">
				<option value="">全部</option>
				<c:forEach var="item" items="${eventTypeList}">
					<option value="<c:out value='${item.key}'/>"><c:out value="${item.value}" /></option>
				</c:forEach>
			</select>
	     </td>
	     <td  align="right"   width=" 10%"></td>
	     <td width="15%"  align="left"  > </td>
	     <td  align="right"   width=" 10%"></td> 
	     <td align="right" width="15%"><a onclick="doquery()" class="easyui-linkbutton" iconCls="icon-search">查询</a></td>
	</tr> 
</table> 
</form>
</div>
<div region="center"  style="width:100%;height:100%;background:#eef3fa;" >
	<table id="table" width="100%" >
	</table>
</div> 
</body>
</html>



