<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/includes/head.jsp" %>
<html>
<head>
<title>历史任务作业运行列表</title>
<script type="text/javascript"> 
  $(function(){      
         var batchno = document.searchForm.batchno.value;
 	  $("#table").datagrid({ 
	    columns:[[  {field:'JOBID',title:'作业编号',width:150,styler:statuStyle,align:'left'},  
			        {field:'BATCHDATE',title:'批量时间',width:80,styler:statuStyle,align:'left'},
			        {field:'JOBTYPE',title:'作业类型',width:100,align:'left',styler:statuStyle,formatter:function(value,rec){
			           <c:forEach var="item" items="${jobTypeList}">
			              if(value=="<c:out value='${item.key}'/>")
				            return "<c:out value='${item.value}' />";
			           </c:forEach> 
			        }},
			        {field:'STATUS',title:'执行状态',width:100,align:'left',styler:statuStyle,formatter:function(value,rec){
			           <c:forEach var="runstatusList" items="${runstatusList}">
			              if(value=="<c:out value='${runstatusList.CODE}'/>")
				            return "<c:out value='${runstatusList.VALUE}' />";
			           </c:forEach> 
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
			        {field:'SUNJOB',title:'子作业',width:60,align:'left',styler:statuStyle,formatter:function(value,rec){
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
		url:"<c:url value='/hisTaskMonitorDetail.op'/>",
		queryParams:{"batchno":batchno},
 		fit:true,
		nowrap: true,
		striped: true,
		border : false,
		title:"历史子作业监控列表",
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
	       if(field=="SUNJOB"){
	         if(row.SUNJOB!=null&&row.SUNJOB!=""){
	           document.getElementById("sunJobFrame").src="<c:url value='/hisConcurrentController.op'/>?batchno="+row.BATCHNO+"&taskNo="+row.TASKID+"&jobid="+row.JOBID+"&batchdate="+row.BATCHDATE+"&date="+new Date();
	           $("#detailDialog").dialog("open");
	         }
	       }else{
	         if(field=="ERRMSG"){
	          if(row.ERRMSG!=null&&row.ERRMSG!=""){
 	             document.getElementById("message").innerText=row.ERRMSG;
 	             $("#errmessageDialog").dialog("open"); 
 	          } 
	         }else{
	          if(field=="DESCRIBE"){
	            if(row.DESCRIBE!=null&&row.DESCRIBE!=""){
 	             document.getElementById("message").innerText=row.DESCRIBE;
 	             $("#errmessageDialog").dialog("open"); 
 	            }
	       } }
	       }
	    }  
	   });
	  $("#errmessageDialog").show().dialog({
		modal : true, 
		resizable : true,
		maximizable:true,
		minimizable:true,
		buttons : [{
			text : "关闭",
			iconCls : "icon-cancel",
			handler : function() {
			  $("#errmessageDialog").dialog("close");
		    }
	    }]
       }).dialog("close"); 
	  $("#detailDialog").show().dialog({
		modal : true, 
		resizable : true,
		maximizable:true,
		minimizable:true,
		buttons : [{
			text : "关闭",
			iconCls : "icon-cancel",
			handler : function() {
			  $("#detailDialog").dialog("close");
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
           var batchno = document.searchForm.batchno.value; 
          var state = $("#Text_state").combobox("getValue");
          var jobNo = $("#Text_jobNo").val();
          $("#table").datagrid("load",{"batchno":batchno,"jobNo":jobNo,"runstatus":state});
       }
      function doRefresh(){
          var batchno = document.searchForm.batchno.value;
          var state = $("#Text_state").combobox("getValue");
          var jobNo = $("#Text_jobNo").val();
          $("#table").datagrid("reload",{"batchno":batchno,"jobNo":jobNo,"runstatus":state});
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
<input name="batchno" value="<c:out value='${batchno}'/>" type="hidden">
<table>   
	<tr class="body"> 
	     <td  align="right"   width=" 10%">作业编号：</td>
	     <td width="15%"  align="left"  >
	        <input type="text" name="jobNo"   id="Text_jobNo"  style="width: 160"  class="easyui-validatebox" />
	     </td>
	     <td  align="right"   width=" 10%">执行状态：</td>
	     <td width="15%"  align="left" >
              <select name="state" style="width: 160" id="Text_state" class="easyui-combobox" editable="false"  panelHeight="auto">
			<option value="">全部</option>
			<c:forEach var="statusList" items="${runstatusList}">
				<option value='<c:out value="${statusList.CODE}"/>'><c:out value="${statusList.VALUE}" /></option>
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
<div id="detailDialog" title="任务运行明细"     style="width:1000px;height:450px;background:#eef3fa;">
	<iframe name="sunJobFrame" id="sunJobFrame" marginheight="0" marginwidth="0" frameborder="0" width="100%" height="100%" src=""> </iframe> 
</div>



</body>
</html>
