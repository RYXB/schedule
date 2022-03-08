<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/includes/head.jsp" %>
<html>
<head>
<title>文件列表</title>
<script type="text/javascript">
  $(function(){ 
	  $("#table").datagrid({
	    columns:[[   
 					{field:'FILE_NAME',title:'处理名称',width:300,align:'left'},
					{field:'FILE_WEIGHT',title:'处理大小',width:300,align:'left'}
				]],
		pagination:true,
		rownumbers:true,
		fit:true,
		nowrap: false,
		striped: true,
		border : false,
		title:"日志数据下载",
		singleSelect:true,
		checkbox:false,
		pageList:[50,80,100,150],
		pageSize:80,
		toolbar : [{
		               id : "button-download",	
		               text : "下载文件",
		               iconCls : "icon-download",
		               handler :doLoad
	               }],
		url:"<c:url value='/dataDownLoadDataList.op'/>",
		queryParams:{reportId:document.searchForm.reportId.value},
		onLoadSuccess:function(){ 
			 removeMaskStub();
			 }
	   });
       $("#Text_dataDt").datebox({
          formatter:function(date){  
               return date.Format("yyyy-MM-dd")+"";
          }
       });    
  });
  function doLoad(){ 	
     var rows = $("#table").datagrid("getSelections");
     var rptkey="";
     if(rows.length>0){ 
       document.searchForm.rptkey.value=rows[0].FILE_NAME;
	   if(confirm("您好、确定要下载选中的文件吗？")){ 
			searchForm.action="<c:url value='/exportDataControl.op'/>";
	    	searchForm.method="post";
	    	searchForm.submit(); 
		}
     }else{
       $.messager.show({
		  msg :"请选择您要下载的数据！",
		  title :"提示" 
	   });
     } 
		 
  }  
  function doquery(){
  		 $("#table").datagrid("load",{datadt:$("#Text_dataDt").datebox("getValue")});
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
<input name="rptkey" type="hidden" value=""/>
<input name="reportId" type="hidden" value="<c:out value='${reportId}'/>"/>
<table> 
	<tr class="body">
	     <td  align="right"   width=" 10%">处理日期</td>
	     <td width="15%"  align="left"  >
	         <input id="Text_dataDt" class="easyui-datebox" name="datadt"  editable="false" panelWidth="260" style="width:260px;"/>
	     </td>
         <td align="right" width="50%"></td>
		 <td align="right" width="25%"><a onclick="doquery()" class="easyui-linkbutton" iconCls="icon-search">查询</a></td>
	</tr>
</table>
</form>
</div>
<div region="center"  style="width:100%;height:100%;background:#eef3fa;" >
	<table id="table" width="100%" >
	</table>
</div>

</body>
</html>
