<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/includes/head.jsp" %>
<html>
<head>
<title>任务作业维护列表</title>
<script type="text/javascript">
  var flag=0;
  var detailDialog;
  var errmessageDialog;
  var ruledialog;
  var jobDependDialog;
  $(function(){    
 $("#Param_isScanJob").combobox({
    onChange:function(newValue,oldValue){
      if(newValue=="1"){
        $("#Param_scanDuration").val("");
        $("#Param_scanDuration").numberbox("enable");
      }else{
         $("#Param_scanDuration").val("");
        $("#Param_scanDuration").numberbox("disable");
      }
    }
 });
	  $("#table").datagrid({  
	    columns:[[  {field:'TASKNAME',title:'任务名称',width:200,align:'left'},
	                {field:'JOBID',title:'作业编号',width:200,align:'left'},
 			        {field:'DESCRIBE',title:'计划描述',width:120,align:'left',formatter:function(value,rec){
			           if(value==null||value==""){
			              return "无";
			           }else{
			              return "<a href='#' style='color:#660000;'>"+value+"</a>";
			           } 
			        }},
 			        {field:'JOBTYPE',title:'作业类型',width:90,align:'left',formatter:function(value,rec){
			           <c:forEach var="item" items="${jobTypeList}">
			              if(value=="<c:out value='${item.key}'/>")
				            return "<c:out value='${item.value}' />";
			           </c:forEach> 
			        }},
			        {field:'STATE',title:'状态',width:80,align:'left',formatter:function(value,rec){ 
			              if(value=="1"){
				            return "有效"; 
				          }else{
				             if(value=="1"){
				                 return "无效"; 
				              }else{
				                  return "";
				              }
				          } 
				    }},
			        {field:'JOBCONTENT',title:'执行的作业内容',width:200,align:'left'},
			        {field:'FIXPARAM',title:'固定参数',width:200,align:'left'},
			        {field:'CONCURRENT',title:'并发条件',width:200,align:'left'},
			        {field:'ATTACHPARAM',title:'附加参数',width:200,align:'left'},
			        {field:'ISSCANJOB',title:'是否为扫描类作业',width:200,align:'left',formatter:function(value,rec){
			           <c:forEach var="item" items="${scanJobflagList}">
			              if(value=="<c:out value='${item.key}'/>")
				            return "<c:out value='${item.value}' />";
			           </c:forEach> 
			        }},
			        {field:'SCANDURATION',title:'扫描持续多久（分钟）',width:200,align:'left'},
			        {field:'PRIORITY',title:'优先级',width:200,align:'left'} 
 				]],
		pagination:true,
		rownumbers:true,
		url:"<c:url value='/newJobInfoController.op'/>",
		queryParams:{"taskNo":$("#Text_taskNo").combobox("getValue")},
 		fit:true,
		nowrap: true,
		striped: true,
		border : false,
		title:"任务作业列表",
		singleSelect:true,
		singleSelect:true,
		toolbar : [{   id : "button-add",	
		               text : "新增",
		               iconCls : "icon-add",
		               handler :function(){
		                  $("#detailform").form("clear"); 
		                  detailDialog.dialog("open"); 
		                  $("#detailform").form().find(".easyui-validatebox").removeAttr("readonly"); 
                          $("#detailform").form().find(".easyui-validatebox").removeAttr("style"); 
                          $("#detailform").form().find(".easyui-combobox").combobox("enable");
                          $("#detailform").form().find(".easyui-numberbox").numberbox("enable");
                          $("#detailform").form().find(".easyui-datebox").datebox("enable"); 
			               $("#Param_taskId").attr("readonly","readonly");
			              $("#Param_taskId").css("color","666");
			              $("#Param_taskName").attr("readonly","readonly");
			              $("#Param_taskName").css("color","666");  
			              document.detailform.flag.value="add"; 
			              $("#detailform").form("load", { 
				                taskId:$("#Text_taskNo").combobox("getValue"),
               	                taskName:$("#Text_taskNo").combobox("getText") ,
               	                  priority:"5"
			              });  
		               }
	               },{   id : "button-edit",	
		               text : "修改",
		               iconCls : "icon-edit",
		               handler :function(){ 
		                  var row = $("#table").datagrid("getSelected");  
		                  if(row!=null&&row!=""){
			              $("#detailform").form("clear");
			              document.detailform.flag.value="edit";   
			              $("#detailform").form().find(".easyui-validatebox").removeAttr("readonly"); 
                          $("#detailform").form().find(".easyui-validatebox").removeAttr("style"); 
                          $("#detailform").form().find(".easyui-combobox").combobox("enable");
                          $("#detailform").form().find(".easyui-numberbox").numberbox("enable");
                          $("#detailform").form().find(".easyui-datebox").datebox("enable"); 
                          $("#Param_taskId").attr("readonly","readonly");
			              $("#Param_taskId").css("color","666");  
			              $("#Param_taskName").attr("readonly","readonly");
			              $("#Param_taskName").css("color","666");  
			              $("#Param_jobId").attr("readonly","readonly");
			              $("#Param_jobId").css("color","666");  
			              detailDialog.dialog("open"); 
			              if($("#Param_isScanJob").combobox("getValue")=="1"){ 
                                 $("#Param_scanDuration").numberbox("enable");
                          }else{ 
                                 $("#Param_scanDuration").numberbox("disable");
                          }  
			              $("#detailform").form("load", { 
				                               taskId:row.TASKID,
               	                               taskName:row.TASKNAME,
               	                               jobId:row.JOBID,
               	                               jobType:row.JOBTYPE,
               	                               describe:row.DESCRIBE,
               	                               jobContent:row.JOBCONTENT,
               	                               fixParam:row.FIXPARAM,
               	                               concurrent:row.CONCURRENT,
               	                               attachParam:row.ATTACHPARAM,
               	                               isScanJob:row.ISSCANJOB,
               	                               scanDuration:row.SCANDURATION,
               	                               priority:row.PRIORITY,
               	                               state:row.STATE 
			              });   
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
			              
			              $("#detailform").form().find(".easyui-validatebox").attr("readonly","readonly"); 
                          $("#detailform").form().find(".easyui-validatebox").css("color","666"); 
                          $("#detailform").form().find(".easyui-combobox").combobox("disable");
                          $("#detailform").form().find(".easyui-numberbox").numberbox("disable");  
                          $("#detailform").form().find(".easyui-datebox").datebox("disable"); 
			              detailDialog.dialog("open"); 
			               $("#detailform").form("load", {
				                               taskId:row.TASKID,
               	                               taskName:row.TASKNAME,
               	                               jobId:row.JOBID,
               	                               jobType:row.JOBTYPE,
               	                               describe:row.DESCRIBE,
               	                               jobContent:row.JOBCONTENT,
               	                               fixParam:row.FIXPARAM,
               	                               concurrent:row.CONCURRENT,
               	                               attachParam:row.ATTACHPARAM,
               	                               isScanJob:row.ISSCANJOB,
               	                               scanDuration:row.SCANDURATION,
               	                               priority:row.PRIORITY,
               	                               state:row.STATE
			              }); 
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
               	                               jobId:row.JOBID,
               	                               jobType:row.JOBTYPE,
               	                               describe:row.DESCRIBE,
               	                               jobContent:row.JOBCONTENT,
               	                               fixParam:row.FIXPARAM,
               	                               concurrent:row.CONCURRENT,
               	                               attachParam:row.ATTACHPARAM,
               	                               isScanJob:row.ISSCANJOB,
               	                               scanDuration:row.SCANDURATION,
               	                               priority:row.PRIORITY,
               	                               state:row.STATE
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
	               },{ id : "button-search",	
		               text : "查看作业依赖",
		               iconCls : "icon-search",
		               handler :function(){
		                  var row = $("#table").datagrid("getSelected");  
		                  if(row!=null&&row!=""){
		                      /*
		                      $("#uptree").tree({ 
			                       url: "<c:url value='/menuTreeDataList.op'/>?taskId="+row.TASKID+"&jobId="+row.TASKID+"&jobNo="+row.JOBID+"&flag=up&now="+new Date(),
			                       onClick:function(obj){
				                      createMask();   
    			                   }
		                       }); 
		                       $("#downtree").tree({ 
			                       url: "<c:url value='/menuTreeDataList.op'/>?taskId="+row.TASKID+"&jobId="+row.TASKID+"&jobNo="+row.JOBID+"&flag=down&now="+new Date(),
			                       onClick:function(obj){
				                      createMask();   
    			                   }
		                       });
		                       */
		                       document.getElementById("ruleFrame").src="<c:url value='/frameTree.op'/>?taskId="+row.TASKID+"&jobId="+row.JOBID+"&jobNo="+row.JOBID+"&now="+new Date(),
 	                           ruledialog.dialog("open"); 
			              }else{
			                $.messager.show({
					             msg : "请选择要查看的单条记录！",
					             title :"提示"
				             });
			              }
		               }
	               },{ id : "button-addDepends",	
		               text : "添加作业依赖",
		               iconCls : "icon-add",
		               handler :function(){
		                  var row = $("#table").datagrid("getSelected");  
		                  if(row!=null&&row!=""){
			                 document.getElementById("jobDependFrame").src="<c:url value='/dependencesJobInfoController.op'/>?taskId="+row.TASKID+"&jobId="+row.JOBID+"&now="+new Date();
			                 jobDependDialog.dialog("open");
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
	       }else{
	         if(field=="ERRMSG"){
	           if(row.ERRMSG!=null&&row.ERRMSG!=""){
 	             document.getElementById("message").innerText=row.ERRMSG;
 	             errmessageDialog.dialog("open"); 
 	           }
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
      ruledialog=$("#ruledialog").dialog({
		     modal : true,
		     maximizable:true,
		     minimizable:true,
		     title : "作业依赖关系",
		     resizable : true,
		     closed:true,
		     buttons : [ {
			   text : "取消",
			   iconCls : "icon-cancel",
			   handler : function() {
			       ruledialog.dialog("close");
		     }
	         }] 
          }); 
       jobDependDialog=$("#jobDependDialog").dialog({
		     modal : true,
	 	     maximizable:true,
	      	 minimizable:true,
		     title : "作业依赖关系",
		     resizable : true,
		     closed:true,
		     buttons : [ {
			   text : "确定",
			   iconCls : "icon-ok",
			   handler : function() {
			       document.frames["jobDependFrame"].window.doAddDependenceJobs();
 		       }
	         }, {
			   text : "取消",
			   iconCls : "icon-cancel",
			   handler : function() {
			       jobDependDialog.dialog("close");
		     }
	         }] 
          }); 
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
			     if(!confirm("您好，是否确认维护数据？")){
			        return false;
			     } 
			     if($("#Param_attachParam").val()==""&&$("#Param_jobType").combobox("getValue")=="4"){
			        alert("附加参数必须输入远程连接标识！");
			        return false;
			     } 
			  $("#detailform").form("submit",{
                  url:"<c:url value='/editJobInfoController.op'/>",
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
          var taskNo = $("#Text_taskNo").combobox("getValue");
          var jobId = $("#Text_jobId").val();
          $("#table").datagrid("load",{"taskNo":taskNo,"jobId":jobId});
       }
      function doRefresh(){ 
          var taskNo = $("#Text_taskNo").combobox("getValue");
          var jobId = $("#Text_jobId").val();
          $("#table").datagrid("reload",{"taskNo":taskNo,"jobId":jobId });
      } 
      function dialogClose(){
        jobDependDialog.dialog("close");
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
<input name="rulename" value="" type="hidden">
<table>  
	<tr >
	     <td  align="right"   width=" 10%">任务编号：</td>
	     <td width="50%"  align="left"  >
	        <select name="taskNo" style="width: 360" id="Text_taskNo"  class="easyui-combobox" editable="false"  panelHeight="200"> 
			  <c:forEach var="item" items="${taskList}">
				<option value='<c:out value="${item.TASKID}"/>'><c:out value="${item.TASKID}"/>（<c:out value="${item.TASKNAME}" />）</option>
			  </c:forEach>
			  </select>
 	     </td>
	     <td  align="right"   width=" 10%">作业编号：</td>
	     <td width="15%"  align="left"  >
	        <input type="text" name="jobId"   id="Text_jobId"  style="width: 160"  class="easyui-validatebox" />
	     </td> 
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
<div id="detailDialog" title="作业明细"     style="width:700px;height:450px;background:#eef3fa;">
	<form name="detailform"  id="detailform" action=""   method="post"> 
	<input name="flag" value="" type="hidden">
    <table  width="100%">   
	<tr >
		<td height="30" align="right" >任务编号：</td>
		<td align="left" ><spring:bind path="command.taskId">
			<input type="text" name="<c:out value='${status.expression }'/>"  id="Param_taskId" size="44"   class="easyui-validatebox"  required="true"  style="width: 300" maxlength="20" readonly="readonly" value="<c:out value='${taskMap.TASKID }'/>" />
		</spring:bind></td>
	</tr>
	<tr >
		<td height="30" align="right" >任务名称：</td>
		<td align="left" ><spring:bind path="command.taskName">
			<input type="text" name="<c:out value='${status.expression }'/>"  id="Param_taskName" size="44"   class="easyui-validatebox"  required="true"  style="width: 300" readonly="readonly" maxlength="80" value="<c:out value='${taskMap.TASKNAME }'/>" />
		</spring:bind></td>
	</tr>
	<tr >
		<td height="30" align="right" >作业编号：</td>
		<td align="left" ><spring:bind path="command.jobId">
			<input type="text" name="<c:out value='${status.expression }'/>"  id="Param_jobId" size="44"   class="easyui-validatebox"  required="true"  style="width: 300" maxlength="40"
				value="<c:out value='${status.value }'/>" />
 		</spring:bind></td>
	</tr>
	<tr >
		<td height="30" align="right" >作业类型：</td>
		<td align="left" ><spring:bind path="command.jobType">
			<select name="<c:out value='${status.expression }'/>" id="Param_jobType" panelHeight="auto" editable="false" class="easyui-combobox" required="true"  style="width: 300">
				<c:forEach var="item" items="${jobTypeList}">
					<option value="<c:out value='${item.key}'/>"><c:out value="${item.value}" /></option>
				</c:forEach>
			</select>
		</spring:bind></td>
	</tr>
	<tr >
		<td height="30" align="right" >扫描类作业：</td>
		<td align="left" ><spring:bind path="command.isScanJob">
			<select name="<c:out value='${status.expression }'/>"  id="Param_isScanJob" panelHeight="auto" editable="false" class="easyui-combobox"   style="width: 300">
 				<c:forEach var="item" items="${scanJobflagList}">
					<option value="<c:out value='${item.key}'/>" ><c:out value="${item.value}" /></option>
				</c:forEach>
			</select>
		</spring:bind></td>
	</tr>
	<tr >
		<td height="30" align="right" >扫描持续时间（分钟）：</td>
		<td align="left" ><spring:bind path="command.scanDuration">
			<input type="text" name="<c:out value='${status.expression }'/>" id="Param_scanDuration"  title="不填写则一直扫描，直到返回成功或被中断" class="easyui-numberbox" size="44"   maxlength="8" value="<c:out value='${status.value }'/>" />
 		</spring:bind></td>
	</tr>
	<tr >
		<td height="30" align="right" >优先级：</td>
		<td align="left" ><spring:bind path="command.priority">
			<input type="text" name="<c:out value='${status.expression }'/>" min="1" id="Param_priority" title="默认为5，1优先级最高，9优先级最低" class="easyui-numberbox" size="44"  maxlength="1" value="<c:out value='${status.value }'/>" />
 		</spring:bind></td>
	</tr>
	<tr >
		<td height="30" align="right" >状态：</td>
		<td align="left" >
		<spring:bind path="command.state">
			<select name="<c:out value='${status.expression }'/>" title="默认值为有效，无效的作业直接忽略，执行后续作业" panelHeight="auto" editable="false" class="easyui-combobox" style="width: 300">
				<option value="1">有效</option>
				<option value="0">失效</option>
			</select>
		</spring:bind></td>
	</tr>
	<tr >
		<td height="30" align="right" >功能描述：</td>
		<td align="left" ><spring:bind path="command.describe">
			<textarea name="<c:out value='${status.expression }'/>"  class="easyui-validatebox" required="true" data-option="validType:'maxLength[1000]'" cols="46" rows="4" wrap="VIRTUAL" ></textarea>
		</spring:bind></td>
	</tr>
	<tr >
		<td height="30" align="right" >执行作业内容：</td>
		<td align="left" ><spring:bind path="command.jobContent">
			<textarea name="<c:out value='${status.expression }'/>" class="easyui-validatebox" required="true" data-option="validType:'maxLength[200]'" cols="46" rows="4" wrap="VIRTUAL" ></textarea>
		</spring:bind></td>
	</tr>
	<tr >
		<td height="30" align="right" >固定参数：</td>
		<td align="left" ><spring:bind path="command.fixParam">
			<textarea name="<c:out value='${status.expression }'/>"class="easyui-validatebox"  data-option="validType:'maxLength[500]'" cols="46" rows="4" wrap="VIRTUAL" ></textarea>
		</spring:bind></td>
	</tr>
	<tr >
		<td height="30" align="right" >并发条件：</td>
		<td align="left" ><spring:bind path="command.concurrent">
			<textarea name="<c:out value='${status.expression }'/>"  class="easyui-validatebox"  data-option="validType:'maxLength[200]'" cols="46" rows="4" wrap="VIRTUAL" ></textarea>
		</spring:bind></td>
	</tr>
	<tr >
		<td height="30" align="right" >附加参数：</td>
		<td align="left" ><spring:bind path="command.attachParam"> 
			<textarea name="<c:out value='${status.expression }'/>" id="Param_attachParam" title="作业类型为执行远程系统脚本时，此处要填写远程连接标识;若为其他作业类型，附加参数可以为空" class="easyui-validatebox"  data-option="validType:'maxLength[500]'" cols="46" rows="4" wrap="VIRTUAL" ></textarea>
		</spring:bind></td>
	</tr>
	<tr >
		<td align="center"  colspan="2"><font color="red">说明：附加参数、是对固定参数的补充！</font>
		</td>
	</tr>
   </table>
</form>
</div> 

<div id="ruledialog" style="background:#eef3fa;padding:5px;width:900px;height:450px;"> 
   <!-- <div class="easyui-layout" fit="true">
	 <div  region="center" title="向上依赖作业" style="background:#eef3fa;width:300px;">
	     <div id="uptree">
	     </div>
	  </div>
	 <div  region="west" title="向下触发作业"style="background:#eef3fa;width:300px;">
	     <div id="downtree">
	     </div>
	  </div> 
	 </div>-->
	 <iframe id="ruleFrame" name="ruleFrame" frameborder="0" width="100%" height="100%" src=""></iframe>
 </div>
 
 <div id="jobDependDialog" style="background:#eef3fa;width:800px;height:450px;"> 
	 <iframe id="jobDependFrame" name="jobDependFrame" frameborder="0" width="100%" height="100%" src=""></iframe>
 </div>
</body>
</html>


