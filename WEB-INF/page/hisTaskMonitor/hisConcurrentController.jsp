<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/includes/head.jsp" %>
<html>
<head>
<title>子作业运行情况</title>
<script type="text/javascript"> 
  $(function(){      
       var batchdate = document.searchForm.batchdate.value;
      var jobid = document.searchForm.jobid.value;
      var taskNo =document.searchForm.taskNo.value;
      var  batchno=document.searchForm.batchno.value;
	  $("#table").datagrid({ 
	    columns:[[  {field:'JOBID',title:'子作业编号',width:150,styler:statuStyle,align:'left'}, 
			        {field:'BATCHDATE',title:'批量时间',width:80,styler:statuStyle,align:'left'},
			        {field:'RUNMODE',title:'作业类型',width:100,align:'left',styler:statuStyle,formatter:function(value,rec){
			           <c:forEach var="item" items="${jobTypeList}">
			              if(value=="<c:out value='${item.key}'/>")
				            return "<c:out value='${item.value}' />";
			           </c:forEach> 
			        }}, 
			        {field:'STATUS',title:'执行状态',width:80,align:'left',styler:statuStyle,formatter:function(value,rec){
			           <c:forEach var="statusList" items="${statusList}">
			              if(value=="<c:out value='${statusList.CODE}'/>")
				            return "<c:out value='${statusList.VALUE}' />";
			           </c:forEach> 
			        }}, 
			        {field:'ERRMSG',title:'提示信息',width:60,align:'left',styler:statuStyle,formatter:function(value,rec){
			           if(value==null||value==""){
			              return "无";
			           }else{
			             if(rec.STATUS=="2"){
                             return "<a href='#' style='color:green;'>查看</a>";;
                          }else{
                            if(rec.STATUS=="3"){
                                return "<a href='#' style='color:red;'>查看</a>"; 
                            }else{
                               if(rec.STATUS=="5"){
                                return "<a href='#' style='color:#000080;'>查看</a>"; 
                            }else{
                                return "<a href='#' style='color:#660000;'>查看</a>";
                                }
                            } 
                          }
			           } 
			        }}, 
			        {field:'DESCRIBE',title:'描述',width:120,align:'left',styler:statuStyle,formatter:function(value,rec){
			           if(value==null||value==""){
			              return "无";
			           }else{
			              if(rec.STATUS=="2"){
                             return "<a href='#' style='color:green;'>"+value+"</a>";;
                          }else{
                            if(rec.STATUS=="3"){
                                return "<a href='#' style='color:red;'>"+value+"</a>"; 
                            }else{
                               if(rec.STATUS=="5"){
                                return "<a href='#' style='color:#000080;'>"+value+"</a>"; 
                            }else{
                                return "<a href='#' style='color:#660000;'>"+value+"</a>";
                                }
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
		url:"<c:url value='/hisConcurrentController.op'/>",
		queryParams:{"jobid":jobid,"batchdate":batchdate,"taskNo":taskNo,"batchno":batchno},
 		fit:true,
		nowrap: true,
		striped: true,
		border : false,
		title:"子作业监控列表 -<c:out value='${jobid}'/>",
		singleSelect:true,
		checkbox:true,
		pageList:[20,30,50,100],
		pageSize:20,
		onLoadSuccess:function(){
		   removeMaskStub(); 
		},
	    onClickCell:function(rowIndex,field,value){
	       $("#table").datagrid("selectRow",rowIndex);
	       var row=$("#table").datagrid("getSelected"); 
	       if(field=="ERRMSG"){
	         if(row.ERRMSG!=null&&row.ERRMSG!=""){
 	             document.getElementById("message").innerText=row.ERRMSG;
 	             $("#errmessageDialog").dialog("open"); 
 	          }
	       } 
	       if(field=="DESCRIBE"){
	           if(row.DESCRIBE!=null&&row.DESCRIBE!=""){
 	             document.getElementById("message").innerText=row.DESCRIBE;
 	             $("#errmessageDialog").dialog("open"); 
 	           }
	       } 
	    }  
	   });
	   $("#errmessageDialog").show().dialog({
		modal : true, 
		maximizable:true,
		minimizable:true,
		resizable : true,
		buttons : [{
			text : "关闭",
			iconCls : "icon-cancel",
			handler : function() {
			  $("#errmessageDialog").dialog("close");
		    }
	    }]
       }).dialog("close"); 
	   
      
      }); 
      
      function statuStyle(value,rec){
         if(rec.STATUS=="2"){
           return "color:green";
         }else{
           if(rec.STATUS=="3"){
              return "color:red";
           }else{
             if(rec.STATUS=="5"){
              return "color:#000080";
             }
           } 
         }
      }  
       function doquery(){ 
          var batchdate = document.searchForm.batchdate.value;
          var jobNo = document.searchForm.jobNo.value;
          var taskId =document.searchForm.taskId.value;
          var runstatus = $("#Text_runstatus").combobox("getValue");
          var sunJobNo = $("#Text_sunJobNo").val();
          $("#table").datagrid("load",{ "sunJobNo":sunJobNo,"jobid":jobid,"batchdate":batchdate,"taskNo":taskNo,"batchno":batchno,"runstatus":runstatus});
       }
      function doRefresh(){
          var batchdate = document.searchForm.batchdate.value;
          var jobNo = document.searchForm.jobNo.value;
          var taskId =document.searchForm.taskId.value;
          var runstatus = $("#Text_runstatus").combobox("getValue");
          var sunJobNo = $("#Text_sunJobNo").val();
          $("#table").datagrid("reload",{"jobid":jobid,"batchdate":batchdate,"taskNo":taskNo,"batchno":batchno,"sunJobNo":sunJobNo,"runstatus":runstatus});
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
<input name="batchno" value="<c:out value='${batchno}'/>" type="hidden">
<input name="jobid" value="<c:out value='${jobid}'/>" type="hidden">
<input name="batchdate" value="<c:out value='${batchdate}'/>" type="hidden">
<input name="taskNo" value="<c:out value='${taskNo}'/>" type="hidden">

<table>  
	<tr class="body">
	     <td  align="right"   width=" 10%">子作业编号：</td>
	     <td width="15%"  align="left"  >
	        <input type="text" name="sunJobNo"   id="Text_sunJobNo"  style="width: 160"  class="easyui-validatebox" />
	     </td> 
	     <td  align="right"   width=" 10%">执行状态：</td>
	     <td width="15%"  align="left" >
              <select name="runstatus" style="width: 160" id="Text_runstatus" class="easyui-combobox" editable="false"  panelHeight="auto">
			<option value="">全部</option>
			<c:forEach var="runstatusList" items="${runstatusList}">
				<option value='<c:out value="${runstatusList.CODE}"/>'><c:out value="${runstatusList.VALUE}" /></option>
			</c:forEach>
		  </select>	 
	     </td> 
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
<div id="errmessageDialog" title="提示信息"     style="width:600px;height:400px;background:#eef3fa;"> 
 <p   ><span id="message"  style="white-space:pre;"></span></p>	    
</div>  

</body>
</html>  
