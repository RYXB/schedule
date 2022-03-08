<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/includes/head.jsp"%>
<html>
<head>
<title>创建批量运行的任务</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script language="JavaScript" type="text/JavaScript">		
var runJobDialog;  
$(function(){
   $("#Text_startbatchdate").datebox("setValue","");
	        $("#Text_endbatchdate").datebox("setValue","");
	        $("#Text_statrPointJobs").val(""); 
	        $("#Text_runmode").combobox("setValue","");
            $("#Text_norundateSelect").val(""); 
            $("#Text_batchdate").val(""); 
            $("#Text_batchDateWay").combobox("setValue","");
            $("#Text_taskNo").combobox("setValue","");
            $("#Text_info").val("");
   $("#Text_batchDateWay").combobox({
      onChange:function(newValue,oldValue){
        if (newValue=="everyday")
        {
		    document.all("somedate").style.display="none";
		    document.all("everydatestart").style.display="";
		    document.all("everydateend").style.display="";
		    document.all("nobatchdate").style.display="";
		     $("#Text_batchdate").val(""); 
        }else{  
    	  if (newValue=="someday"){
    		document.all("somedate").style.display="";
		    document.all("everydatestart").style.display="none";
		    document.all("everydateend").style.display="none";
		    document.all("nobatchdate").style.display="none";
		    $("#Text_endbatchdate").datebox("setValue","");
	        $("#Text_statrPointJobs").val(""); 
	         $("#Text_norundateSelect").val("");
    	  }
        }
     }
   }); 
   $("#Text_taskNo").combobox({
      onChange:function(newValue,oldValue){
         $("#Text_info").val(newValue);
      }
   });
   $("#Text_endbatchdate").datebox({
      formatter:function(date){  
               return date.Format("yyyyMMdd")+"";
      } 
   });
   $("#Text_dateSelect").datebox({
      formatter:function(date){  
         return date.Format("yyyyMMdd")+"";
      },
      onSelect:function(date){ 
       if(date!=null){
         var batchdate=date.Format("yyyyMMdd")+";"+$("#Text_batchdate").val();
         $("#Text_batchdate").val(batchdate);
       }else{
          $("#Text_batchdate").val("");
       }
      }  
   }); 
   $("#Text_norundateSelect").datebox({
      formatter:function(date){  
         return date.Format("yyyyMMdd")+"";
      },
      onSelect:function(date){
        if(date!=null){
         var norunbatchdate=date.Format("yyyyMMdd")+";"+$("#Text_norundate").val();
         $("#Text_norundate").val(norunbatchdate);
         }else{
          $("#Text_norundate").val("");
       }
      }  
   });
   $("#Text_startbatchdate").datebox({
      formatter:function(date){  
         return date.Format("yyyyMMdd")+"";
      } 
   });
   $("#runJobtable").datagrid({ 
	          columns:[[  
	                {field:'JOBID',title:'作业编号',width:200,align:'left'}, 
			        {field:'DESCRIBE',title:'描述',width:120,align:'left'}, 
			        {field:'JOBTYPE',title:'作业类型',width:100,align:'left',formatter:function(value,rec){
			           <c:forEach var="item" items="${jobTypeList}">
			              if(value=="<c:out value='${item.key}'/>")
				            return "<c:out value='${item.value}' />";
			           </c:forEach> 
			        }} 
 				]], 
 		     toolbar : [{   id : "button-add",	
		               text : "当前页全部添加", 
		               iconCls : "icon-add",
		               handler :function(){
		                   var rows =$("#runJobtable").datagrid("getRows");
 		                   for(var i=0;i<rows.length;i++){
		                     var index=$("#getJobtable").datagrid("getRowIndex",rows[i].JOBID);
	                         if(index=="-1"){ 
	                            $("#getJobtable").datagrid("appendRow",{"JOBID":rows[i].JOBID});  
	                            $("#getJobtable").datagrid("loaded"); 
	                            $("#getJobtable").datagrid("acceptChanges");
	                         } 
		                  }
		               }
	               }],
		     pagination:true,
		     rownumbers:true, 
 		     fit:true,
		     nowrap: true,
		     title:"任务作业列表",
		     striped: true,
		     border : false, 
		     singleSelect:true, 
		     onLoadSuccess:function(){   
		     },
	         onDblClickRow:function(rowIndex, rowData){    
	               var index=$("#getJobtable").datagrid("getRowIndex",rowData.JOBID);
	               if(index=="-1"){ 
	                 $("#getJobtable").datagrid("appendRow",{"JOBID":rowData.JOBID});  
	                 $("#getJobtable").datagrid("loaded"); 
	                 $("#getJobtable").datagrid("acceptChanges");
	               }  
	         } 
	   });
	$("#getJobtable").datagrid({ 
	          columns:[[  
	                {field:'JOBID',title:'作业编号',width:250,align:'left'}
 				]],  
 		 	 idField:"JOBID",
		     rownumbers:true, 
 		     fit:true,
 		     title:"已选择作业列表",
		     nowrap: true, 
		     striped: true,
		     border : false, 
		     singleSelect:true,  
		      toolbar : [ {   id : "button-delete",	
		               text : "当前页全部移除", 
		               iconCls : "icon-remove",
		               handler :function(){
		                   $("#getJobtable").datagrid("loadData",[]);
		               }
	               }],
	         onDblClickRow:function(rowIndex, rowData){  
	            $("#getJobtable").datagrid("deleteRow",rowIndex);
	             $("#getJobtable").datagrid("acceptChanges");
	              $("#getJobtable").datagrid("loaded");
	         } 
	   }); 
    runJobDialog=$("#runJobDialog").show().dialog({
		modal : true, 
		maximizable:true,
		minimizable:true,
		resizable : true,
		buttons : [{
			text : "确定",
			iconCls : "icon-ok",
			handler : function() {  
			  var data=$("#getJobtable").datagrid("getData"); 
			  var recordes=data.rows;
			  if(recordes.length>0){
			     if(confirm("您好、确定选择"+(recordes.length)+"个作业吗？")){ 
			      var taskrunjobs=""; 
			      for(var i=recordes.length-1;i>=0;i--){  
		            taskrunjobs=recordes[i].JOBID+";"+taskrunjobs;
		          }
			      $("#Text_statrPointJobs").val(taskrunjobs);
			      runJobDialog.dialog("close");
			    }
			  }else{ 
			     alert("请选择忽略执行的作业！");
			  } 
		    }
	    },{
			text : "关闭",
			iconCls : "icon-cancel",
			handler : function() {
			  runJobDialog.dialog("close");
		    }
	    }]
       }).dialog("close"); 
    removeMaskStub();
});
function doSubmit(){   
	var startdate=$("#Text_startbatchdate").datebox("getValue");
	var enddate=$("#Text_endbatchdate").datebox("getValue");
	var jobs=$("#Text_statrPointJobs").val(); 
	var runmode=$("#Text_runmode").combobox("getValue");
    var norun=$("#Text_norundateSelect").val(); 
    var batchdate=$("#Text_batchdate").val(); 
    var batchDateWay=$("#Text_batchDateWay").combobox("getValue");
    if($("#Text_info").val()==null||$("#Text_info").val()==""){
          alert("请先选择任务！");
          return false;
    }
    if(batchDateWay=="everyday"){
	  if(startdate.length>8||startdate.length<1){
         alert("请批量起始日期中只输入一个日期！"); 
         $("#Text_startbatchdate").datebox("setValue",""); 
	  }else{
		if(enddate.length>8||enddate.length<1){
	        alert("请批量结束日期中只输入一个日期！"); 
	        $("#Text_endbatchdate").datebox("setValue","");
		}else{
			if(enddate<startdate){
				alert("请批量结束日期不要小于批量开始日期！"); 
				$("#Text_startbatchdate").datebox("setValue","");
				$("#Text_endbatchdate").datebox("setValue","");
			}else{
			   if(runmode!="0"&&(jobs==null||jobs=="")){
				  alert("任务不为新任务时，请选择执行作业！");
			   }else{	       
	              if(confirm("您好、确定保存维护的作业任务吗？")){
		             $("#taskform").form("submit",{
							url :"<c:url value='/jobMaintain.op'/>",
							success : function(msg) {
							   var data=eval("("+msg+")");
							   $.messager.show({
					             msg : data.message,
					             title :'提示'
				               });
				               if(data.flag=="true"){
				                  window.parent.addTaskDialogClose();
				                  window.parent.doRefresh();
						       } 
							},
						    error:function(data){
						      $.messager.show({
										msg : "操作失败，请检查原因！",
										title :"提示"
							  });
						    }
					  });	
	              }
	           }	                  
		    }
	     }
	   }
	}else{
		if(batchdate==null||batchdate==""){
                alert("请选择批量时间！"); 
		}else{
		   if(runmode!="0"&&(jobs==null||jobs=="")){
			  alert("任务不为新任务时，请选择执行作业！");
		   }else{	       
               if(confirm("您好、确定保存维护的作业任务吗？")){
	               $("#taskform").form("submit",{
							url :"<c:url value='/jobMaintain.op'/>",
							success : function(msg) {
							   var data=eval("("+msg+")");
							   $.messager.show({
					             msg : data.message,
					             title :'提示'
				               });
				               if(data.flag=="true"){
				                  window.parent.addTaskDialogClose();
				                  window.parent.doRefresh();
						       } 
							},
						    error:function(data){
						      $.messager.show({
										msg : "操作失败，请检查原因！",
										title :"提示"
							  });
						    }
					  });
               }
           } 
	    }
	}
}  
function doAddJob(){   
	if($("#Text_info").val()==null||$("#Text_info").val()==""){
          alert("请先选择任务！");
	}else{
	   $("#runJobtable").datagrid({  
		   url:"<c:url value='/taskJobInfoListController.op'/>",
		   queryParams:{"taskNo":$("#Text_taskNo").combobox("getValue")}, 
		   pageNumber:1,
		   onLoadSuccess:function(){   
 		     runJobDialog.dialog("open");
		   } 
	  }); 
	  var runjobs=  $("#Text_statrPointJobs").val();
		     var getJobsRow=new Array();
		     if(runjobs!=null&&runjobs!=""){
		       var runjob=runjobs.split(";"); 
		       for(var i=0;i<runjob.length;i++){ 
		         if(runjob[i]!=null&&runjob[i]!=""){
		          getJobsRow.push({"JOBID":runjob[i]});
		         }
		       }
		     } 
		     $("#getJobtable").datagrid("loadData",getJobsRow);      
    } 
}
function doqueryJob(){ 
   $("#runJobtable").datagrid("load",{"taskNo":$("#Text_taskNo").combobox("getValue"),"job":$("#Text_jobNo").val(),"jobType":$("#Text_jobType").combobox("getValue")});
}
</script>
</head>
<body  class="easyui-layout ">

<div id='shield' style='width:100%;height:100%;position:absolute;text-align:center;vertical-align:middle;background-color:#DDDDDD;z-index:10001;filter:alpha(opacity=75);'>
<iframe id='shieldIframe' style='width:100%;height:100%;border:none;frameborder:0;filter:alpha(opacity=0);'></iframe>
</div>
<div id='loadcontent' style='position:absolute;top:40%;left:45%;background-color:#E5E5E5;text-align:center;vertical-align:middle;z-index=10002'>
<img id='loadimg' align="center"  src="<c:url value='/images/dialog-loading.gif'/>"></img><br></br><div id='loadtext' >正在加载，请稍候……</div>
</div>


<div  region="center"  style="width:100%;height:100%;background:#eef3fa;" >
<form name="taskform" id="taskform"  method="post" style="background:#eef3fa;">    
<table  align="center" style="width:100%;height:100%;">
	  <tr height="30" >
		<td align="right" width="30%">任务名称：</td>
		<td align="left"  width="70%"><spring:bind path="command.taskNo">
			<select name="<c:out value='${status.expression }'/>"   id="Text_taskNo" class="easyui-combobox" editable="false" panelHeight="200" required="true" style="width: 300" onchange="infoShow();">
				<option value=''>请选择</option>
				<c:forEach var="taskList" items="${taskNameList}">
					<option value='<c:out value="${taskList.TASKID}"/>'><c:out value="${taskList.TASKNAME}" /></option>
				</c:forEach>
			</select> 
		</spring:bind></td>
	  </tr>
	  <tr height="30">
		<td align="right" width="30%">任务编号：</td>
		<td align="left" width="70%">
		<input type="text" name="info" id="Text_info" value=""  class="easyui-validatebox" style="width: 300" disabled="disabled" >
		</td>
	  </tr>
	  <tr height="30">
		<td  align="right" width="30%">任务批量执行方式：</td>
		<td align="left" width="70%">
			<select name="batchDateWay" id="Text_batchDateWay"  class="easyui-combobox"  required="true" panelHeight="auto"   editable="false"style="width: 300">
				<option value="someday">运行指定日期</option>
				<option value="everyday">运行指定日期区间</option>
			</select>
			<font color="red"><c:out value="${status.errorMessage}"></c:out></font>
		</td>
	  </tr>	
	 <tr height="30" id="somedate">
		<td align="right" width="30%">批量时间：</td>
		<td align="left" width="70%"><spring:bind path="command.batchdate">
		    <textarea name="<c:out value='${status.expression }'/>" id="Text_batchdate" cols="40" rows="6" readOnly="readOnly" style="width: 300" class="easyui-validatebox" ></textarea> 
		</spring:bind>
		<input type="text" name="dateSelect" id="Text_dateSelect" class="easyui-datebox"    style="width: 22">
		</td>
		</tr>	
	  <tr height="30"  id="everydatestart" style="display:none;">
		<td align="right" width="30%">批量起始时间：</td>
		<td align="left" width="70%">
		<spring:bind path="command.startbatchdate">
		   <input type="text" name="<c:out value='${status.expression }'/>" id="Text_startbatchdate" class="easyui-datebox" editable="false" style="width: 300">
		</spring:bind></td>
	  </tr>
	  <tr height="30" id="everydateend" style="display:none;">
	 	<td align="right" width="30%">批量结束时间：</td>
		<td align="left" width="70%"><spring:bind path="command.endbatchdate">
		    <input type="text" name="<c:out value='${status.expression }'/>" id="Text_endbatchdate" class="easyui-datebox"  editable="false" style="width: 300">
		</spring:bind></td>
	  </tr>
	  <tr height="30" id="nobatchdate" style="display:none;">
		<td align="right" width="30%">不执行批量时间：</td>
		<td align="left" width="70%"> 
		   <textarea name="norundate" id="Text_norundate" cols="40" rows="6" style="width: 300" readOnly="readOnly"  class="easyui-validatebox" ></textarea> 
		  <input type="text" name="norundateSelect" id="Text_norundateSelect" class="easyui-datebox"  editable="false"  style="width: 22">
		</td>
	 </tr>
	<tr height="30">
		<td  align="right" width="30%">运行方式：</td>
		<td align="left" width="70%"><spring:bind path="command.runmode">
			<select name="<c:out value='${status.expression }'/>"  id="Text_runmode"  class="easyui-combobox"  required="true"  panelHeight="auto"  editable="false" style="width: 300">
				<c:forEach var="runmodeList" items="${runmodeList}">
					<option value='<c:out value="${runmodeList.CODE}"/>'><c:out value="${runmodeList.VALUE}" /></option>
				</c:forEach>
			</select> 
		</spring:bind></td>
	</tr>
	<tr height="30">
		<td align="right" width="30%">执行状态：</td>
		<td align="left" width="70%"><spring:bind path="command.state">
			<select name="<c:out value='${status.expression }'/>" id="Text_state"  class="easyui-combobox"  required="true" panelHeight="auto" disabled="disabled" editable="false"style="width: 300">
				<c:forEach var="statusList" items="${statusList}">
					<option value='<c:out value="${statusList.CODE}"/>' ><c:out	value="${statusList.VALUE}" /></option>
				</c:forEach>
			</select> 
		</spring:bind></td>
	</tr>
	<tr height="30">
		<td align="right" width="30%">执行作业：</td>
		<td align="left" width="70%"><spring:bind path="command.statrPointJobs">
			<textarea name="<c:out value='${status.expression }'/>"  id="Text_statrPointJobs" cols="40" rows="6" style="width: 300"  readOnly="readOnly"  class="easyui-validatebox"></textarea>
			<a onclick="doAddJob()" class="easyui-linkbutton" iconCls="icon-add">添加作业</a>
		</spring:bind></td>
	</tr> 
</table>
</form>
</div> 

<div id="runJobDialog" title="任务运行作业维护"     style="width:800px;height:350px;background:#eef3fa;">
	<div class="easyui-layout" fit="true" > 
	   <div region="north"    style="width: 100%; height: 55px;background:#eef3fa;">
        <form  id="searchForm" name="searchForm"   method="post">  
         <table>   
	     <tr class="body"> 
	     <td  align="right"   width=" 20%">作业编号：</td>
	     <td width="20%"  align="left"  >
	        <input type="text" name="jobNo"   id="Text_jobNo"  style="width: 160"  class="easyui-validatebox" />
	     </td>
	     <td  align="right"   width=" 20%">作业类型：</td>
	     <td width="20%"  align="left" >
              <select name="jobType" style="width: 160" id="Text_jobType" class="easyui-combobox" editable="false"  panelHeight="auto">
			<option value="">全部</option>
			<c:forEach var="item" items="${jobTypeList}">
				<option value='<c:out value="${item.key}"/>'><c:out value="${item.value}" /></option>
			</c:forEach>
		  </select>	 
	     </td>    
	     <td align="right" width="20%"><a onclick="doqueryJob()" class="easyui-linkbutton" iconCls="icon-search">查询</a></td>
	    </tr> 
        </table> 
       </form>
      </div>
	   <div region="center"  style="width:100%;height:100%;background:#eef3fa;" >  
	     <table id="runJobtable" width="100%"> 
	     </table>
        </div> 
      <div region="east"  style="width:300px;height:100%;background:#eef3fa;" >  
	     <table id="getJobtable" width="100%"> 
	     </table>
        </div>   
	</div> 
</div>
</body>
</html>