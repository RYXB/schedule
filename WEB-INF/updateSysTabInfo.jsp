<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/includes/head.jsp"%>
<html>
<head>
<title>源系统表</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<link rel="stylesheet" href="<c:url value='/css/zTreeStyle/zTreeStyle.css'/>" type="text/css">
<script type="text/javascript" src="<c:url value='/js/jquery-1.4.4.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/jquery.ztree.core-3.5.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/jquery.ztree.excheck-3.5.js'/>"></script>

<script  type="text/JavaScript">
var jq=$.noConflict();
var xmlHttp;
var scheamasList=new Array();
var scheamasTabList=new Array();
var tabColList=new Array();
var v="";
var id="";
function createXMLHttpRequest() {
  if (window.ActiveXObject) {
     xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
   } 
  else 
    if (window.XMLHttpRequest) {
        xmlHttp = new XMLHttpRequest();                
    }
}
function doSubmit(){
	if(validate()){
    if(confirm("您好、确定新增吗？")){
    	form.submit();	
      }
    }
}
function goBack(){
	form.action="<c:url value='/userController.op'/>";
	form.method="get";
	form.submit();	
}

function getDBScheamas(){
	var dbTns=document.form.dbTns.value;
    createXMLHttpRequest();
    var url = "<c:url value='/getDbScheamaList.op'/>?dbTns="+dbTns+"&date="+new Date();
    xmlHttp.open("post", url, true);
    xmlHttp.onreadystatechange = pollCallbackSchema;
    xmlHttp.send(null);
	
}
function pollCallbackSchema() {
	  if (xmlHttp.readyState == 4) {
	     if (xmlHttp.status == 200) {    
	       var runs = xmlHttp.responseXML.getElementsByTagName("run");  
	       scheamasList=new Array();
	       for(var i=0;i<runs.length;i++){
	       	 var run=runs[i];
	       	 var bean=new  Array();
	         bean[0]=run.getElementsByTagName("colCode")[0].childNodes[0].nodeValue;
	       	 bean[1]=run.getElementsByTagName("colValue")[0].childNodes[0].nodeValue;
	       	 scheamasList.push(bean);
	       }
	       scheamaChange("");
	     }
	  }
	}
function scheamaChange(value){   
	  if(value==""){
		  value=document.form.username.value;
	  }
	  var sel=document.getElementById("scheama");
	  for(var i=0;i<sel.options.length;i++){      
		  sel.options.remove(i);
     }
	  for(var i=0;i<scheamasList.length;i++){    
		  var op=new Option();    
		  var bean=new  Array();
		  bean=scheamasList[i];
		  op.value=bean[0];      
		  op.text=bean[1];      
		  sel.options.add(op);
		  if(value.toUpperCase()==op.value){ 
			  op.selected="selected";   
          }
     }
 var dbTns=document.form.dbTns.value;
 var scheama=document.form.scheama.value;
 createXMLHttpRequest();
 var url = "<c:url value='/getScheamaTableList.op'/>?dbTns="+dbTns+"&scheama="+scheama+"&date="+new Date();
 xmlHttp.open("post", url, true);
 xmlHttp.onreadystatechange = pollCallbackTable;
 xmlHttp.send(null);
} 
function pollCallbackTable() {
	  if (xmlHttp.readyState == 4) {
		     if (xmlHttp.status == 200) {    
		       var runs = xmlHttp.responseXML.getElementsByTagName("run");  
		       scheamasTabList=new Array();
		       for(var i=0;i<runs.length;i++){
		       	 var run=runs[i];
		       	 var bean=new  Array();
		         bean[0]=run.getElementsByTagName("colCode")[0].childNodes[0].nodeValue;
		       	 bean[1]=run.getElementsByTagName("colValue")[0].childNodes[0].nodeValue;
		       	 scheamasTabList.push(bean);
		       }
		       tableChange("");
		     }
		  }
		}
function tableChange(value){   
	  var sel=document.getElementById("tabName");
	  sel.options.length=0;
	  for(var i=0;i<scheamasTabList.length;i++){    
		 var op=new Option();    
		 var bean=new  Array();
		 bean=scheamasTabList[i];
		 op.value=bean[0];      
		 op.text=bean[1];      
		 sel.options.add(op);
		 if(value.toUpperCase()==op.value){ 
			 op.selected="selected";   
	     }
	  }
    if(value!=null&&value!=""){
	  var dbTns=document.form.dbTns.value;
	  var scheama=document.form.scheama.value;
	  var tableName=document.form.tabName.value;
	  createXMLHttpRequest();
	  var url = "<c:url value='/getScheamaTableColList.op'/>?dbTns="+dbTns+"&scheama="+scheama+"&tableName="+tableName+"&date="+new Date();
	  xmlHttp.open("post", url, true);
	  xmlHttp.onreadystatechange = pollCallbackTableCol;
	  xmlHttp.send(null);
   }
}
function pollCallbackTableCol(){
	if (xmlHttp.readyState == 4) {
	     if (xmlHttp.status == 200) {
	    	 var runs = xmlHttp.responseXML.getElementsByTagName("run");  
	    	 var obj=new Array();
	    	 var initvalue=document.form.colList.value;
             var values=initvalue.split(",");
             v = "";
             alert(runs.length);
		     for(var i=0;i<runs.length;i++){
   	            var node=new Object();
   	            node.id=runs[i].getElementsByTagName("colCode")[0].childNodes[0].nodeValue;
   	            node.name=runs[i].getElementsByTagName("colValue")[0].childNodes[0].nodeValue;
   	            node.pId="1";
   	            for(var j=0;j<values.length;j++){
   		        if(node.id==values[j]){
   			       node.checked=true;
   		           v +=nodes[i].getElementsByTagName("colCode")[0].childNodes[0].nodeValue+",";
   		        }
   	         }
   	         obj[i]=node;
           }
          var zNodes=obj;
          if (v.length > 0 ) v = v.substring(0, v.length-1);
	      var cityObj =jq("#citySelcol");
	      cityObj.attr("value", v);
	      var setting = {
			check: {
				enable: true,
				chkboxType: {"Y":"", "N":""}
			},
			view: {
				dblClickExpand: false
			},
			data: {
				simpleData: {
					enable: true
				}
			},
			callback: {
				beforeClick: beforeClick,
				onCheck: onCheck
			}
		  };
      jq.fn.zTree.init(jq("#treeDemo"), setting, zNodes);
    }
  }
}

function beforeClick(treeId, treeNode) {
	var zTree =jq.fn.zTree.getZTreeObj(treeId);
	zTree.checkNode(treeNode, !treeNode.checked, null, true);
	return false;
}

function onCheck(e, treeId, treeNode) {
	var zTree = jq.fn.zTree.getZTreeObj(treeId);
	if(treeNode.id=="totalall"){
		zTree.checkAllNodes(treeNode.checked);
	}else{
		if(treeNode.id!="totalall"&&!treeNode.checked){
			var oneallnode=zTree.getNodeByTId(treeId+"_1");
			zTree.checkNode(oneallnode,false,false,false);
		}
	}
	nodes = zTree.getCheckedNodes(true);
	 v = "";
	 id="";
	for (var i=0, l=nodes.length; i<l; i++) {
		if(nodes[i].id!="totalall"){
		v += nodes[i].name + ",";
		id+=nodes[i].id + ",";
	}}
	if (v.length > 0 ) v = v.substring(0, v.length-1);
	if (id.length > 0 ) id = id.substring(0, id.length-1);
	document.form.citySelcol.value=v;
}

function showMenu() {
	var citySel="#citySelcol";
	var cityObj = jq(citySel);
	var cityOffset = jq(citySel).offset();
	jq("#menuContent").css({left:cityOffset.left+ "px", top:cityOffset.top + cityObj.outerHeight()+ "px"}).slideDown("fast");
	jq("body").bind("mousedown", {}, onBodyDown);
}
function hideMenu() {
	jq("#menuContent").fadeOut("fast");
	jq("body").unbind("mousedown", {},onBodyDown);
}
function onBodyDown(event) {
	if (!(event.target.id == ("menuBtn") || 
			(event.target.id == "citySelcol") || 
			(event.target.id == "menuContent") || 
			(jq(event.target).parents("#menuContent")).length>0)) {
		hideMenu();
	}
}
</script>
</head>
<body onload="getDBScheamas()">
<form name="form" action="<c:url value='/addTableInfo.op'/>" method="post">
<input name="key" value="<c:out value='${key}'/>" type="hidden">
<spring:bind path="command.dbServer"><input type="hidden" name="<c:out value='${status.expression}'/>" value="<c:out value='${status.value}'/>"/></spring:bind>
<spring:bind path="command.ip"><input type="hidden" name="<c:out value='${status.expression }'/>" value="<c:out value='${status.value }'/>" /></spring:bind>
<spring:bind path="command.username"><input type="hidden" name="<c:out value='${status.expression }'/>"  value="<c:out value='${status.value }'/>" /></spring:bind>
<spring:bind path="command.passwd"><input type="password" style="display:none;" name="<c:out value='${status.expression }'/>" value="<c:out value='${status.value }'/>" /></spring:bind>
<br>
<br>
<br>
<br>
<table align="center" width="60%">
	<tr>
		<td class="headtitle">源系统表维护</td>
	</tr>
</table>
<table align="center" width="60%" border="1" cellspacing="1" cellpadding="0">
     <tr class="body">
		<td height="30" align="right" width="30%" class="listhead">数据库ID：</td>
		<td align="left" class="listhead"><spring:bind path="command.dbTns">
		    <select name="<c:out value='${status.expression }'/>" objName="数据库ID" nullable="false" style="width:300" >
				<c:forEach var="item" items="${dbTnsList}">
					<option value='<c:out value="${item.CODE}"/>'
						<c:if test="${item.CODE == status.value}">selected="selected"</c:if>><c:out
						value="${item.VALUE}" /></option>
				</c:forEach>
			</select>
		   <font color="red"><c:out value="${status.errorMessage}"></c:out></font></spring:bind>
	    </td>
	</tr>
	<tr class="body">
		<td height="30" align="right"  width="30%"class="listhead">模式名：</td>
		<td align="left" class="listhead"><spring:bind path="command.scheama">
		   <select name="<c:out value='${status.expression}'/>" id="<c:out value='${status.expression}'/>" objName="模式名" style="width:300"  value="<c:out value='${status.value}'/>" nullable="false" class="select" onchange="scheamaChange(this.value)"></select>
		   <font color="red"><c:out value="${status.errorMessage}"></c:out></font></spring:bind>
	    </td>
	</tr>
	<tr class="body">
		<td height="30" align="right"  width="30%"class="listhead">表名：</td>
		<td align="left" class="listhead"> <spring:bind path="command.tabName">
		   <select name="<c:out value='${status.expression}'/>" id="<c:out value='${status.expression}'/>" objName="表名" style="width:300"  value="<c:out value='${status.value}'/>" nullable="false" class="select" onchange="tableChange(this.value)">
		     <option value="">请选择</option>
		   </select>
		   <font color="red"><c:out value="${status.errorMessage}"></c:out></font></spring:bind>
		</td>
	</tr>
	<tr class="body">
		<td height="30" align="right"  width="30%"class="listhead">表中文名：</td>
		<td align="left" class="listhead"><spring:bind path="command.tabCnName">
		   <input type="text" name="<c:out value='${status.expression }'/>" objName="表中文名" nullable="false" style="width: 300" maxlength="20" value="<c:out value='${status.value }'/>" />
		   <font color="red"><c:out value="${status.errorMessage}"></c:out></font></spring:bind>
		</td>
	</tr>
	<tr class="body" style="display:none;">
		<td height="30" align="right"  width="30%" class="listhead"></td>
		<td align="left" class="listhead"><spring:bind path="command.colList">
		   <input type="hidden" id="citySel" name="<c:out value='${status.expression }'/>" value="<c:out value='${status.value }'/>" />
		   <font color="red"><c:out value="${status.errorMessage}"></c:out></font></spring:bind>
		</td>
    </tr>
	<tr style="width:100%;" >
	    <td height="30" align="right"  width="30%" class="listhead">列清单：</td>
        <td align="left" class="listhead">
           <input id="citySelcol" name="citySelcol" type="text"  style="width:300px;"  objName="列清单" readonly="readonly" nullable="false" onclick="showMenu();" value=""/>
           <div id="menuContent" class="menuContent" style="display:none; position: absolute;"><ul id="treeDemo" class="ztree" style="margin-top:0; width:260px; height: 200px;"></ul>
           </div>
        </td>
    </tr>  
	<tr class="body">
		<td height="30" align="right" width="30%" class="listhead">过滤条件：</td>
		<td align="left" class="listhead"><spring:bind path="command.filerStr">
		   <input type="text" name="<c:out value='${status.expression }'/>"objName="过滤条件" style="width: 300" maxlength="5" value="<c:out value='${status.value }'/>" />
		   <font color="red"><c:out value="${status.errorMessage}"></c:out></font></spring:bind>
	    </td>
	</tr>
	<tr class="body">
		<td height="30" align="right"  width="30%"class="listhead">文件名：</td>
		<td align="left" class="listhead"><spring:bind path="command.fileName">
		   <input type="text" name="<c:out value='${status.expression }'/>"objName="文件名" style="width: 300" maxlength="5" value="<c:out value='${status.value }'/>" />
		   <font color="red"><c:out value="${status.errorMessage}"></c:out></font></spring:bind>
		</td>
	</tr>
	<tr class="body">
		<td  align="center" colspan="2" class="listhead">
		<input name="button221" type="button" class="button2" value="确　　定" onclick="javascript:doSubmit();"> 
		<input name="button222" type="button" class="button2" value="返　　回" onclick="javascript:goBack();"></td>
	</tr>
</table>
</form>
</body>
</html>
