<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/includes/head.jsp" %>
<html>
<head>
<title>子作业运行情况</title>
<script type="text/javascript">
  var refreshTim = "<c:out value='${refreshTim}' />";
  var flag=0;  
  $(function(){           
      var jobId = document.searchForm.jobId.value;
      var taskId =document.searchForm.taskId.value;
	  $("#table").datagrid({ 
	    columns:[[    
	                {field:'JOBID',title:'作业编号',width:250,align:'left'},  
			        {field:'JOBTYPE',title:'作业类型',width:100,align:'left',formatter:function(value,rec){
			           <c:forEach var="item" items="${jobTypeList}">
			              if(value=="<c:out value='${item.key}'/>")
				            return "<c:out value='${item.value}' />";
			           </c:forEach> 
			        }},  
			        {field:'STATE',title:'状态',width:100,align:'left',formatter:function(value,rec){
 			              if(value=="1"){
				            return "有效";
				          }else{
				            if(value=="0"){ 
				             return "无效";
				             }
				          }
 			        }},
			        {field:'DESCRIBE',title:'描述',width:220,align:'left',formatter:function(value,rec){
			           if(value==null||value==""){
			              return "无";
			           }else{
			              return "<a href='#' style='color:#660000;'>"+value+"</a>";
			           } 
			        }} 
 				]],
 	    toolbar : [{   id : "button-add",	
		               text : "当前页全部添加", 
		               iconCls : "icon-add",
		               handler :function(){
		                   var rows =$("#table").datagrid("getRows");
 		                   for(var i=0;i<rows.length;i++){
		                     var index=$("#selecttable").datagrid("getRowIndex",rows[i]);
	                         if(index=="-1"){ 
	                            $("#selecttable").datagrid("appendRow",rows[i]);  
	                            $("#selecttable").datagrid("loaded"); 
	                            $("#selecttable").datagrid("acceptChanges");
	                         } 
		                  }
		               }
	               }],
		pagination:true,
		rownumbers:true,
		url:"<c:url value='/unDependencesJobDataList.op'/>",
		queryParams:{"jobId":jobId,"taskId":taskId},
 		fit:true,
		nowrap: true,
		striped: true,
		border : false,
		title:"作业依赖配置列表",
		singleSelect:true, 
		pageList:[20,30,50,100],
		pageSize:20,
		onLoadSuccess:function(){
		   removeMaskStub(); 
		},
		onDblClickRow:function(rowIndex, rowData){    
	               var index=$("#selecttable").datagrid("getRowIndex",rowData);
	               if(index=="-1"){ 
	                 $("#selecttable").datagrid("appendRow",rowData);  
	                 $("#selecttable").datagrid("loaded"); 
	                 $("#selecttable").datagrid("acceptChanges");
	               }  
	         },
	    onClickCell:function(rowIndex,field,value){
	       $("#table").datagrid("selectRow",rowIndex);
	       var row=$("#table").datagrid("getSelected");  
	          if(field=="DESCRIBE"){
	            if(row.DESCRIBE!=null&&row.DESCRIBE!=""){
 	             document.getElementById("message").innerText=row.DESCRIBE;
 	             $("#errmessageDialog").dialog("open"); 
 	             }
	       }
	       } 
	   });
	   $("#selecttable").datagrid({ 
	    columns:[[   {field:'JOBID',title:'作业编号',width:250,align:'left'},  
			        {field:'JOBTYPE',title:'作业类型',width:100,align:'left',formatter:function(value,rec){
			           <c:forEach var="item" items="${jobTypeList}">
			              if(value=="<c:out value='${item.key}'/>")
				            return "<c:out value='${item.value}' />";
			           </c:forEach> 
			        }},  
			        {field:'STATE',title:'状态',width:100,align:'left',formatter:function(value,rec){
 			              if(value=="1"){
				            return "有效";
				          }else{
				            if(value=="0"){ 
				             return "无效";
				             }
				          }
 			        }} 
 				]],
		pagination:false,
		rownumbers:true, 
 		fit:true,
		nowrap: true,
		striped: true,
		border : false,
		title:"已选择作业列表",
		singleSelect:true,   
		toolbar : [ {   id : "button-delete",	
		               text : "当前页全部移除", 
		               iconCls : "icon-remove",
		               handler :function(){
		                   $("#selecttable").datagrid("loadData",[]);
		               }
	               }],
		onLoadSuccess:function(){ 
		},
		onDblClickRow:function(rowIndex, rowData){  
	            $("#selecttable").datagrid("deleteRow",rowIndex);
	             $("#selecttable").datagrid("acceptChanges");
	              $("#selecttable").datagrid("loaded");
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
       $("#selecttable").datagrid("loadData",[]);
      });  
       function doquery(){ 
           var jobId = document.searchForm.jobId.value;
          var taskId =document.searchForm.taskId.value;
           var sunJobNo = $("#Text_sunJobNo").val();
          $("#table").datagrid("load",{"jobId":jobId,"sunJobNo":sunJobNo,"taskId":taskId});
       }
      function doRefresh(){
           var jobId = document.searchForm.jobId.value;
          var taskId =document.searchForm.taskId.value;
           var sunJobNo = $("#Text_sunJobNo").val();
          $("#table").datagrid("reload",{"jobId":jobId,"sunJobNo":sunJobNo,"taskId":taskId}); 
      }
      function doAddDependenceJobs(){
         var jobId = document.searchForm.jobId.value;
         var taskId =document.searchForm.taskId.value;
			  var recordes=$("#selecttable").datagrid("getRows");  
			     if(recordes.length>0){
			        if(confirm("您好、确定当前选中的作业被触发吗？")){  
       	              $.ajax({
       	                 url:"<c:url value='/dependencesJobInfoController.op'/>",
       	                 data:{"jobId":jobId,"taskId":taskId,"jobIds":$.toJSON(recordes)},
       	                 dataType:"json",
       	                 type:"post",
       	                 success:function(data){
        	                $.messager.show({
       	                        title:"提示",
       	                        msg:data.message
       	                    });
       	                    if(data.flag!="false"){ 
       	                       window.parent.dialogClose();
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
			         alert("请选择被触发执行的作业！");
			     }
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
<input type="hidden" name="jobId" value="<c:out value='${jobId}' />" />  
<input type="hidden" name="taskId" value="<c:out value='${taskId}' />" />  
<table>  
	<tr class="body">
	     <td  align="right"   width=" 30%">作业编号：</td>
	     <td width="45%"  align="left"  >
	        <input type="text" name="sunJobNo"   id="Text_sunJobNo"  style="width: 160"  class="easyui-validatebox" />
	     </td>  
	     <td align="right" width="25%"><a onclick="doquery()" class="easyui-linkbutton" iconCls="icon-search">查询</a></td>
	</tr> 
</table> 
</form>
</div>
<div region="center"  style="width:100%;height:100%;background:#eef3fa;" >
	<table id="table" width="100%" >
	</table>
</div>
<div region="east"  style="width:300px;height:100%;background:#eef3fa;" >
	<table id="selecttable" width="100%" >
	</table>
</div>
<div id="errmessageDialog" title="提示信息"     style="width:400px;height:300px;background:#eef3fa;"> 
 <p   ><span id="message"  style="white-space:pre;"></span></p>	    
</div>  

</body>
</html>  


