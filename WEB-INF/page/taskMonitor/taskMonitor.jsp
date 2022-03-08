<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/includes/head.jsp" %>
<html>
<head>
<title>任务监控</title>
<script type="text/javascript">
  var refreshTim = "<c:out value='${refreshTim}' />";
  var flag=0;
  var detailDialog;
  var errmessageDialog;
  $(function(){  
       $("#Text_batchdate").datebox({
          formatter:function(date){  
               return date.Format("yyyyMMdd")+"";
          }
       });       
	  $("#table").datagrid({ 
	    columns:[[  {field:'TASKID',title:'任务编号',width:150,styler:statuStyle,align:'left'},
			        {field:'TASKNAME',title:'任务名称',width:200,styler:statuStyle,align:'left',formatter:function(value,rec){ 
			              if(rec.STATUS=="1"){
                             return "<a href='#' style='color:green;'>"+value+"</a>";;
                          }else{
                            if(rec.STATUS=="3"){
                                return "<a href='#' style='color:red;'>"+value+"</a>"; 
                            }else{
                                return "<a href='#' style='color:#660000;'>"+value+"</a>";
                            } 
                          }
			        }},
			        {field:'DESCRIBE',title:'描述',width:120,align:'left',styler:statuStyle,formatter:function(value,rec){
			           if(value==null||value==""){
			              return "无";
			           }else{
			              if(rec.STATUS=="1"){
                             return "<a href='#' style='color:green;'>"+value+"</a>";;
                          }else{
                            if(rec.STATUS=="3"){
                                return "<a href='#' style='color:red;'>"+value+"</a>"; 
                            }else{
                                return "<a href='#' style='color:#660000;'>"+value+"</a>";
                            } 
                          } 
			           } 
			        }},
			        {field:'BATCHDATE',title:'批量时间',width:80,styler:statuStyle,align:'left'},
			        {field:'RUNMODE',title:'运行方式',width:100,align:'left',styler:statuStyle,formatter:function(value,rec){
			           <c:forEach var="runmodeList" items="${runmodeList}">
			              if(value=="<c:out value='${runmodeList.CODE}'/>")
				            return "<c:out value='${runmodeList.VALUE}' />";
			           </c:forEach> 
			        }},
			        {field:'STATUS',title:'执行状态',width:80,align:'left',styler:statuStyle,formatter:function(value,rec){
			           <c:forEach var="statusList" items="${statusList}">
			              if(value=="<c:out value='${statusList.CODE}'/>")
				            return "<c:out value='${statusList.VALUE}' />";
			           </c:forEach> 
			        }},
			        {field:'STARTPOINTJOBS',title:'执行作业',width:80,styler:statuStyle,align:'left',formatter:function(value,rec){
			           if(value==null||value==""){
			              return "无";
			           }else{
			              if(rec.STATUS=="1"){
                             return "<a href='#' style='color:green;'>查看</a>";;
                          }else{
                            if(rec.STATUS=="3"){
                                return "<a href='#' style='color:red;'>查看</a>"; 
                            }else{
                                return "<a href='#' style='color:#660000;'>查看</a>";
                            } 
                          }
			           } 
			        }},
			        {field:'COMPLETION_RATE',title:'完成率',width:60,align:'left',styler:statuStyle,formatter:function(value,rec){
			           return rec.SUNTASK+"/"+rec.SUMTASK;
			        }},
			        {field:'ERRMSG',title:'提示信息',width:60,align:'left',styler:statuStyle,formatter:function(value,rec){
			           if(value==null||value==""){
			              return "无";
			           }else{
			              if(rec.STATUS=="1"){
                             return "<a href='#' style='color:green;'>查看</a>";;
                          }else{
                            if(rec.STATUS=="3"){
                                return "<a href='#' style='color:red;'>查看</a>"; 
                            }else{
                                return "<a href='#' style='color:#660000;'>查看</a>";
                            } 
                          }
			           } 
			        }}, 
			        {field:'STARTTIME',title:'开始时间',width:160,styler:statuStyle,align:'left'},
			        {field:'ENDTIME',title:'结束时间',width:160,styler:statuStyle,align:'left'},
			        {field:'OPERATETIME',title:'运行时间',width:200,styler:statuStyle,align:'left',formatter:function(value,rec){
			           if(rec.RUNMINUE==null||rec.RUNMINUE==""){
			              rec.RUNMINUE="0";
			           }
			           if(rec.RUNSECOND==null||rec.RUNSECOND==""){
			              rec.RUNSECOND="0";
			           }
			           return rec.RUNMINUE+"分"+rec.RUNSECOND+"秒";
			        }}
 				]],
		pagination:true,
		rownumbers:true,
		url:"<c:url value='/taskMonitor.op'/>",
 		fit:true,
		nowrap: true,
		striped: true,
		border : false,
		title:"批量运行控制",
		singleSelect:true,
		checkbox:true,
		pageList:[50,80,100,150],
		pageSize:80,
		onLoadSuccess:function(){
		   removeMaskStub();
		   refreshTim = document.searchForm.refreshTim.value;
           restart(); 
		},
	    onClickCell:function(rowIndex,field,value){
	       $("#table").datagrid("selectRow",rowIndex);
	       var row=$("#table").datagrid("getSelected");
	       if(field=="TASKNAME"){
	         detailDialog.dialog("open");
	         document.getElementById("detailTaskFrame").src="<c:url value='/taskMonitorDetail.op'/>?taskNo="+row.TASKID+"&batchdate="+row.BATCHDATE+"&date="+new Date();  
	       }else{
	         if(field=="ERRMSG"){
	           if(row.ERRMSG!=null&&row.ERRMSG!=""){
 	             document.getElementById("message").innerText=row.ERRMSG;
 	             errmessageDialog.dialog("open"); 
 	           }
	         }else{
	            if(field=="DESCRIBE"){
	               if(row.DESCRIBE!=null&&row.DESCRIBE!=""){
 	                  document.getElementById("message").innerText=row.DESCRIBE;
 	                  errmessageDialog.dialog("open"); 
 	               }
	            }else{
	               if(field=="STARTPOINTJOBS"){
	               if(row.STARTPOINTJOBS!=null&&row.STARTPOINTJOBS!=""){
	                 var jobs=row.STARTPOINTJOBS; 
	                 jobs=jobs.replaceAll(";",";\n");
 	                 document.getElementById("message").innerText=jobs;
 	                 errmessageDialog.dialog("open"); 
 	               }
	             }
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
	   detailDialog=$("#detailDialog").show().dialog({
		modal : true, 
		maximizable:true,
		minimizable:true,
		resizable : true,
		buttons : [{
			text : "关闭",
			iconCls : "icon-cancel",
			handler : function() {
			  detailDialog.dialog("close");
		    }
	    }]
       }).dialog("close");
      
      }); 
      
      function statuStyle(value,rec){
         if(rec.STATUS=="1"){
           return "color:green";
         }else{
           if(rec.STATUS=="3"){
              return "color:red";
           } 
         }
      }
        function doTimeout(){
          var panel=$("#table").datagrid("getPanel");
          $(panel).panel({ 
             title:"批量运行控制(页面将在"+refreshTim+" 秒钟后自动刷新)"
          }); 
          if(refreshTim==0){ 
             doRefresh(); 
             flag=0;
             return false;
           }else{ 
              refreshTim--;
 		      setTimeout("doTimeout()",1000);
 		      flag=1;
           }
        }

        function restart(){
          if(flag==0)
        	  doTimeout();
        }    
       function doquery(){ 
          var batchdate = $("#Text_batchdate").datebox("getValue"); 
          var runmode = $("#Text_runmode").combobox("getValue");
          var taskName = $("#Text_taskName").val();
          var state = $("#Text_state").combobox("getValue");
          var taskNo = $("#Text_taskNo").val();
          $("#table").datagrid("load",{"taskNo":taskNo,"batchdate":batchdate,"runmode":runmode,"taskName":taskName,"state":state});
       }
      function doRefresh(){
          var batchdate = $("#Text_batchdate").datebox("getValue");
          var runmode = $("#Text_runmode").combobox("getValue");
          var taskName = $("#Text_taskName").val();
          var state = $("#Text_state").combobox("getValue");
          var taskNo = $("#Text_taskNo").val();
          $("#table").datagrid("reload",{"taskNo":taskNo,"batchdate":batchdate,"runmode":runmode,"taskName":taskName,"state":state});
          refreshTim = document.searchForm.refreshTim.value;
          restart();
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

<div region="north"    style="width: 100%; height: 80px;background:#eef3fa;">
<form  id="searchForm" name="searchForm"   method="post"> 
<input type="hidden" name="refreshTim" value="<c:out value='${refreshTim}' />" />  
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
	     <td  align="right"   width=" 10%">批量日期：</td>
	     <td width="15%"  align="left"  >
	         <input  name="batchdate" style="width: 160" class="easyui-datebox" id="Text_batchdate" panelWidth="160"  editable="false" />
	     </td>
	     <td  align="right"   width=" 10%">运行方式：</td>
	     <td width="15%"  align="left"  >
              <select name="runmode" style="width: 160" id="Text_runmode" class="easyui-combobox" editable="false"  panelHeight="auto">
			<option value="">全部</option>
			<c:forEach var="runmodeList" items="${runmodeList}">
				<option value='<c:out value="${runmodeList.CODE}"/>'><c:out value="${runmodeList.VALUE}" /></option>
			</c:forEach>
		  </select>	 
	     </td> 
		 
	</tr>
	<tr class="body"> 
	     <td  align="right"   width=" 10%">执行状态：</td>
	     <td width="15%"  align="left" >
              <select name="state" style="width: 160" id="Text_state" class="easyui-combobox" editable="false"  panelHeight="auto">
			<option value="">全部</option>
			<c:forEach var="statusList" items="${statusList}">
				<option value='<c:out value="${statusList.CODE}"/>'><c:out value="${statusList.VALUE}" /></option>
			</c:forEach>
		  </select>	 
	     </td> 
	      <td  align="right"   width=" 10%"></td>
	     <td width="15%"  align="left" ></td>
	     <td  align="right"   width=" 10%"></td>
	     <td width="15%"  align="left" ></td>
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
<div id="errmessageDialog" title="提示信息"     style="width:600px;height:300px;background:#eef3fa;"> 
 <p   ><span id="message"  style="white-space:pre;"></span></p>	    
</div>
<div id="detailDialog" title="任务运行明细"     style="width:1000px;height:350px;background:#eef3fa;">
	<iframe name="detailTaskFrame" id="detailTaskFrame" marginheight="0" marginwidth="0" frameborder="0" width="100%" height="100%" src=""> </iframe> 
</div>



</body>
</html>
