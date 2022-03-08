<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/includes/head.jsp" %>
<html>
<head>
<title>任务执行计划维护列表</title>
<script type="text/javascript">
   var flag=0;
  var detailDialog;
  var errmessageDialog;
  var ruledialog;
  $(function(){    
	  $("#table").datagrid({  
	    columns:[[  {field:'TASKID',title:'任务编号',width:150,align:'left'},
			        {field:'TASKNAME',title:'任务名称',width:200,align:'left'},
			        {field:'DESCRIBE',title:'计划描述',width:120,align:'left',formatter:function(value,rec){
			           if(value==null||value==""){
			              return "无";
			           }else{
			              return "<a href='#' style='color:#660000;'>"+value+"</a>";
			           } 
			        }},
			        {field:'TRIGGERRULE1',title:'触发规则',width:80,align:'left'},
			        {field:'STATE',title:'状态',width:60,align:'left',formatter:function(value,rec){
			           <c:forEach var="item" items="${stateList}">
			              if(value=="<c:out value='${item.key}'/>")
				            return "<c:out value='${item.value}' />";
			           </c:forEach> 
			        }},
			        {field:'NEXTTRIGGERDATE',title:'下次触发时间',width:120,align:'left'},
			        {field:'NEXTBATCHDATE',title:'下次批量时间',width:120,align:'left'},
			        {field:'ERRMSG',title:'错误信息',width:120,align:'left',formatter:function(value,rec){
			           if(value==null||value==""){
			              return "无";
			           }else{
			              return "<a href='#' style='color:#660000;'>"+value+"</a>";
			           } 
			        }},
			       // {field:'TRIGGERRULE2',title:'触发规则2',width:80,align:'left'},
			        //{field:'TRIGGERRULE2',title:'触发规则3',width:80,align:'left'}, 
			        //{field:'EXCEPTIVERULE',title:'不执行规则',width:80,align:'left'}, 
			        {field:'BATCHDATERULE',title:'数据日期偏移天数',width:580,align:'left',formatter:function(value,rec){
			           
			               var batchdataRule=value.replaceAll(" ","");
			               batchdataRule=batchdataRule.replace("selectto_char(##TRIGGERDATETIME##","");
			               batchdataRule=batchdataRule.replace(",'YYYYMMDD')fromdual",""); 
			               batchdataRule=batchdataRule.replace("-",""); 
			               if(batchdataRule==""){
			                  batchdataRule="0";
			               } 
			              return batchdataRule;
			        }}
 				]],
		pagination:true,
		rownumbers:true,
		url:"<c:url value='/taskPlanController.op'/>",
 		fit:true,
		nowrap: true,
		striped: true,
		border : false,
		title:"任务执行计划列表",
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
                          $("#Param_triggerRule1").attr("readonly","readonly");
			              $("#Param_triggerRule1").css("color","666"); 
			              $("#Param_triggerRule2").attr("readonly","readonly");
			              $("#Param_triggerRule3").css("color","666"); 
			              $("#Param_triggerRule3").attr("readonly","readonly");
			              $("#Param_triggerRule2").css("color","666"); 
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
                          $("#Param_triggerRule1").attr("readonly","readonly");
			              $("#Param_triggerRule1").css("color","666"); 
			              $("#Param_triggerRule2").attr("readonly","readonly");
			              $("#Param_triggerRule3").css("color","666"); 
			              $("#Param_triggerRule3").attr("readonly","readonly");
			              $("#Param_triggerRule2").css("color","666"); 
			              $("#Param_taskId").combobox("disable"); 
			              var batchdataRule=row.BATCHDATERULE.replace("select to_char(##TRIGGERDATETIME##","");
			              batchdataRule=batchdataRule.replace(", 'YYYYMMDD') from dual","");
			              batchdataRule=batchdataRule.trim();
			               batchdataRule=batchdataRule.replace("-",""); 
			               if(batchdataRule==""){
			                  batchdataRule="0";
			               }
			              detailDialog.dialog("open"); 
			              $("#detailform").form("load", {
				                 taskId:row.TASKID,
                                 describe:row.DESCRIBE,
                                 triggerRule1:row.TRIGGERRULE1,
                                 triggerRule2:row.TRIGGERRULE2,
                                 triggerRule3:row.TRIGGERRULE3,
                                 exceptiveRule:row.EXCEPTIVERULE,
                                 state:row.STATE,
                                 batchDateRuleNum:batchdataRule,
                                 batchDateRule:row.BATCHDATERULE
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
			              var batchdataRule=row.BATCHDATERULE.replace("select to_char(##TRIGGERDATETIME##","");
			              batchdataRule=batchdataRule.replace(", 'YYYYMMDD') from dual","");
			              batchdataRule=batchdataRule.trim();
			               batchdataRule=batchdataRule.replace("-",""); 
			               if(batchdataRule==""){
			                  batchdataRule="0";
			               }
			                $("#detailform").form("load", {
				                 taskId:row.TASKID,
                                 describe:row.DESCRIBE,
                                 triggerRule1:row.TRIGGERRULE1,
                                 triggerRule2:row.TRIGGERRULE2,
                                 triggerRule3:row.TRIGGERRULE3,
                                 exceptiveRule:row.EXCEPTIVERULE,
                                 state:row.STATE,
                                 batchDateRuleNum:batchdataRule,
                                 batchDateRule:row.BATCHDATERULE
			              });
			               $("#Param_batchDateRuleNum").numberbox("setValue",batchdataRule);
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
			              var batchdataRule=row.BATCHDATERULE.replace("select to_char(##TRIGGERDATETIME##","");
			              batchdataRule=batchdataRule.replace(", 'YYYYMMDD') from dual","");
			              batchdataRule=batchdataRule.trim();
			               batchdataRule=batchdataRule.replace("-",""); 
			               if(batchdataRule==""){
			                  batchdataRule="0";
			               }
 			              $("#detailform").form("load", {
				                 taskId:row.TASKID,
                                  describe:row.DESCRIBE,
                                 triggerRule1:row.TRIGGERRULE1,
                                 triggerRule2:row.TRIGGERRULE2,
                                 triggerRule3:row.TRIGGERRULE3,
                                 exceptiveRule:row.EXCEPTIVERULE,
                                 state:row.STATE,
                                 batchDateRuleNum:batchdataRule,
                                 batchDateRule:row.BATCHDATERULE
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
		resizable : true,
		maximizable:true,
		minimizable:true,
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
		resizable : true,
		     title : "调度任务执行时间配置",
		     closed:true,
		     buttons : [ {
			   text : "确定",
			   iconCls : "icon-ok",
			   handler : function() {
			      if(document.detailform.flag.value!="view"&&document.detailform.flag.value!="delete"){
			         var iframeWindow=document.frames["ruleFrame"].document;
			         document.frames["ruleFrame"].window.doSure();  
                     $("#"+document.searchForm.rulename.value).val(iframeWindow.getElementById("suretaskDef").value);
                  }
                  ruledialog.dialog("close"); 
			   }
		     },{
			   text : "取消",
			   iconCls : "icon-cancel",
			   handler : function() {
			       ruledialog.dialog("close");
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
			  $("#detailform").form().find(".easyui-validatebox").removeAttr("readonly"); 
              $("#detailform").form().find(".easyui-validatebox").removeAttr("style"); 
              $("#detailform").form().find(".easyui-combobox").combobox("enable");
              $("#detailform").form().find(".easyui-numberbox").numberbox("enable");
              $("#detailform").form().find(".easyui-datebox").datebox("enable");
              $("#Param_triggerRule1").attr("readonly","readonly");
			  $("#Param_triggerRule1").css("color","666"); 
			  $("#Param_triggerRule2").attr("readonly","readonly");
			  $("#Param_triggerRule3").css("color","666"); 
			  $("#Param_triggerRule3").attr("readonly","readonly");
			  $("#Param_triggerRule2").css("color","666"); 
			  var  rule="select to_char(##TRIGGERDATETIME## - "+$("#Param_batchDateRuleNum").numberbox("getValue")+", 'YYYYMMDD') from dual";
			  $("#Param_batchDateRule").val(rule); 
			 $("#detailform").form("submit",{
                  url:"<c:url value='/editTaskPlanController.op'/>",
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
	    },{
			text : "规则文档",
			iconCls : "icon-download",
			handler : function() {
			        searchForm.method="POST";
	                searchForm.action="<c:url value='/exportFileController.op'/>";
	                searchForm.submit();
		    }
	    }]
       }).dialog("close"); 
      });  
       function doquery(){ 
          var taskName = $("#Text_taskName").val();
          var taskNo = $("#Text_taskNo").val();
          $("#table").datagrid("load",{"taskNo":taskNo,"taskName":taskName,"state":$("#Text_state").combobox("getValue")});
       }
      function doRefresh(){
          var taskName = $("#Text_taskName").val();
          var taskNo = $("#Text_taskNo").val();
          $("#table").datagrid("reload",{"taskNo":taskNo,"taskName":taskName,"state":$("#Text_state").combobox("getValue")});
      }
    function getJobRule(textId){ 
	   var rule=$("#"+textId).val(); 
	   document.searchForm.rulename.value=textId; 
	   if(rule!=null&&rule!=""){ 
	   var iframeWindow=document.frames["ruleFrame"].document;
	   iframeWindow.getElementById("taskDef").value=rule;
	   document.frames["ruleFrame"].window.loadPage();
	   }else{
	     document.getElementById("ruleFrame").src="<c:url value='/scheduleTaskDef.op'/>";
	   }
	   ruledialog.dialog("open");
    }
    String.prototype.trim=function()
   {
     return this.replace(/(^\s*)|(\s*$)/g, "");
    };
   String.prototype.replaceAll = function(reallyDo, replaceWith, ignoreCase) { 
      if (!RegExp.prototype.isPrototypeOf(reallyDo)) { 
          return this.replace(new RegExp(reallyDo, (ignoreCase ? "gi": "g")), replaceWith); 
      } else { 
         return this.replace(reallyDo, replaceWith); 
      } 
   } ;
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
	     <td width="15%"  align="left"  >
	        <input type="text" name="taskNo"   id="Text_taskNo"  style="width: 160"  class="easyui-validatebox" />
	     </td>
	     <td  align="right"   width=" 10%">任务名称：</td>
	     <td width="15%"  align="left"  >
	        <input type="text" name="taskName"   id="Text_taskName"  style="width: 160"  class="easyui-validatebox" />
	     </td>
	     <td  align="right"   width=" 10%">状态：</td>
	     <td width="15%"  align="left"  >
	        <select name="state" style="width: 160" id="Text_state" class="easyui-combobox" editable="false"  panelHeight="auto">
			  <option value="">全部</option>
			  <c:forEach var="item" items="${stateList}">
				<option value='<c:out value="${item.key}"/>'><c:out value="${item.value}" /></option>
			  </c:forEach>
		  </select>	 
	     </td>
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
	<tr >
		<td height="30" align="right"  >任务名称：</td>
		<td align="left"  >
		<spring:bind path="command.taskId">
			<select name="<c:out value='${status.expression }'/>" id="Param_taskId" editable="false" panelHeight="200" class="easyui-combobox"  required="true"  style="width: 300">
				<c:forEach var="itemList" items="${taskList}">
					<option value="<c:out value='${itemList.TASKID}'/>"><c:out value="${itemList.TASKNAME}" /></option>
				</c:forEach>
			</select>
		</spring:bind></td>
	</tr>
	<tr >
		<td height="30" align="right" >计划描述：</td>
		<td align="left" ><spring:bind path="command.describe">
			<textarea name="<c:out value='${status.expression }'/>"  required="true"   class="easyui-validatebox" data-option="validType:'maxLength[1000]'" cols="46" rows="4" wrap="VIRTUAL"  ></textarea>
		</spring:bind></td>
	</tr>
	<tr >
		<td height="30" align="right" >触发规则：</td>
		<td align="left" ><spring:bind path="command.triggerRule1">
			<input type="text" name="<c:out value='${status.expression }'/>" id="Param_triggerRule1"   size="44" maxlength="20"  class="easyui-validatebox"  required="true"  value="<c:out value='${status.value }'/>" />
 		</spring:bind>
 		<a onclick="getJobRule('Param_triggerRule1')" class="easyui-linkbutton"  id="triggerRule1_btn"   plain="true"   iconCls="icon-jobrule">规则</a>
 		</td>
 		
	</tr>
	<tr  style="display:none;">
		<td height="30" align="right" >触发规则2：</td>
		<td align="left" ><spring:bind path="command.triggerRule2">
			<input type="text" name="<c:out value='${status.expression }'/>" id="Param_triggerRule2"     size="44" maxlength="20"  class="easyui-validatebox" value="<c:out value='${status.value }'/>" />
		</spring:bind>
		<a onclick="getJobRule('Param_triggerRule2')" class="easyui-linkbutton"  id="triggerRule2_btn"   plain="true"   iconCls="icon-jobrule">规则</a>
		</td>
	</tr>
	<tr  style="display:none;">
		<td height="30" align="right" >触发规则3：</td>
		<td align="left" ><spring:bind path="command.triggerRule3">
			<input type="text" name="<c:out value='${status.expression }'/>" id="Param_triggerRule3"   size="44" maxlength="20"  class="easyui-validatebox" value="<c:out value='${status.value }'/>" />
 		</spring:bind>
 		<a onclick="getJobRule('Param_triggerRule3')" class="easyui-linkbutton"  id="triggerRule1_btn"   plain="true"   iconCls="icon-jobrule">规则</a>
 		</td>
	</tr>
	<tr  style="display:none;">
		<td height="30" align="right" >不执行规则：</td>
		<td align="left" ><spring:bind path="command.exceptiveRule">
			<textarea name="<c:out value='${status.expression}'/>"
				title="判断某个批量日期是否触发的SQL中，批量日期标记为##DATADATE##,返回记录数不为0，则表示该批量日期不执行"
				    class="easyui-validatebox" data-option="validType:'maxLength[200]'" cols="46" rows="4"  wrap="VIRTUAL" ></textarea>
		</spring:bind></td>
	</tr>
	<tr >
		<td height="30" align="right" >状态：</td>
		<td align="left" ><spring:bind path="command.state">
			<select name="<c:out value='${status.expression }'/>" editable="false" panelHeight="auto" class="easyui-combobox"  required="true" style="width: 300">
				<c:forEach var="item" items="${stateList}">
					<option value="<c:out value='${item.key}'/>"><c:out value="${item.value}" /></option>
				</c:forEach>
			</select>
		</spring:bind></td>
	</tr>  
	<tr style="display:none;">
		<td height="30" align="right" >批量时间规则：</td>
		<td align="left" ><spring:bind path="command.batchDateRule">
			<textarea name="<c:out value='${status.expression }'/>" id="Param_batchDateRule"
				title="根据知识库所在的SQL规则，算出批量日期，##TRIGGERDATETIME##表示触发的时间变量。"
				 class="easyui-validatebox" required="true" data-option="validType:'maxLength[300]'" cols="46" rows="4"  wrap="VIRTUAL" ></textarea>
		</spring:bind></td>
	</tr> 
	<tr >
		<td height="30" align="right" >批量向前偏移天数：</td>
		<td align="left" >
		    <input type="text" name="batchDateRuleNum"   id="Param_batchDateRuleNum" required="true" title="数据日期为跑批日期的前多少天" class="easyui-numberbox" size="44"  maxlength="20" value="" />
		</td>
	</tr>
	<tr >
		<td height="30" align="center" colspan="2" ><font
			color="red">注：触发规则填写请参照帮助文档</font></td>
	</tr>
   </table>
</form>
</div> 

<div id="ruledialog" style="background:#eef3fa;padding:5px;width:400px;height:350px;">
	 <iframe id="ruleFrame" name="ruleFrame" marginheight="0" marginwidth="0" frameborder="0" width="100%" height="100%" src="<c:url value='/scheduleTaskDef.op'/>"></iframe>
</div>
</body>
</html>

