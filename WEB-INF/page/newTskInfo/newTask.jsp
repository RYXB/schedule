<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/includes/head.jsp" %>
<html>
<head>
<title>任务列表</title>
<script type="text/javascript">
   var flag=0;
  var detailDialog;
  var errmessageDialog;
  $(function(){  
       $("#Param_currentbatchdate").datebox({
          formatter:function(date){  
               return date.Format("yyyyMMdd")+"";
          }
       });        
	  $("#table").datagrid({ 
	    columns:[[  {field:'TASKID',title:'任务编号',width:150,align:'left'},
			        {field:'TASKNAME',title:'任务名称',width:200,align:'left'},
			        {field:'DESCRIBE',title:'功能描述',width:120,align:'left',formatter:function(value,rec){
			           if(value==null||value==""){
			              return "无";
			           }else{
			              return "<a href='#'  style='color:#660000;'>"+value+"</a>";
			           } 
			        }},
			        {field:'CURRENTBATCHDATE',title:'最新批量时间',width:80,align:'left'},
			        {field:'SERVERID',title:'所属服务器',width:80,align:'left'},
			        {field:'ERRORINTERRUPTED',title:'是否错误中断',width:100,align:'left',formatter:function(value,rec){
			           <c:forEach var="item" items="${errorinterrupted}">
			              if(value=="<c:out value='${item.key}'/>")
				            return "<c:out value='${item.value}' />";
			           </c:forEach> 
			        }},
			        {field:'THREADCOUNT',title:'开启线程数',width:80,align:'left'},
			        {field:'WRITEEVENTFLAG',title:'是否写事件',width:100,align:'left',formatter:function(value,rec){
			           <c:forEach var="item" items="${writeeventflag}">
			              if(value=="<c:out value='${item.key}'/>")
				            return "<c:out value='${item.value}' />";
			           </c:forEach> 
			        }},
			        {field:'SCANTHREADCOUNT',title:'扫描类线程池线程数',width:120,align:'left'},
			        {field:'SCANJOBINTERVAL',title:'扫描类作业扫描时间',width:120,align:'left'},
			        {field:'THREADPOOLMAXSIZE',title:'线程池最大容量',width:120,align:'left'},
			        {field:'SCANTHREADPOOLMAXSIZE',title:'扫描类线程池最大容量',width:150,align:'left'} 
 				]],
		pagination:true,
		rownumbers:true,
		url:"<c:url value='/newTaskController.op'/>",
 		fit:true,
		nowrap: true,
		striped: true,
		border : false,
		title:"任务维护列表",
		singleSelect:true,
		singleSelect:true,
		toolbar : [{   id : "button-add",	
		               text : "新增",
		               iconCls : "icon-add",
		               handler :function(){
		                  $("#detailform").form("clear");
		                  document.detailform.flag.value="add";
		                  detailDialog.dialog("open");
		                  $("#detailform").form().find(".easyui-validatebox").removeAttr("readonly"); 
                          $("#detailform").form().find(".easyui-validatebox").removeAttr("style"); 
                          $("#detailform").form().find(".easyui-combobox").combobox("enable");
                          $("#detailform").form().find(".easyui-numberbox").numberbox("enable");
                          $("#detailform").form().find(".easyui-datebox").datebox("enable");
		               }
	               },{   id : "button-edit",	
		               text : "修改",
		               iconCls : "icon-edit",
		               handler :function(){ 
		                  var row = $("#table").datagrid("getSelected");  
		                  if(row!=null&&row!=""){
			              $("#detailform").form("clear");
			              document.detailform.flag.value="edit"; 
			              $("#detailform").form("load", {
				                 taskId:row.TASKID,
                                 taskName:row.TASKNAME,
                                 describe:row.DESCRIBE,
                                 serverid:row.SERVERID,
                                 errorinterrupted:row.ERRORINTERRUPTED,
                                 currentbatchdate:row.CURRENTBATCHDATE,
                                 threadcount:row.THREADCOUNT,
                                 writeeventflag:row.WRITEEVENTFLAG,
                                 scanThreadCount:row.SCANTHREADCOUNT,
                                 scanJobInterVal:row.SCANJOBINTERVAL,
                                 threadPoolMaxSize:row.THREADPOOLMAXSIZE,
                                 scanThreadPoolMaxSize:row.SCANTHREADPOOLMAXSIZE
			              });  
			              $("#detailform").form().find(".easyui-validatebox").removeAttr("readonly"); 
                          $("#detailform").form().find(".easyui-validatebox").removeAttr("style"); 
                          $("#detailform").form().find(".easyui-combobox").combobox("enable");
                          $("#detailform").form().find(".easyui-numberbox").numberbox("enable");
                          $("#detailform").form().find(".easyui-datebox").datebox("enable");
			              $("#Param_taskNo").attr("readonly","readonly"); 
			              $("#Param_taskNo").css("color","666"); 
			              detailDialog.dialog("open"); 
			              }else{
			                $.messager.show({
					             msg : "请选择要修改的单条记录！",
					             title :"提示"
				             });
			              } 
		               }
	               },{   id : "button-cancel",	
		               text : "删除",
		               iconCls : "icon-cancel",
		               handler :function(){ 
		                  var row = $("#table").datagrid("getSelected");  
		                  if(row!=null&&row!=""){
			              $("#detailform").form("clear");
			              document.detailform.flag.value="delete"; 
			              $("#detailform").form("load", {
				                 taskId:row.TASKID,
                                 taskName:row.TASKNAME,
                                 describe:row.DESCRIBE,
                                 serverid:row.SERVERID,
                                 errorinterrupted:row.ERRORINTERRUPTED,
                                 currentbatchdate:row.CURRENTBATCHDATE,
                                 threadcount:row.THREADCOUNT,
                                 writeeventflag:row.WRITEEVENTFLAG,
                                 scanThreadCount:row.SCANTHREADCOUNT,
                                 scanJobInterVal:row.SCANJOBINTERVAL,
                                 threadPoolMaxSize:row.THREADPOOLMAXSIZE,
                                 scanThreadPoolMaxSize:row.SCANTHREADPOOLMAXSIZE
			              });  
			              $("#detailform").form().find(".easyui-validatebox").attr("readonly","readonly"); 
                          $("#detailform").form().find(".easyui-validatebox").css("color","666"); 
                          $("#detailform").form().find(".easyui-combobox").combobox("disable");
                          $("#detailform").form().find(".easyui-numberbox").numberbox("disable");  
                          $("#detailform").form().find(".easyui-datebox").datebox("disable"); 
			              detailDialog.dialog("open"); 
			              }else{
			                $.messager.show({
					             msg : "请选择要删除的单条记录！",
					             title :"提示"
				             });
			              }
		               }
	               },{ id : "button-search",	
		               text : "查看",
		               iconCls : "icon-search",
		               handler :function(){
		                  var row = $("#table").datagrid("getSelected");  
		                  if(row!=null&&row!=""){
			              $("#detailform").form("clear");
			              document.detailform.flag.value="view";
			              
 			              $("#detailform").form("load", {
				                 taskId:row.TASKID,
                                 taskName:row.TASKNAME,
                                 describe:row.DESCRIBE,
                                 serverid:row.SERVERID,
                                 errorinterrupted:row.ERRORINTERRUPTED,
                                 currentbatchdate:row.CURRENTBATCHDATE,
                                 threadcount:row.THREADCOUNT,
                                 writeeventflag:row.WRITEEVENTFLAG,
                                 scanThreadCount:row.SCANTHREADCOUNT,
                                 scanJobInterVal:row.SCANJOBINTERVAL,
                                 threadPoolMaxSize:row.THREADPOOLMAXSIZE,
                                 scanThreadPoolMaxSize:row.SCANTHREADPOOLMAXSIZE
			              });   
			              $("#detailform").form().find(".easyui-validatebox").attr("readonly","readonly"); 
                          $("#detailform").form().find(".easyui-validatebox").css("color","666"); 
                          $("#detailform").form().find(".easyui-combobox").combobox("disable");
                          $("#detailform").form().find(".easyui-numberbox").numberbox("disable");  
                          $("#detailform").form().find(".easyui-datebox").datebox("disable");
			              detailDialog.dialog("open"); 
			              }else{
			                $.messager.show({
					             msg : "请选择要查看的单条记录！",
					             title :"提示"
				             });
			              }
		               }
	               }],
		checkbox:true,
		pageList:[50,80,100,150],
		pageSize:80,
		onLoadSuccess:function(){
		   removeMaskStub();
		},
	    onClickCell:function(rowIndex,field,value){
	       $("#table").datagrid("selectRow",rowIndex);
	       var row=$("#table").datagrid("getSelected"); 
	       if(field=="DESCRIBE"){
	         if(row.DESCRIBE!=null&&row.DESCRIBE!=""){
 	             document.getElementById("message").innerText=row.DESCRIBE;
 	             errmessageDialog.dialog("open"); 
 	          }
	       }
	    }  
	   });
	   errmessageDialog=$("#errmessageDialog").show().dialog({
		modal : true, 
		maximizable:true,
		minimizable:true,
		resizable : true,
		buttons : [{
			text : "关闭",
			iconCls : "icon-cancel",
			handler : function() {
			  errmessageDialog.dialog("close");
		    }
	    }]
       }).dialog("close"); 
	   detailDialog=$("#detailDialog").show().dialog({
		modal : true, 
		maximizable:true,
		minimizable:true,
		resizable : true,
		buttons : [{
			text : "确定",
			iconCls : "icon-ok",
			handler : function() {
			  if(document.detailform.flag.value!="view"){
			  if(document.detailform.flag.value=="delete"){
			     if(!confirm("您好，删除任务会删除所有任务相关作业等信息，是否确认维护？")){
			        return false;
			     }
			  }else{
			     if(!confirm("您好，是否确认维护数据？")){
			        return false;
			     }
			  } 
			  $("#detailform").form("submit",{
                  url:"<c:url value='/editTaskInfoController.op'/>",
                  success : function(msg) {
                     var data=eval("("+msg+")"); 
                     $.messager.show({
					     msg : data.message,
					     title :"提示"
				     });
					 if(data.flag=="true"){   
					    detailDialog.dialog("close");
					    $("#table").datagrid("reload");	
					 } 	 	
				  },
				  error:function(data){
					 $.messager.show({
						 msg : "操作失败,请检查",
						 title : "提示"
					 }); 
				  } 
                });  
		    }else{
		      detailDialog.dialog("close");
		    }
		 }
	    },{
			text : "关闭",
			iconCls : "icon-cancel",
			handler : function() {
			  detailDialog.dialog("close");
		    }
	    }]
       }).dialog("close"); 
      });  
       function doquery(){ 
          var taskName = $("#Text_taskName").val();
          var taskNo = $("#Text_taskNo").val();
          $("#table").datagrid("load",{"taskNo":taskNo,"taskName":taskName});
       }
      function doRefresh(){
          var taskName = $("#Text_taskName").val();
          var taskNo = $("#Text_taskNo").val();
          $("#table").datagrid("reload",{"taskNo":taskNo,"taskName":taskName});
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
	<tr class="body">
	     <td  align="right"   width=" 10%">任务编号：</td>
	     <td width="15%"  align="left"  >
	        <input type="text" name="taskNo"   id="Text_taskNo"  style="width: 160"  class="easyui-validatebox" />
	     </td>
	     <td  align="right"   width=" 10%">任务名称：</td>
	     <td width="15%"  align="left"  >
	        <input type="text" name="taskName"   id="Text_taskName"  style="width: 160"  class="easyui-validatebox" />
	     </td>
	     <td  align="right"   width=" 10%"></td>
	     <td width="15%"  align="left"  ></td> 
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
<div id="errmessageDialog" title="提示信息"     style="width:500px;height:300px;background:#eef3fa;"> 
 <p   ><span id="message"  style="white-space:pre;"></span></p>	    
</div>
<div id="detailDialog" title="任务明细"     style="width:700px;height:450px;background:#eef3fa;">
	<form name="detailform"  id="detailform" action=""   method="post"> 
	<input name="flag" value="" type="hidden">
    <table  width="100%">
	<tr class="body">
		<td height="30" align="right" >任务编号：</td>
		<td align="left" ><spring:bind path="command.taskId">
			<input type="text" name="<c:out value='${status.expression }'/>"  id="Param_taskNo" size="44" maxlength="20"  class="easyui-validatebox"  required="true" value="<c:out value='${status.value }'/>" />
		</spring:bind></td>
	</tr>
	<tr class="body">
		<td height="30" align="right" >任务名称：</td>
		<td align="left" ><spring:bind path="command.taskName">
			<input type="text" name="<c:out value='${status.expression }'/>" required="true"  class="easyui-validatebox" size="44"  maxlength="80"   value="<c:out value='${status.value }'/>" />
		</spring:bind></td>
	</tr>
	<tr class="body">
		<td height="30" align="right" >所属服务器：</td>
		<td align="left" ><spring:bind path="command.serverid">
			<input type="text" name="<c:out value='${status.expression }'/>" size="44" required="true"  class="easyui-validatebox" maxlength="20" value="<c:out value='${status.value }'/>" />
		</spring:bind></td>
	</tr>
	<tr class="body">
		<td height="30" align="right" >最新批量时间：</td>
		<td align="left" ><spring:bind path="command.currentbatchdate">
			<input type="text" name="<c:out value='${status.expression }'/>"  id="Param_currentbatchdate"class="easyui-datebox"  panelWidth="300" required="true"  style="width: 300"  editable="false" maxlength="14" value="<c:out value='${status.value }'/>" /> 
		</spring:bind></td>
	</tr>
	<tr class="body">
		<td height="30" align="right" >线程池线程数：</td>
		<td align="left" ><spring:bind path="command.threadcount">
			<input type="text" name="<c:out value='${status.expression }'/>" style="width: 300" class="easyui-numberbox"  required="true" maxlength="3" value="<c:out value='${status.value }'/>" />		
		</spring:bind></td>
	</tr>
	<tr class="body">
		<td height="30" align="right" >是否错误中断：</td>
		<td align="left" ><spring:bind path="command.errorinterrupted">
			<select name="<c:out value='${status.expression }'/>"  editable="false" panelHeight="auto" class="easyui-combobox"  required="true" style="width: 300">  
				<c:forEach var="item" items="${errorinterrupted}">
					<option value="<c:out value='${item.key}'/>"><c:out value="${item.value}" /></option>
				</c:forEach>
			</select>
		</spring:bind></td>
	</tr>
	<tr class="body">
		<td height="30" align="right" >是否写事件列表：</td>
		<td align="left" ><spring:bind path="command.writeeventflag">
			<select name="<c:out value='${status.expression }'/>" editable="false" panelHeight="auto" class="easyui-combobox"  required="true" style="width: 300"> 
				<c:forEach var="item" items="${writeeventflag}">
					<option value="<c:out value='${item.key}'/>"><c:out value="${item.value}" /></option>
				</c:forEach>
			</select>
		</spring:bind></td>
	</tr>
	<tr class="body">
		<td height="30" align="right" >扫描类线程池线程数：</td>
		<td align="left" ><spring:bind path="command.scanThreadCount">
			<input type="text" name="<c:out value='${status.expression }'/>" style="width: 300" class="easyui-numberbox"   maxlength="3" value="<c:out value='${status.value }'/>" /> 
		</spring:bind></td>
	</tr>
	<tr class="body">
		<td height="30" align="right" >扫描作业间隔时间（秒）：</td>
		<td align="left" ><spring:bind path="command.scanJobInterVal">
			<input type="text" name="<c:out value='${status.expression }'/>" style="width: 300" class="easyui-numberbox" maxlength="8" value="<c:out value='${status.value }'/>" /> 
		</spring:bind></td>
	</tr>
	<tr class="body">
		<td height="30" align="right" >线程池最大容量：</td>
		<td align="left" ><spring:bind path="command.threadPoolMaxSize">
			<input type="text" name="<c:out value='${status.expression }'/>" style="width: 300" class="easyui-numberbox" maxlength="4" value="<c:out value='${status.value }'/>" /> 
		</spring:bind></td>
	</tr>
	<tr class="body">
		<td height="30" align="right" >扫描类线程池最大容量：</td>
		<td align="left" ><spring:bind path="command.scanThreadPoolMaxSize">
			<input type="text" name="<c:out value='${status.expression }'/>" style="width: 300"  class="easyui-numberbox" maxlength="4" value="<c:out value='${status.value }'/>" /> 
		</spring:bind></td>
	</tr>
	<tr class="body">
		<td height="30" align="right" >功能描述：</td>
		<td align="left" ><spring:bind path="command.describe">
			<textarea name="<c:out value='${status.expression }'/>"  class="easyui-validatebox" required="true" data-option="validType:'maxLength[1000]'" cols="46" rows="4"   wrap="VIRTUAL"  ></textarea>
		</spring:bind></td>
	</tr>
	<tr  >
		<td align="center"  colspan="2"><font color="red">说明：线程数不宜设置过大、否则会造成服务器性能降低！</font>
		</td>
	</tr>
   </table>
</form>
</div> 
</body>
</html>

