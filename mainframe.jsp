<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib  prefix="c" uri="http://java.sun.com/jstl/core"%>
<html>
<head>
<title>调度管理平台</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<link rel="stylesheet" href="<c:url value='/css/mainPage.css' />" type="text/css">
</head>
<script language="JavaScript" type="text/JavaScript">
function signOff_submit(){
	   if(confirm("您确定要退出系统吗？"))
	   {  indexForm.method="post";
	      document.indexForm.flag.value="exit";
	      indexForm.action="<c:url value='/login.op'/>";
	      indexForm.method="get";
		  indexForm.submit();
	   }
	}
</script>
<form action=""  method="POST"  name="indexForm" >
<input name="flag" value="" type="hidden">
<body bottommargin=0 leftmargin=0 rightmargin=0 topmargin=0 style="overflow:auto">
<script language="JavaScript" type="text/JavaScript">
javascript:window.history.forward(1); 
var switchNum=0;
function switchSysBar()
{
    if (switchNum==0)
    {
        document.all.switchPoint.src="<c:url value="/images/panel_right.gif" />";
		document.all("frmTitle").style.display="none";
        switchNum=1;
    }
    else
    {
        document.all.switchPoint.src="<c:url value="/images/panel_left.gif" />";
		document.all("frmTitle").style.display="";
        switchNum=0;
    }
}

//捕获ie浏览器关闭，清除该用户session
//function window.onunload(){ 
//	if((window.screenLeft>=10000 && window.screenTop>=10000)||event.altKey) {
//		signOff_submit(flag);
//	}
//}
function signOff_submit(){
	if(confirm("您确定要退出系统吗？"))
	 {  indexForm.method="post";
		document.indexForm.flag.value="exit";
		indexForm.action="<c:url value='/login.op'/>";
		indexForm.method="get";
		indexForm.submit();
     }
}

</script>
<table class="commonTable" width="100%" height="100%" cellspacing="0" cellpadding="0" border="0">
	 <tr>
	 <td style="width:100%;height:7%">
	<table cellpadding="0" cellspacing="0" style="right:0px;margin-right:0px;width:100%;height:98%">
    <tr>
	 <TD style="width:100%;height:5%;">
	<TABLE class="head_table" cellSpacing="0" cellPadding="0" border="0">
		<TBODY>
			<TR>
				<TD width="20%"><IMG src="./images/wwhh_up.gif" align="middle" /></TD>
				<TD class="head_title" width="75%">
				    <LABEL class="label" id="titlestrdemo" typeId="label">
				      <TABLE cellSpacing="0" cellPadding="0" border="0">
					  <TBODY>
						<TR>
							<TD class="head_title" style="LINE-HEIGHT: 25px;" align="center"><font size="5px" class="selector">任务调度管理系统</font></TD>
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
				<LI><A class="m_op_lk_3" href="#" onClick="signOff_submit();">注销</A>
				</LI>
				</UL>
				<A class="welcome">欢迎您，<c:out value='${user_ID}'/></A>
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
	<TD style="width:100%;height:2%;">
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
    </td>		 		  
	</tr>
	<tr height="100%">
		<td width="100%">
		<table class="commonTable" cellspacing="0" cellpadding="0" height="100%" width="100%">
			<tr height="100%">
				<td width="170" align="left" style="background-color:aliceblue" valign="top" noWrap id=frmTitle height="100%">
				<form name="changeRoleForm" method="post" action="" target="_top">
				<table height="100%" cellspacing="0" cellpadding="0" >
					<br>
					<br>
					<tr height="100%" valign="top">
						<td width="100%" style="background-color:aliceblue"><iframe name="left" marginheight="0" marginwidth="0" frameborder="0" width="100%" style="padding-left:8px;"scrolling="auto" height="100%" src="<c:url value='/menuTreeView.op'/>"></iframe></td>
					</tr>
				</table>
				</form>
				</td>
				<td width="1" style="background-color:aliceblue" height="100%" align="left" onclick="javascript:switchSysBar()">
					<img src="<c:url value="/images/panel_left.gif" />" id="switchPoint" style="position:relative;left:6px"></td>
				<td width="100%;height:100%;">
					<TABLE  height="100%" cellSpacing="2"style="background-color:aliceblue" cellPadding="2" width="100%" align="center" border="0">
		                <TR>
						  <td height="100%" width="100%">
						  <iframe name="main" marginheight="0" marginwidth="0" frameborder="0" width="100%" height="100%" src="<c:url value='/pagefirst.jsp'/>">
						  </iframe>
						  </td>
					   </TR>
                    </TABLE>							      
                    </td>
                    </tr>
		</table>
		</td>
	</tr>
	<tr valign="bottom">
		<td width="100%">
		<table class="commonTable" height="30" cellspacing="0" cellpadding="0">
			<tr>
				<td valign="top" width="100%" height="1"><img src="<c:url value="/images/menu_topline.gif" />" width="100%" height="1"></td>
			</tr>
			<tr>
				<td valign="middle" align="center" height="3"><font color=#7f7f7f>&copy; Copyright 沣邦融资租赁(上海)有限公司</font></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</body>
</form>
</html>
