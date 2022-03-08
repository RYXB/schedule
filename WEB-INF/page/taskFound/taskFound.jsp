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
  var row;
  var  operateType;
  var  ignoreJobDialog;
  
  var  detailSunDialog;
  var inforeDialog;
  var addTaskDialog;
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
			        {field:'MOREMESSAGE',title:'其他信息',width:60,align:'left',styler:statuStyle,formatter:function(value,rec){ 
			              return "<a href='#' style='color:#660000;'>更多...</a>"; 
			        }},   
			        {field:'OPERATE',title:'操作',width:200,align:'left',styler:statuStyle,formatter:function(value,rec){ 
			            if(rec.STATUS=="0"){
			              return "<a href='#'   onClick=' doOperate(1)'><font color='blue'>删除</font></a>"; 
			            }else{
			              if(rec.STATUS=="1"){
			                if(rec.INTERRUPTED=="1"){
			                  return "<a>正在中断</a><img id='loadimg' src='<c:url value ='images/loading.gif' />' style='width:60;' onclick=''></img>";
			                }else{ 
			                   return "<a href='#'  onClick='doOperate(2)'><font color='blue'>中断</font></a>"; 
			                }
			              }else{
			                if(rec.STATUS=="2"){
			                   return "<a href='#' onClick=' doOperate(3)'><font  color='blue'>重运行</font></a>&nbsp;&nbsp;&nbsp;<a href='#'  onClick='doOperate(1)'><font color='blue'>删除</font></a>";
			                }else{
			                   if(rec.STATUS=="3"){
			                     return "<a href='#' onClick=' doOperate(3)'><font color='blue'>重运行</font></a>&nbsp;&nbsp;<a href='#' onClick='doOperate(4)'><font  color='blue'>重提</font></a>&nbsp;&nbsp;<a href='#' onClick=' doOperate(1)'><font color='blue'>删除</font></a>&nbsp;&nbsp;<a href='#'  onClick=' doOperate(5)'><font color='blue'>作业忽略</font></a>";
			                   }else{
			                      if(rec.STATUS=="9"){
			                         return "<a href='#' onClick='doOperate(3)'><font color='blue'>重运行</font></a>&nbsp;&nbsp;<a href='#' onClick='doOperate(4)'><font  color='blue'>重提</font></a>&nbsp;&nbsp;<a href='#' onClick=' doOperate(1)'><font color='blue'>删除</font></a>&nbsp;&nbsp;<a href='#' onClick=' doOperate(5)'><font color='blue'>作业忽略</font></a>";
			                      } 
			                   }
			                }
			              }
			            }
			        }} 
 				]],
		pagination:true,
		rownumbers:true,
		url:"<c:url value='/taskFound.op'/>",
 		fit:true,
		nowrap: true,
		striped: true,
		border : false,
		title:"批量运行任务控制",
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
	       row=$("#table").datagrid("getSelected");
	       if(field=="TASKNAME"){
	         document.getElementById("detailTaskFrame").src="<c:url value='/taskMonitorDetail.op'/>?taskNo="+row.TASKID+"&batchdate="+row.BATCHDATE+"&date="+new Date();
	         detailDialog.dialog("open");
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
	             }else{
	                if(field=="OPERATE"){ 
	                   if(operateType==1){
                         doDelete();
                       } 
                       if(operateType==2){
                          doBlocking();
                       } 
                       if(operateType==3){
                         doAfresh();
                       } 
                       if(operateType==4){
                         doBack();
                       } 
                       if(operateType==5){
                           doIgnoreJob();
                       }
	                }else{
	                  if(field=="MOREMESSAGE"){
	                    var  runmode="";
	                    <c:forEach var="runmodeList" items="${runmodeList}">
			              if(row.RUNMODE=="<c:out value='${runmodeList.CODE}'/>")
				           runmode="<c:out value='${runmodeList.VALUE}' />";
			           </c:forEach> 
			           var  status="";
			           <c:forEach var="statusList" items="${statusList}">
			              if(row.STATUS=="<c:out value='${statusList.CODE}'/>")
				          status="<c:out value='${statusList.VALUE}' />";
			           </c:forEach> 
	                     document.getElementById("taskmessage").innerText=row.TASKID;
	                     document.getElementById("taskNamemessage").innerText=row.TASKNAME;
	                     document.getElementById("describemessage").innerText=row.DESCRIBE==null?"无":row.DESCRIBE;
	                     document.getElementById("batchdatemessage").innerText=row.BATCHDATE;
	                     document.getElementById("runmodemessage").innerText=runmode;
	                     document.getElementById("statusmessage").innerText=status;
	                     document.getElementById("jobmessage").innerText=row.STARTPOINTJOBS==null?"无":row.STARTPOINTJOBS;
	                     document.getElementById("complemessage").innerText=row.SUNTASK+"/"+row.SUMTASK;
	                     document.getElementById("errormessage").innerText=row.ERRMSG==null?"无":row.ERRMSG;
	                     document.getElementById("starttimemessage").innerText=row.STARTTIME;
	                     document.getElementById("endtimemessage").innerText=row.ENDTIME;
 	                     inforeDialog.dialog("open"); 
	                  }
	                }
	             }
	            }
	         }
	       }
	    }  
	   });
	   $("#jobtable").datagrid({ 
	          columns:[[ 
	                {field:'JOBID',title:'作业编号',width:150,styler:statuStyle,align:'left'}, 
			        {field:'DESCRIBE',title:'描述',width:120,align:'left',styler:statuStyle,formatter:function(value,rec){
			           if(value==null||value==""){
			              return "无";
			           }else{
			              return "<a href='#' style='color:#660000;'>"+value+"</a>";
			           } 
			        }},
			        {field:'BATCHDATE',title:'批量时间',width:80,styler:statuStyle,align:'left'},
			        {field:'JOBTYPE',title:'作业类型',width:100,align:'left',styler:statuStyle,formatter:function(value,rec){
			           <c:forEach var="item" items="${jobTypeList}">
			              if(value=="<c:out value='${item.key}'/>")
				            return "<c:out value='${item.value}' />";
			           </c:forEach> 
			        }},
			        {field:'STATUS',title:'执行状态',width:80,align:'left',styler:statuStyle,formatter:function(value,rec){
			           <c:forEach var="item" items="${runstatusList}">
			              if(value=="<c:out value='${item.CODE}'/>")
				            return "<c:out value='${item.VALUE}' />";
			           </c:forEach> 
			        }},
			        {field:'STARTPOINTJOBS',title:'子作业',width:80,styler:statuStyle,align:'left',formatter:function(value,rec){
			           if(value==null||value==""){
			              return "无";
			           }else{
			              return "<a href='#' style='color:#660000;'>查看</a>";
			           } 
			        }}, 
			        {field:'ERRMSG',title:'提示信息',width:60,align:'left',styler:statuStyle,formatter:function(value,rec){ 
			           if(value==null||value==""){
			              return "无";
			           }else{
			              return "<a href='#' style='color:#660000;'>查看</a>";
			           } 
			        }}  
 				]],
 			toolbar : [{   id : "button-add",	
		               text : "当前页全部添加", 
		               iconCls : "icon-add",
		               handler :function(){
		                   var rows =$("#jobtable").datagrid("getRows");
 		                   for(var i=0;i<rows.length;i++){
		                     var index=$("#ignoreJobtable").datagrid("getRowIndex",rows[i]);
	                         if(index=="-1"){ 
	                            $("#ignoreJobtable").datagrid("appendRow",rows[i]);  
	                            $("#ignoreJobtable").datagrid("loaded"); 
	                            $("#ignoreJobtable").datagrid("acceptChanges");
	                         } 
		                  }
		               }
	               }],
	         title:"任务作业列表",
		     pagination:false,
		     rownumbers:true, 
 		     fit:true,
		     nowrap: true,
		     striped: true,
		     border : false, 
		     singleSelect:true,  
		     onLoadSuccess:function(){  
		     },
		     onDblClickRow:function(rowIndex, rowData){    
	               var index=$("#ignoreJobtable").datagrid("getRowIndex",rowData);
	               if(index=="-1"){ 
	                 $("#ignoreJobtable").datagrid("appendRow",rowData);  
	                 $("#ignoreJobtable").datagrid("loaded"); 
	                 $("#ignoreJobtable").datagrid("acceptChanges");
	               }  
	         },
	        onClickCell:function(rowIndex,field,value){
	         $("#jobtable").datagrid("selectRow",rowIndex);
	         var rec=$("#jobtable").datagrid("getSelected");
	         if(field=="SUNJOB"){
	           if(rec.SUNJOB!=null&&rec.SUNJOB!=""){
	             document.getElementById("sunJobFrame").src="<c:url value='/concurrentController.op'/>?taskNo="+rec.TASKID+"&jobid="+rec.JOBID+"&batchdate="+rec.BATCHDATE+"&date="+new Date();
	             detailSunDialog.dialog("open");
	           }
	           }else{
	              if(field=="ERRMSG"){
	                if(rec.ERRMSG!=null&&rec.ERRMSG!=""){
 	                  document.getElementById("message").innerText=rec.ERRMSG;
 	                  errmessageDialog.dialog("open"); 
 	                }
	             }else{
	                if(field=="DESCRIBE"){
	                 if(rec.DESCRIBE!=null&&rec.DESCRIBE!=""){
 	                   document.getElementById("message").innerText=rec.DESCRIBE;
 	                   errmessageDialog.dialog("open"); 
 	                 }
	                } 
	            }
	       }
	    }   
	   });
	   $("#ignoreJobtable").datagrid({ 
	          columns:[[  
	                {field:'JOBID',title:'作业编号',width:150,styler:statuStyle,align:'left'}, 
	                {field:'BATCHDATE',title:'批量时间',width:80,styler:statuStyle,align:'left'},
			        {field:'DESCRIBE',title:'描述',width:120,align:'left',styler:statuStyle,formatter:function(value,rec){
			           if(value==null||value==""){
			              return "无";
			           }else{
			              return "<a href='#'>"+value+"</a>";
			           } 
			        }}
			         
 				]],
		     pagination:false,
		     title:"当前选择忽略的作业",
		     rownumbers:true, 
 		     fit:true,
		     nowrap: true,
		     striped: true,
		     border : false, 
		     singleSelect:true, 
		     toolbar : [ {   id : "button-delete",	
		               text : "当前页全部移除", 
		               iconCls : "icon-remove",
		               handler :function(){
		                   $("#ignoreJobtable").datagrid("loadData",[]);
		               }
	               }],
		     onLoadSuccess:function(){  
		     },
		      onDblClickRow:function(rowIndex, rowData){  
	            $("#ignoreJobtable").datagrid("deleteRow",rowIndex);
	             $("#ignoreJobtable").datagrid("acceptChanges");
	              $("#ignoreJobtable").datagrid("loaded");
	         } ,
	        onClickCell:function(rowIndex,field,value){
	         $("#ignoreJobtable").datagrid("selectRow",rowIndex);
	         var rec=$("#ignoreJobtable").datagrid("getSelected"); 
	                if(field=="DESCRIBE"){
	                 if(rec.DESCRIBE!=null&&rec.DESCRIBE!=""){
 	                   document.getElementById("message").innerText=rec.DESCRIBE;
 	                   errmessageDialog.dialog("open"); 
 	                 } 
	       }
	    }   
	   });
	   errmessageDialog=$("#TaskerrmessageDialog").show().dialog({
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
	   detailDialog=$("#TaskdetailDialog").show().dialog({
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
       inforeDialog=$("#TaskinforeDialog").show().dialog({
		modal : true, 
		maximizable:true,
		minimizable:true,
		resizable : true,
		buttons : [{
			text : "关闭",
			iconCls : "icon-cancel",
			handler : function() {
			  inforeDialog.dialog("close");
		    }
	    }]
       }).dialog("close");
       detailSunDialog=$("#TaskdetailSunDialog").show().dialog({
		modal : true, 
		maximizable:true,
		minimizable:true,
		resizable : true,
		buttons : [{
			text : "关闭",
			iconCls : "icon-cancel",
			handler : function() {
			  detailSunDialog.dialog("close");
		    }
	    }]
       }).dialog("close"); 
       addTaskDialog=$("#TaskaddTaskDialog").show().dialog({
		modal : true, 
		maximizable:true,
		minimizable:true, 
		resizable : true,
		buttons : [{
			text : "确定",
			iconCls : "icon-ok",
			handler : function() { 
			   addTaskFrame.doSubmit();
		    }
	    },{
			text : "关闭",
			iconCls : "icon-cancel",
			handler : function() {
			  addTaskDialog.dialog("close");
		    }
	    }]
       }).dialog("close"); 
      ignoreJobDialog=$("#TaskignoreJobDialog").show().dialog({
		modal : true, 
		maximizable:true,
		minimizable:true,
		resizable : true,
		buttons : [{
			text : "确定",
			iconCls : "icon-ok",
			handler : function() {
			  var ignoreType=$("input[name='ignoreRunType']:checked").val();
			  var recordes=$("#ignoreJobtable").datagrid("getRows"); 
			  if(ignoreType!=null&&ignoreType!=""){
			     if(recordes.length>0){
			        if(confirm("您好、确定当前选中作业的忽略方式吗？")){ 
       	              $.ajax({
       	                 url:"<c:url value='/runJobDetail.op'/>",
       	                 data:{"taskId":row.TASKID,"flag":ignoreType,"ignoreJobs":$.toJSON(recordes)},
       	                 dataType:"json",
       	                 type:"post",
       	                 success:function(data){
        	                $.messager.show({
       	                        title:"提示",
       	                        msg:data.message
       	                    });
       	                    if(data.flag!="false"){ 
       	                       ignoreJobDialog.dialog("close");
       	                    }
       	                 },
       	                 error:function(){
       	                    $.messager.show({
       	                       title:"提示",
       	                       msg:"操作出错，请检查！"
       	                    });
       	                 } 
       	             }); 
                   }   
			     }else{ 
			         alert("请选择忽略执行的作业！");
			     }
			  }else{
			     alert("请选择忽略执行方式！");
			  } 
		    }
	    },{
			text : "关闭",
			iconCls : "icon-cancel",
			handler : function() {
			  ignoreJobDialog.dialog("close");
		    }
	    }]
       }).dialog("close"); 
      }); 
      function doOperate(operateFlag){
          operateType=operateFlag;  
      }
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
             title:"批量运行任务控制(页面将在"+refreshTim+" 秒钟后自动刷新)"
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
      function doBack(){
          var  taskid=row.TASKID;
          var runmode=row.RUNMODE;
          var status=row.STATUS;
          var batchdate=row.BATCHDATE;
       	 if(confirm("您好、确定断点重提吗？")){ 
       	    $.ajax({
       	      url:"<c:url value='/backController.op'/>",
       	      data:{"taskid":taskid,"batchdate":batchdate,"runmode":runmode,"status":status},
       	      dataType:"json",
       	      type:"post",
       	      success:function(data){ 
       	         $.messager.show({
       	            title:"提示",
       	            msg:data.message
       	         });
       	         if(data.flag!="false"){ 
       	           doRefresh();
       	         }
       	      },
       	      error:function(){
       	         $.messager.show({
       	            title:"提示",
       	            msg:"操作出错，请检查！"
       	         });
       	      } 
       	    }); 
           }  
        } 
        function doBlocking(){
          var  taskid=row.TASKID;
          var runmode=row.RUNMODE;
          var status=row.STATUS;
          var batchdate=row.BATCHDATE;
       	 if(confirm("您好、确定任务中断吗？")){ 
       	    $.ajax({
       	      url:"<c:url value='/blockingController.op'/>",
       	      data:{"taskid":taskid,"batchdate":batchdate,"runmode":runmode,"status":status},
       	      dataType:"json",
       	      type:"post",
       	      success:function(data){
       	         $.messager.show({
       	            title:"提示",
       	            msg:data.message
       	         });
       	         if(data.flag!="false"){ 
       	           doRefresh();
       	         }
       	      },
       	      error:function(){
       	         $.messager.show({
       	            title:"提示",
       	            msg:"操作出错，请检查！"
       	         });
       	      } 
       	    }); 
           }  
       }       
       function addTaskDialogClose(){
          addTaskDialog.dialog("close");
       }   
        function doAfresh(){ 
         var  taskid=row.TASKID;
         var runmode=row.RUNMODE;
         var status=row.STATUS;
         var batchdate=row.BATCHDATE;
       	 if(confirm("您好、确定重新执行吗？")){ 
       	    $.ajax({
       	      url:"<c:url value='/afreshController.op'/>",
       	      data:{"taskid":taskid,"batchdate":batchdate,"runmode":runmode,"status":status},
       	      dataType:"json",
       	      type:"post",
       	      success:function(data){
       	         $.messager.show({
       	            title:"提示",
       	            msg:data.message
       	         });
       	         if(data.flag!="false"){ 
       	           doRefresh();
       	         }
       	      },
       	      error:function(){
       	         $.messager.show({
       	            title:"提示",
       	            msg:"操作出错，请检查！"
       	         });
       	      } 
       	    }); 
           } 
        }  
        function doDelete(){ 
         var  taskid=row.TASKID;
         var runmode=row.RUNMODE;
         var status=row.STATUS;
         var batchdate=row.BATCHDATE;
       	 if(confirm("您好、确定删除吗？")){ 
       	    $.ajax({
       	      url:"<c:url value='/deleteController.op'/>",
       	      data:{"taskid":taskid,"batchdate":batchdate,"runmode":runmode,"status":status},
       	      dataType:"json",
       	      type:"post",
       	      success:function(data){ 
       	         $.messager.show({
       	            title:"提示",
       	            msg:data.message
       	         });
       	         if(data.flag!="false"){ 
       	           doRefresh();
       	         }
       	      },
       	      error:function(){
       	         $.messager.show({
       	            title:"提示",
       	            msg:"操作出错，请检查！"
       	         });
       	      } 
       	    }); 
           }
       } 
       
       function doIgnoreJob(){ 
         $("#jobtable").datagrid({  
		   url:"<c:url value='/taskMonitorDetail.op'/>",
		   queryParams:{"taskNo":row.TASKID,"batchdate":row.BATCHDATE}, 
		   title:"任务运行作业列表-"+row.TASKNAME, 
		   onLoadSuccess:function(){ 
		     ignoreJobDialog.dialog("open");
		   } 
	     });
       }  
       function doAddTask(){
          document.getElementById("addTaskFrame").src="<c:url value='/jobMaintain.op'/>?date="+new Date(); 
          addTaskDialog.dialog("open");
       }
       function doqueryJob(){
         $("#jobtable").datagrid("load",{"taskNo":row.TASKID,"batchdate":row.BATCHDATE,"jobNo":$("#Text_jobNo").val(),"jobType":$("#Text_jobType").combobox("getValue")});
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
	     <td  align="right"   width=" 10%"><a onclick="doquery()" class="easyui-linkbutton" iconCls="icon-search">查询</a></td> 
	     <td align="right" width="15%"><a onclick="doAddTask()" class="easyui-linkbutton" iconCls="icon-add">任务控制</a></td>
	</tr> 
</table> 
</form>
</div>
<div region="center"  style="width:100%;height:100%;background:#eef3fa;" >
	<table id="table" width="100%" >
	</table>
</div>


<div id="TaskdetailDialog" title="任务运行明细"    style="width:1000px;height:450px;background:#eef3fa;display:none;">
	<iframe name="detailTaskFrame" id="detailTaskFrame" marginheight="0" marginwidth="0" frameborder="0" width="100%" height="100%" src=""> </iframe> 
</div>
<div id="TaskerrmessageDialog" title="提示信息"     style="width:600px;height:300px;background:#eef3fa;display:none;"> 
 <p   ><span id="message"  style="white-space:pre;"></span></p>	    
</div>
<div id="TaskinforeDialog" title="详细信息"     style="width:600px;height:450px;background:#eef3fa;display:none;"> 
   <table style="width: 100%;table-layout:fixed;word-wrap:break-word;">
     <tr style="width:100%">
       <td align="right" width="20%">任务编号：</td><td  width="80%"  align="left" ><B><font  id="taskmessage" ></font></B></td>
    </tr>
    <tr style="width:100%">
       <td align="right" width="20%">任务名称：</td><td  width="80%"  align="left" ><B><font  id="taskNamemessage" ></font></B></td>
    </tr>
    <tr style="width:100%">
       <td align="right" width="20%">任务描述：</td><td  width="80%"  align="left" ><B><font  id="describemessage" ></font></B></td>
    </tr>
    <tr style="width:100%">
       <td align="right" width="20%">批量时间：</td><td  width="80%"  align="left" ><B><font  id="batchdatemessage" ></font></B></td>
    </tr>
    <tr style="width:100%">
       <td align="right" width="20%">运行方式：</td><td  width="80%"  align="left" ><B><font  id="runmodemessage" ></font></B></td>
    </tr>
    <tr style="width:100%">
       <td align="right" width="20%">执行状态：</td><td  width="80%"  align="left" ><B><font  id="statusmessage" ></font></B></td>
    </tr>
    <tr style="width:100%">
       <td align="right" width="20%">执行作业：</td><td  width="80%"  align="left" ><B><font  id="jobmessage" ></font></B></td>
    </tr>
    <tr style="width:100%">
       <td align="right" width="20%">完成率：</td><td  width="80%"  align="left" ><B><font  id="complemessage" ></font></B></td>
    </tr>
    <tr style="width:100%">
       <td align="right" width="20%">提示信息：</td><td  width="80%"  align="left" ><B><font  id="errormessage" ></font></B></td>
    </tr>
    <tr style="width:100%">
       <td align="right" width="20%">开始时间：</td><td  width="80%"  align="left" ><B><font  id="starttimemessage" ></font></B></td>
    </tr>
    <tr style="width:100%">
       <td align="right" width="20%">结束时间</td><td  width="80%"  align="left" ><B><font  id="endtimemessage" ></font></B></td>
    </tr> 
    </table>	    
</div>
<div id="TaskignoreJobDialog" title="任务运行忽略维护"     style="width:800px;height:450px;background:#eef3fa;display:none;">
	<div class="easyui-layout" fit="true" > 
	   <div region="north"    style="width: 100%; height: 55px;background:#eef3fa;">
          <form  id="searchJobForm" name="searchJobForm"   method="post"> 
           <table>  
	<tr class="body">
	     <td  align="right"   width=" 15%">作业编号：</td>
	     <td width="25%"  align="left"  >
	        <input type="text" name="jobNo"   id="Text_jobNo"  style="width: 160"  class="easyui-validatebox" />
	     </td> 
	     <td  align="right"   width=" 15%">作业类型：</td>
	     <td width="25%"  align="left"  >
              <select name="jobType" style="width: 160" id="Text_jobType" class="easyui-combobox" editable="false"  panelHeight="auto">
			<option value="">全部</option>
			<c:forEach var="item" items="${jobTypeList}">
				<option value='<c:out value="${item.key}"/>'><c:out value="${item.value}" /></option>
			</c:forEach>
		  </select>	 
	     </td>   
	     <td  align="right"   width=" 20%"><a onclick="doqueryJob()" class="easyui-linkbutton" iconCls="icon-search">查询</a></td>  
	</tr> 
</table> 
</form>
</div>
	   <div region="center"  style="width:100%;height:100%;background:#eef3fa;" >  
	     <table id="jobtable" width="100%"> 
	     </table>
        </div>
        <div region="east"  style="width:300px;height:100%;background:#eef3fa;" >  
	     <table id="ignoreJobtable" width="100%"> 
	     </table>
        </div>
        <div region="south" style="width: 100%; height: 40px;background:#eef3fa;">
           <table>  
			  <tr style="width:100%">
				  <td align="right" width="40%" >请选择作业忽略方式：</td>
				  <td align="left" width="60%">
				        <input type="radio" name="ignoreRunType"  value="2">从指定起点开始忽略
				        <input type="radio" name="ignoreRunType" value="1">忽略指定作业</td>
			 </tr>
		   </table> 
        </div>
	</div> 
</div>
<div id="TaskdetailSunDialog" title="任务运行明细子作业"     style="width:900px;height:450px;background:#eef3fa;display:none;">
	<iframe name="sunJobFrame" id="sunJobFrame" width="100%" height="100%" src=""> </iframe> 
</div>

<div id="TaskaddTaskDialog" title="任务控制管理"     style="width:900px;height:450px;background:#eef3fa;display:none;">
	<iframe name="addTaskFrame" id="addTaskFrame" width="100%" height="100%" src=""> </iframe> 
</div>
</body>
</html>

