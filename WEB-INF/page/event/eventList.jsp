<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/includes/head.jsp" %>
<html>
<head>
<title>任务执行计划维护列表</title>
<script type="text/javascript">
   var flag=0;
  var detailDialog;
  var errmessageDialog;
   $(function(){     
      $("#Param_eventType").combobox({
        onChange:function(newValue,oldValue){
           $("#Select_eventId").combobox("setValue","");
           $("#Input_eventId").val("");
           if(newValue=="2"){ 
              document.getElementById("inputEventtr").style.display="none"; 
              document.getElementById("selectEventtr").style.display="";
           }else{
              if(newValue=="1"){
                 document.getElementById("selectEventtr").style.display="none"; 
                 document.getElementById("inputEventtr").style.display="";
                 $("#Input_eventId").attr("readonly","readonly");
                 $("#Input_eventId").val($("#Param_taskId").combobox("getValue"));
                 $("#Param_dateOffset").val("");
              }else{
                 document.getElementById("selectEventtr").style.display="none"; 
                 document.getElementById("inputEventtr").style.display="";
                 $("#Input_eventId").removeAttr("readonly");
              }
           }
        },
        onSelect:function(rec){
           if($("#Param_taskId").combobox("getValue")==""){
              alert("请先选择任务名称！");
              $("#Param_eventType").combobox("setValue","");
           }
        } 
      });
      $("#Param_taskId").combobox({
        onChange:function(newValue,oldValue){
           if($("#Param_eventType").combobox("getValue")=="1"){
             $("#Input_eventId").val(newValue);
           }
        }
      });
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
			        {field:'EVENTID',title:'事件标识',width:150,align:'left'},
			        {field:'EVENTTYPE',title:'事件类型',width:120,align:'left',formatter:function(value,rec){
			           <c:forEach var="item" items="${eventTypeList}">
			              if(value=="<c:out value='${item.key}'/>")
				            return "<c:out value='${item.value}' />";
			           </c:forEach> 
			        }},
			        {field:'DATEOFFSET',title:'批量时间偏移量',width:120,align:'left',formatter:function(value,rec){ 
			              if(value==null||value==""||value=="0"){
				            return "同批量日期"; 
				          }else{
				            return "批量日期偏移"+value+"天";
				          }  
			        }}, 
			        {field:'STATE',title:'状态',width:60,align:'left',formatter:function(value,rec){
			           <c:forEach var="item" items="${eventStateList}">
			              if(value=="<c:out value='${item.key}'/>")
				            return "<c:out value='${item.value}' />";
			           </c:forEach> 
			        }} 
 				]],
		pagination:true,
		rownumbers:true,
		url:"<c:url value='/eventController.op'/>",
 		fit:true,
		nowrap: true,
		striped: true,
		border : false,
		title:"事件依赖关系维护列表",
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
			              $("#detailform").form().find(".easyui-validatebox").removeAttr("readonly"); 
                          $("#detailform").form().find(".easyui-validatebox").removeAttr("style"); 
                          $("#detailform").form().find(".easyui-combobox").combobox("enable");
                          $("#detailform").form().find(".easyui-numberbox").numberbox("enable");
                          $("#detailform").form().find(".easyui-datebox").datebox("enable");  
                          $("#Select_eventId").combobox("disable");
                          $("#Input_eventId").attr("readonly","readonly"); 
                          $("#Input_eventId").css("color","666");
                          $("#Param_taskId").combobox("disable");
                          $("#Param_eventType").combobox("disable");
			              detailDialog.dialog("open"); 
			              $("#detailform").form("load", { 
			                taskId:row.TASKID,
                             eventId:row.EVENTID,
                             eventType:row.EVENTTYPE,
                             dateOffset:row.DATEOFFSET,
                             state:row.STATE
			              });  
			               if(row.EVENTTYPE=="2"){ 
                              document.getElementById("inputEventtr").style.display="none"; 
                              document.getElementById("selectEventtr").style.display="";
                           }else{
                            if(row.EVENTTYPE=="1"){
                                 document.getElementById("selectEventtr").style.display="none"; 
                                 document.getElementById("inputEventtr").style.display="";
                                 $("#Input_eventId").attr("readonly","readonly");
                                 $("#Input_eventId").val(row.TASKID);
                                 $("#Param_dateOffset").val("");
                            }else{
                                document.getElementById("selectEventtr").style.display="none"; 
                                document.getElementById("inputEventtr").style.display="";
                                $("#Input_eventId").removeAttr("readonly");
                            }
                           }
			              if(row.EVENTTYPE=="2"){
			                 $("#Select_eventId").combobox("setValue",row.EVENTID);
			              }else{
			                 $("#Input_eventId").val(row.EVENTID);
			              }
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
                             eventId:row.EVENTID,
                             eventType:row.EVENTTYPE,
                             dateOffset:row.DATEOFFSET,
                             state:row.STATE
			              }); 
			              if(row.EVENTTYPE=="2"){ 
                              document.getElementById("inputEventtr").style.display="none"; 
                              document.getElementById("selectEventtr").style.display="";
                           }else{
                            if(row.EVENTTYPE=="1"){
                                 document.getElementById("selectEventtr").style.display="none"; 
                                 document.getElementById("inputEventtr").style.display="";
                                 $("#Input_eventId").attr("readonly","readonly");
                                 $("#Input_eventId").val(row.TASKID);
                                 $("#Param_dateOffset").val("");
                            }else{
                                document.getElementById("selectEventtr").style.display="none"; 
                                document.getElementById("inputEventtr").style.display="";
                                $("#Input_eventId").removeAttr("readonly");
                            }
                           }
			              if(row.EVENTTYPE=="2"){
			                 $("#Select_eventId").combobox("setValue",row.EVENTID);
			              }else{
			                 $("#Input_eventId").val(row.EVENTID);
			              }
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
                             eventId:row.EVENTID,
                             eventType:row.EVENTTYPE,
                             dateOffset:row.DATEOFFSET,
                             state:row.STATE
			              });  
			              if(row.EVENTTYPE=="2"){ 
                              document.getElementById("inputEventtr").style.display="none"; 
                              document.getElementById("selectEventtr").style.display="";
                           }else{
                            if(row.EVENTTYPE=="1"){
                                 document.getElementById("selectEventtr").style.display="none"; 
                                 document.getElementById("inputEventtr").style.display="";
                                 $("#Input_eventId").attr("readonly","readonly");
                                 $("#Input_eventId").val(row.TASKID);
                                 $("#Param_dateOffset").val("");
                            }else{
                                document.getElementById("selectEventtr").style.display="none"; 
                                document.getElementById("inputEventtr").style.display="";
                                $("#Input_eventId").removeAttr("readonly");
                            }
                           } 
			              if(row.EVENTTYPE=="2"){
			                 $("#Select_eventId").combobox("setValue",row.EVENTID);
			              }else{
			                 $("#Input_eventId").val(row.EVENTID);
			              }
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
			  if($("#Param_eventType").combobox("getValue")=="1"&&$("#Param_dateOffset").val()!=""){
			      alert("计划事件时请清空批量时间偏移量里的数据！！！");
			      return false;
			  }
			   if($("#Param_eventType").combobox("getValue")=="2"&&$("#Select_eventId").combobox("getValue")==""){
			      alert("请选择事件标识！");
			      return false;
			   } 
			  if($("#Param_state").combobox("getValue")==""){
			     return false;
			  } 
			  if(document.detailform.flag.value!="view"){ 
			     if(!confirm("您好，是否确认维护数据？")){
			        return false;
			  }
			  if($("#Param_eventType").combobox("getValue")=="2"){
			     document.getElementById("Param_eventId").value=$("#Select_eventId").combobox("getValue");
			  }else{
			     document.getElementById("Param_eventId").value=$("#Input_eventId").val();
			  } 
			  $("#detailform").form("submit",{
                  url:"<c:url value='/editEventController.op'/>", 
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
	    } ]
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
      function beforeInput(){
	   if($("#Param_eventType").combobox("getValue")=="")
		 alert("请先输入事件类型！！！");
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
	     <td width="15%"  align="left"  >
	        <input type="text" name="taskNo"   id="Text_taskNo"  style="width: 160"  class="easyui-validatebox" />
	     </td>
	     <td  align="right"   width=" 10%">任务名称：</td>
	     <td width="15%"  align="left"  >
	        <input type="text" name="taskName"   id="Text_taskName"  style="width: 160"  class="easyui-validatebox" />
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
<div id="errmessageDialog" title="提示信息"     style="width:500px;height:300px;background:#eef3fa;"> 
 <p   ><span id="message"  style="white-space:pre;"></span></p>	    
</div>
<div id="detailDialog" title="任务明细"     style="width:700px;height:450px;background:#eef3fa;">
	<form name="detailform"  id="detailform" action=""   method="post"> 
	<input name="flag" value="" type="hidden">
    <table  width="100%">  
	<tr >
		<td height="30" align="right" >任务名称：</td>
		<td align="left" ><spring:bind path="command.taskId">
			<select name="<c:out value='${status.expression }'/>" id="Param_taskId" editable="false" panelHeight="200" class="easyui-combobox"  required="true"  style="width: 300">
				<c:forEach var="itemList" items="${taskIdList}">
					<option value="<c:out value='${itemList.TASKID}'/>"><c:out value="${itemList.TASKNAME}" /></option>
				</c:forEach>
			</select>
		</spring:bind></td>
	</tr>
	<tr >
		<td height="30" align="right" >事件类型：</td>
		<td align="left" ><spring:bind path="command.eventType">
			<select name="<c:out value='${status.expression }'/>"
				onclick="beforeSelect();" onchange="onselect();" id="Param_eventType" editable="false" panelHeight="auto" class="easyui-combobox"  required="true"  style="width: 300">
				<c:forEach var="item" items="${eventTypeList}">
					<option value="<c:out value='${item.key}'/>" ><c:out value="${item.value}" /></option>
				</c:forEach>
			</select>
		</spring:bind></td>
	</tr>
	 
	<tr  id="selectEventtr">
		<td height="30" align="right" >事件标识：</td> 
		<td align="left" ><spring:bind path="command.eventId">
		<input id="Param_eventId" type="hidden"  name="<c:out value='${status.expression }' />"     value="<c:out value='${status.value }'/>" />
		</spring:bind>
 		<select   id="Select_eventId" editable="false" panelHeight="200"  class="easyui-combobox"  style="width: 300">
				<c:forEach var="itemList" items="${taskIdList}">
					<option value="<c:out value='${itemList.TASKID}'/>"><c:out value="${itemList.TASKNAME}" /></option>
				</c:forEach>
		</select>
		</td>
	</tr>
	<tr id="inputEventtr" >
		<td height="30" align="right" >事件标识：</td> 
		<td align="left" > 
		<input id="Input_eventId" type="text"  size="44"  class="easyui-validatebox" maxlength="50"   /> 
		</td>
	</tr>

	<tr >
		<td height="30" align="right" >批量时间偏移量：</td>
		<td align="left" ><spring:bind path="command.dateOffset"> 
			<input id="Param_dateOffset" type="text" onclick="beforeInput();" name="<c:out value='${status.expression }' />" size="44"   class="easyui-numberbox"  maxlength="20" value="<c:out value='${status.value }'/>" />
 		</spring:bind></td>
	</tr>
	<tr >
		<td height="30" align="right" >状态：</td>
		<td align="left" ><spring:bind path="command.state">
			<select name="<c:out value='${status.expression }'/>" id="Param_state" editable="false" panelHeight="auto" class="easyui-combobox"  required="true" style="width: 300">
				<c:forEach var="item" items="${eventStateList}">
					<option value="<c:out value='${item.key}'/>"><c:out value="${item.value}" /></option>
				</c:forEach>
			</select>
		</spring:bind></td>
	</tr>
   </table>
</form>
</div>  
</body>
</html>


