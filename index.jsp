<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib  prefix="c" uri="http://java.sun.com/jstl/core"%>
<html>
<head>
<title>调度管理平台</title>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/themes/default/easyui.css' />">
<script type="text/javascript" src="<c:url value='/js/jquery-1.4.4.min.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/jquery.easyui.min.js' />"></script>
	<script>

	$(function(){
		var p = $('body').layout('panel','west').panel({
			onCollapse:function(){
			}
		});
	
	});
	function goOut(){
	   if(confirm("您确定要退出系统吗？"))
	   {  indexForm.method="post";
	      document.indexForm.flag.value="exit";
	      indexForm.action="<c:url value='/login.op'/>";
	      indexForm.method="get";
		  indexForm.submit();
	   }
	}
	</script>
	<style type="text/css">
   
.menubar {
	BORDER-RIGHT: #96d9f9 1px solid;
	PADDING-RIGHT: 1px;
	BORDER-TOP: #96d9f9 1px solid;
	PADDING-LEFT: 1px;
	FONT-SIZE: 9pt;
	BACKGROUND: url(./images/menubar_bg.gif) #d9edf6 repeat-x 50% top;
	PADDING-BOTTOM: 1px;
	BORDER-LEFT: #96d9f9 1px solid;
	CURSOR: default;
	PADDING-TOP: 1px;
	BORDER-BOTTOM: #96d9f9 1px solid
}

/* Rule 116 of /acctPolicy/resources/skins/blue/skin.css */
.menubar .menuitem {
	PADDING-RIGHT: 5px;
	PADDING-LEFT: 5px;
	PADDING-BOTTOM: 1px;
	PADDING-TOP: 1px;
	WHITE-SPACE: nowrap;
	BACKGROUND-COLOR: transparent
}

/* Rule 6 of /acctPolicy/styles/blue/default.css */
.head_table {
	BACKGROUND: url(./images/main-head-bg.jpg) center center;
	WIDTH: 100%;
	HEIGHT: 100%
}

 

/* Rule 8 of /acctPolicy/styles/blue/default.css */
.head_title {
	FONT-SIZE: 20pt;
	VERTICAL-ALIGN: top;
	WIDTH: 100%;
	PADDING-TOP: 5px;
	TEXT-ALIGN: center
}
/* Rule 16 of /acctPolicy/resources/skins/blue/skin.css */
.label {
	FONT: 7pt Verdana, "宋体"
} 
 .head_button {	
             VERTICAL-ALIGN: top;	
             WIDTH: 100px
             } 
 /* Rule 12 of /acctPolicy/styles/blue/default.css */ 
 UL.m_op {	
              MARGIN: 0px;	
              PADDING-TOP: 10px;	
              HEIGHT: 4px;
              } 
  /* Rule 13 of /acctPolicy/styles/blue/default.css */ 
 UL.m_op LI {	
               PADDING-RIGHT: 10px;	
               FLOAT: LEFT;	
               LIST-STYLE-TYPE: none
               } 
  /* Rule 1 of /acctPolicy/styles/blue/default.css */ 
   A {	
      FONT: 9pt Verdana,"宋体" 
      TEXT-DECORATION: none
      }
  /* Rule 14 of /acctPolicy/styles/blue/default.css */ 
   UL.m_op LI A {	
           PADDING-RIGHT: 0px;	
           DISPLAY: block;	
           FONT-SIZE: 8pt; 
           PADDING-LEFT: 20px;	
           BACKGROUND-IMAGE: url(./images/main-head_ico.gif);	
           PADDING-BOTTOM: 0px;	
           COLOR: #006699;	
           BACKGROUND-REPEAT: no-repeat;	
           TEXT-DECORATION: none
           }
   A.welcome{
      FONT: 9pt Verdana,"宋体";
      COLOR: #575757;		
      TEXT-DECORATION: none
   }
/* Rule 14 of /acctPolicy/styles/blue/default.css */ 
  A.m_op_lk_3 {	
         
        BACKGROUND-POSITION: 0px -65px
        }
</style>
</head>
<form action=""  method="POST"  name="indexForm" >
<input name="flag" value="" type="hidden">
<body class="easyui-layout">
 <div region="north" border="true" style="width:100%;height:75px">
	<table cellpadding="0" cellspacing="0" style="right:0px;margin-right:0px;width:100%;height:98%">
    <tr>
	 <TD style="width:100%;height:5%;">
	<TABLE class="head_table" cellSpacing="0" cellPadding="0" border="0">
		<TBODY>
			<TR>
				<TD width="20%"><IMG src="./images/loginUp.gif" align="middle" /></TD>
				<TD class="head_title" width="75%">
				    <LABEL class="label" id="titlestrdemo" typeId="label">
				      <TABLE cellSpacing="0" cellPadding="0" border="0">
					  <TBODY>
						<TR>
							<TD class="head_title" style="LINE-HEIGHT: 25px" align="center">业务调度管理系统</TD>
						</TR>
					 </TBODY>
				    </TABLE>
				   </LABEL>
				</TD>
				<TD width="5%">
				<TABLE class="head_table" cellSpacing="0" cellPadding="0" border="0">
				<TBODY>
				<TR> 
				<TD class="head_button" noWrap align="right" style="text-align: center; ">	
				<UL class="m_op">
				<LI><A>           </A>
				</LI>
				<LI>
				</LI>
				<LI><A class="m_op_lk_3" href="#" onClick="goOut();">注销</A>
				</LI>
				</UL>
				<A class="welcome">欢迎您，<c:out value='${user_name}'/></A>
				</TD> 
				</TR>
				</TBODY>
				</TABLE>
				</TD>
			</TR>
		</TBODY>
	</TABLE>
	</TD>
    </tr>
    <TR>
	<TD style="width:100%;height:4px;">
	<DIV class="menubar">
	<TABLE cellSpacing="0" cellPadding="0">
		<THEAD>
			<TR>
				<TD class="menuitem">&nbsp;</TD>
			</TR>
		</THEAD>
		<TBODY>
		</TBODY>
	</TABLE>
	</DIV>
	</TD>
</TR>
    </table>		 		  
	</div>
	<div region="west" split="true" title="菜单栏" style="width:190px;padding:0px;">
	    <table height="100%" width="100%" cellspacing="0" cellpadding="0">
			 <tr>
				<td width="100%" height="4"><img src="<c:url value='/images/bottomline.gif' />" width="100%" height="1"></td>
			 </tr>
			<tr height="100%" valign="top">
				<td width="100%"><iframe name="left" style="overflow:auto;width:100%;height:100%;margin:0;padding:0" frameborder="0" src="<c:url value='/menuTreeView.op'/>"></iframe></td>
			</tr>
      </table>
	</div> 
	<div region="south" border="true" style="height:35px;"  align="center" >
     <table class="commonTable" CELLSPACING="0" CELLPADDING="0" >
	  <tr>
		<td width="100%"><img SRC="./images/bottomline.gif" WIDTH="100%" HEIGHT="1"></td>
	  </tr>
	  <tr> 
		<td ALIGN="center" HEIGHT="30">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <font size="3" COLOR=#7f7f7f>&copy; Copyright 沣邦融资租赁(上海)有限公司</font></td>
	  </tr> 
      </table>
    </div>
	<div region="center" title="视图操作" style="width:350px;padding:0px;"> 
	  <table height="100%" width="100%" cellspacing="0" cellpadding="0">
		 <tr>
			<td width="100%" height="4"><img src="<c:url value='/images/bottomline.gif' />" width="100%" height="1"></td>
		 </tr>
		<tr height="100%" valign="top">
			<td width="100%"><iframe name="main" style="overflow:auto;width:100%;height:100%;margin:0;padding:0" frameborder="0" 
			src="<c:url value='/firstpage.html'/>"></iframe></td><!-- <c:url value='/importDataController.op'/> -->
		</tr>
      </table>
    </div>
</body>
</form>
</html>
