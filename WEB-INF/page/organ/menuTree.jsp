<%@ page contentType = "text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<html>
<head>
<title>菜单</title>
<link href="<c:url value='/css/xtree.css'/>" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<c:url value='/jquery/organ/xtree.js'/>"></script>
<script type="text/javascript" src="<c:url value='/jquery/organ/xmlextras.js'/>"></script>
<script type="text/javascript" src="<c:url value='/jquery/organ/xloadtree.js'/>"></script>
<script type="text/javascript" src="<c:url value='/jquery/organ/jsvm2/jsre.js'/>"></script>
<style type="text/css">
body {
background:	aleiceblue;
color:		aleiceblue;
}
</style>
<script type="text/javascript">
 function onclickMenu(str){ 
	document.organForm.action=str;
	document.organForm.target="main";
	document.organForm.submit();

    //window.parent["main"].location.href = str;
 }
</script>
</head>
<body background = "<c:url value='/images/watermark-pattern.gif'/>">
<form name="organForm" method="get">
<script type="text/javascript">
<!--

    // Config Object properties
	webFXTreeConfig.defaultText= 'Tree Item';
	webFXTreeConfig.defaultAction='javascript:void(0);';
	webFXTreeConfig.defaultBehavior='classic';
	webFXTreeConfig.usePersistence=false;
	webFXTreeConfig.loadingText = "Loading...";
	webFXTreeConfig.loadErrorTextTemplate = " loading '%1%'";
	webFXTreeConfig.emptyErrorTextTemplate = " '%1%' does not contain any tree items";
	
	// related images
	webFXTreeConfig.blankIcon       = "<c:url value='/images/xtree/blank.png'/>";
	webFXTreeConfig.rootIcon		= "<c:url value='/images/xtree/folder.png'/>";
	webFXTreeConfig.openRootIcon	= "<c:url value='/images/xtree/openfolder.png'/>";
	webFXTreeConfig.folderIcon		= "<c:url value='/images/xtree/folder.png'/>";
	webFXTreeConfig.openFolderIcon	= "<c:url value='/images/xtree/openfolder.png'/>";
	webFXTreeConfig.fileIcon		= "<c:url value='/images/xtree/file.png'/>";
	webFXTreeConfig.lMinusIcon		= "<c:url value='/images/xtree/Lminus.png'/>";
	webFXTreeConfig.lPlusIcon		= "<c:url value='/images/xtree/Lplus.png'/>";
	webFXTreeConfig.tMinusIcon		= "<c:url value='/images/xtree/Tminus.png'/>";
	webFXTreeConfig.tPlusIcon		= "<c:url value='/images/xtree/Tplus.png'/>";
	webFXTreeConfig.iIcon			= "<c:url value='/images/xtree/I.png'/>";
	webFXTreeConfig.lIcon			= "<c:url value='/images/xtree/L.png'/>";
	webFXTreeConfig.tIcon			= "<c:url value='/images/xtree/T.png'/>";

	var requestLink = "<c:url value='/menuTreeSource.op'> <c:param name='MENUCODE' value='${map.MENUCODE}'/> </c:url>";

	var tree = new WebFXLoadTree(' <c:out value='${map.MENUNAME}'/>', requestLink,"");
	document.write(tree);

  //-->
</script>
</form>
</body>
</html>
