<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib  prefix="c" uri="http://java.sun.com/jstl/core"%>
<html>
<head>
<title>系统登录</title>
<style type="text/css">
	html,body{
		border: 0px;
		margin: 0px;
		height: 100%;
	}
	#frmTable td{
		line-height: 35px;
	}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="<c:url value='/css/style.css' />" type="text/css">
<script language="JavaScript" type="text/JavaScript">
      window.attachEvent("onload",_document_onload);
    function _document_onload() {
    	document.loginForm.j_username.focus();
    } 
    function Button_submit_onClick(self) {
        if (document.loginForm.j_username.value == "") {
			alert("请输入您的登录用户名！");
			document.loginForm.j_username.focus();
			return false;
		}
		if (document.loginForm.j_password.value == "") {
			alert("请输入您的登录密码。");
			document.loginForm.j_password.focus();
			return false;
		}
		
		document.loginForm.flag.value="login";
		document.loginForm.action="<c:url value='/login.op'/>";
		document.loginForm.submit();
    }
        
    function Button_reset_onClick(self) {       
        document.loginForm.j_username.value = "";
        document.loginForm.j_password.value = "";
    }

  	function loginMouserdown(){
  		document.getElementById("loginImg").src="./images/loginpage/login2.gif";
  	}
  	function loginMouseover(){
  		document.getElementById("loginImg").src="./images/loginpage/login1.gif";
  	}
  	function loginMoserout(){
  		document.getElementById("loginImg").src="./images/loginpage/login.gif";
  	}
  	
  	function resetMouserdown(){
  		document.getElementById("resetImg").src="./images/loginpage/reset2.gif";
  	}
  	function resetMouseover(){
  		document.getElementById("resetImg").src="./images/loginpage/reset1.gif";
  	}
  	function resetMoserout(){
  		document.getElementById("resetImg").src="./images/loginpage/reset.gif";
  	}
    function check_key(self){
    	if (event.keyCode==13){
     		Button_submit_onClick(self);
     	}
       	}
    
</script>
</head>
<body>
<form action=""  method="POST"  name="loginForm" >
<input name="flag" value="" type="hidden">
<div style="height:100%;width:100%;overflow:hidden;">
	<div style="height:80px; background: url(./images/loginpage/2.gif);"></div>
	<div style="background: url(./images/loginpage/1.gif);" style="height:646px;">
		<div style="margin:0px auto;margin-left: 95px;width:990px;height:646px;">
			<table cellpadding="0" cellspacing="0">
				<tr>
					<td colspan="3"><img src="./images/loginpage/6_01.gif"></img></td>
				</tr>
				<tr>
					<td><img src="./images/loginpage/6_02.gif"></img></td>
					<td style="background:url(./images/loginpage/6_03.gif);vertical-align:top;">
						<div style="position:relative;top:30px;left:30px;color:white;font-family:黑体;letter-spacing:50px;font-size:20px">
						</div>
						<div style="width:501px;position:relative;top:46px;left:35px;">
			<table>
			<tr>
			<td style="height: 100%; width:280px; ">
                  <table>
                    <tr>
                    <td>
                    <table cellpadding="0" cellspacing="0" id="frmTable" border="0">                    
                      <br>
                      <br>
                      <br>
                    <tr>					
                        <td height="50px"><label for="username" style="font-size:15px;font-weight:590;font-style:normal;">用&nbsp;户&nbsp;名：</label></td>
                        <td width="100%">&nbsp;<input type='text' name='j_username'  maxLength="20" style="width: 130px;height:22px;"  onkeyup="check_key(this);" /></td>
                    </tr>
                    										
                    <tr>
                        <td height="50px"><label for="username" style="font-size:15px;font-weight:590;font-style:normal;">密&nbsp;&nbsp;&nbsp;&nbsp;码：</label></td>
                        <td width="100%">&nbsp;<input type='password' name='j_password' maxLength="20" style="width: 130px;height:22px;" onkeyup="check_key(this);"></td>
                    </tr>	
                    <tr>
                    <td height="50px" colspan="2" style="line-height: 200px;">
                    	&nbsp;&nbsp;&nbsp;&nbsp;<img id="loginImg" src="./images/loginpage/login.gif" type="submit" onclick="Button_submit_onClick(this);"  style="cursor: hand" onmousedown="loginMouserdown()"  onmousemove="loginMouseover()" onmouseout="loginMoserout()"></img>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    	<img id="resetImg" src="./images/loginpage/reset.gif" onclick="Button_reset_onClick(this);" style="cursor: hand" onmousedown="resetMouserdown()"  onmousemove="resetMouseover()" onmouseout="resetMoserout()"></img>
                    </td>
                     </tr>	
                     <tr>
                       <td width="100%" colspan="3"><div style="color:red;font-family:黑体;font-size:12px"><c:out value="${message}"/></div></td>
                    </tr>				
                 </table>
                 </td>
                 
                  </tr>
                  </table>
				</td>
				<td style="height: 134px; padding-top: 0px; vertical-align: top; width: 160px; ">
				 <div id="infoDiv" style="height: 78px; vertical-align: text-top; line-height: 20px; " align="left"></div>	
				</td>
			</tr>
				</table>
						</div>
					</td>
					<td><img src="./images/loginpage/6_04.gif"></img></td>
				</tr>
				<tr>
					<td colspan="3"><img src="./images/loginpage/6_05.gif"></img></td>
				</tr>
			</table>
		</div>
	</div>
	<div style="height:170px;background: url(./images/loginpage/3.gif);"></div>
</div>
</form>
</body>
</html>