<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/includes/head.jsp" %>
<html>
<head>
<title>任务执行计划维护列表</title>
<script type="text/javascript">
   var detailDialog;
    $(function(){      
	  $("#table").datagrid({  
	    columns:[[  {field:'USER_ID',title:'用户名',width:150,align:'left'},
			        {field:'USER_NAME',title:'用户姓名',width:200,align:'left'},
			        {field:'USER_SEX',title:'用户性别',width:120,align:'left',formatter:function(value,rec){
			           if(value=="w"){
			              return "女";
			           }else{
			             if(value=="m"){
			              return "男";
			           }else{
			              return "";
			              }
			           } 
			        }},
			        {field:'USER_DEPARTMENT',title:'用户所属机构',width:150,align:'left'},
			        {field:'USER_PHONE',title:'用户电话',width:150,align:'left'},
			        {field:'USER_STATUS',title:'用户状态',width:150,align:'left',formatter:function(value,rec){
			           if(value=="1"){
			              return "有效";
			           }else{
			             if(value=="0"){
			              return "无效";
			           }else{
			              return "";
			              }
			           } 
			        }}, 
			        {field:'USER_STARTTIME',title:'用户创建时间',width:150,align:'left'},
			        {field:'USER_MODIFYTIME',title:'用户修改时间',width:150,align:'left'} 
 				]],
		pagination:true,
		rownumbers:true,
		url:"<c:url value='/userController.op'/>",
 		fit:true,
		nowrap: true,
		striped: true,
		border : false,
		title:"用户信息列表",
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
                          $("#Param_userId").attr("readonly","readonly"); 
                         $("#Param_userId").css("color","666");   
			              detailDialog.dialog("open"); 
			              $("#detailform").form("load", { 
			                 userName:row.USER_NAME,
                             userSex:row.USER_SEX,
                             userNo:row.USER_NO,
                             userId:row.USER_ID,
                             userDepartment:row.USER_DEPARTMENT,
                             userPhone:row.USER_PHONE,
                             userStatus:row.USER_STATUS,
                             password1:row.USER_PASSWORD,
                             password2:row.USER_PASSWORD
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
			                 userName:row.USER_NAME,
                             userSex:row.USER_SEX,
                             userNo:row.USER_NO,
                             userId:row.USER_ID,
                             userDepartment:row.USER_DEPARTMENT,
                             userPhone:row.USER_PHONE,
                             userStatus:row.USER_STATUS,
                             password1:row.USER_PASSWORD,
                             password2:row.USER_PASSWORD
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
 			                 userName:row.USER_NAME,
                             userSex:row.USER_SEX,
                             userNo:row.USER_NO,
                             userId:row.USER_ID,
                             userDepartment:row.USER_DEPARTMENT,
                             userPhone:row.USER_PHONE,
                             userStatus:row.USER_STATUS,
                             password1:row.USER_PASSWORD,
                             password2:row.USER_PASSWORD
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
	    }  
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
			     if($("#password1").val()!=$("#password2").val()) {
			        alert("请输入的密码与确认密码相同！");
			        return false;
			     }
			     document.getElementById("userPassword").value=$("#password1").val();
			  $("#detailform").form("submit",{
                  url:"<c:url value='/editUserController.op'/>", 
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
          var userName = $("#Text_userName").val();
          var userId = $("#Text_userId").val();
          $("#table").datagrid("load",{"userId":userId,"userName":userName});
       }
      function doRefresh(){
          var userName = $("#Text_userName").val();
          var userId = $("#Text_userId").val();
          $("#table").datagrid("reload",{"userId":userId,"userName":userName});
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
	     <td  align="right"   width=" 10%">用户编号：</td>
	     <td width="15%"  align="left"  >
	        <input type="text" name="userId"   id="Text_userId"  style="width: 160"  class="easyui-validatebox" />
	     </td>
	     <td  align="right"   width=" 10%">用户名：</td>
	     <td width="15%"  align="left"  >
	        <input type="text" name="userName"   id="Text_userName"  style="width: 160"  class="easyui-validatebox" />
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
<div id="detailDialog" title="用户明细"     style="width:700px;height:450px;background:#eef3fa;">
	<form name="detailform"  id="detailform" action=""   method="post"> 
	<input name="flag" value="" type="hidden">
	<spring:bind path="command.userNo">
	<input name="<c:out value='${status.expression}'/>" value="<c:out value='${status.value}'/>" type="hidden">
	</spring:bind>
	<spring:bind path="command.userPassword">
	<input name="<c:out value='${status.expression}'/>" id="userPassword" value="<c:out value='${status.value}'/>" type="hidden">
	</spring:bind>
    <table  width="100%">  
    <tr >
		<td height="30" align="right" >用户名：</td>
		<td align="left" >
		<spring:bind path="command.userId">
		<input type="text" name="<c:out value='${status.expression}'/>" id="Param_userId"  class="easyui-validatebox"  required="true" size="44" maxlength="20" value="<c:out value='${status.value}'/>"/>
 		</spring:bind></td>
	</tr>
	<tr >
		<td height="30" align="right" >用户姓名：</td>
		<td align="left" >
		<spring:bind path="command.userName">
			<input type="text" name="<c:out value='${status.expression }'/>" class="easyui-validatebox"  required="true" size="44" maxlength="20" value="<c:out value='${status.value }'/>" />
 		</spring:bind>
		</td>
	</tr>
	
	<tr >
		<td height="30" align="right" >用户性别：</td>
		<td align="left" >
				<spring:bind path="command.userSex">
					<select name="<c:out value='${status.expression }'/>" editable="false" panelHeight="auto" class="easyui-combobox"  required="true" style="width: 300">
                       <option value="">请选择</option>
                        <option value="w" >女</option>
                         <option value="m" >男</option>
					</select>
				</spring:bind>
			</td>
	</tr>

	<tr >
		<td height="30" align="right" >所属机构：</td>
		<td align="left" >
		<spring:bind path="command.userDepartment">
			<input type="text" name="<c:out value='${status.expression }'/>" class="easyui-validatebox"    size="44" maxlength="5" value="<c:out value='${status.value }'/>" />
 		</spring:bind></td>
	</tr>
	<tr >
		<td height="30" align="right" >用户电话：</td>
		<td align="left" >
		 <spring:bind path="command.userPhone">
			<input type="text" name="<c:out value='${status.expression }'/>"class="easyui-validatebox"    size="44" maxlength="11" value="<c:out value='${status.value }'/>" />
 		</spring:bind></td>
	</tr>
	<tr >
		<td height="30" align="right" >用户状态：</td>
		<td align="left" >
				<spring:bind path="command.userStatus">
					<select name="<c:out value='${status.expression }'/>" editable="false" panelHeight="auto" class="easyui-combobox"  required="true" style="width: 300">
                        <option value="1" >有效</option>
                        <option value="0">无效</option>                         
					</select>
				</spring:bind>
			</td>
	</tr>
	<tr >
		<td height="30" align="right" >用户密码：</td>
		<td align="left" >
			<input type="password"  id="password1" name="password1" class="easyui-validatebox"  required="true" size="44" style="width: 300" maxlength="15" value=""/>
			<font color="red"><c:out value="${status.errorMessage}"></c:out></font>
		</td>
	</tr>
	<tr >
		<td height="30" align="right" >重新输入密码：</td>
		<td align="left" >
			<input type="password"  id="password2" name="password2" class="easyui-validatebox"  required="true" size="44" style="width: 300" maxlength="15" value=""/>
 		</td>
	</tr> 
   </table>
</form>
</div>  
</body>
</html>



