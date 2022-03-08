<%@ page contentType = "text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<html>
<head>
<title>依赖关系</title>
<link href="<c:url value='/css/xtree.css'/>" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<c:url value='/jquery/organ/xtree.js'/>"></script>
<script type="text/javascript" src="<c:url value='/jquery/organ/xmlextras.js'/>"></script>
<script type="text/javascript" src="<c:url value='/jquery/organ/xloadtree.js'/>"></script>
<script type="text/javascript" src="<c:url value='/jquery/organ/jsvm2/jsre.js'/>"></script>
</head>

<body background = "<c:url value='/images/watermark-pattern.gif'/>">

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
	webFXTreeConfig.rootIcon		= "<c:url value='/images/xtree/purple.png'/>";
	webFXTreeConfig.openRootIcon	= "<c:url value='/images/xtree/purple.png'/>";
	webFXTreeConfig.folderIcon		= "<c:url value='/images/xtree/down.bmp'/>";
	webFXTreeConfig.openFolderIcon	= "<c:url value='/images/xtree/down.bmp'/>";
	webFXTreeConfig.fileIcon		= "<c:url value='/images/xtree/down.bmp'/>";
	webFXTreeConfig.lMinusIcon		= "<c:url value='/images/xtree/Lminus.png'/>";
	webFXTreeConfig.lPlusIcon		= "<c:url value='/images/xtree/Lplus.png'/>";
	webFXTreeConfig.tMinusIcon		= "<c:url value='/images/xtree/Tminus.png'/>";
	webFXTreeConfig.tPlusIcon		= "<c:url value='/images/xtree/Tplus.png'/>";
	webFXTreeConfig.iIcon			= "<c:url value='/images/xtree/I.png'/>";
	webFXTreeConfig.lIcon			= "<c:url value='/images/xtree/L.png'/>";
	webFXTreeConfig.tIcon			= "<c:url value='/images/xtree/T.png'/>";


	var requestLink = "<c:url value='/getGeneralTreeSource.op'> <c:param name='taskId' value='${taskId}'/> <c:param name='jobId' value='${jobId}'/> <c:param name='taskName' value='${taskName}'/> </c:url>";

	var tree = new WebFXLoadTree('(<c:out value='${taskId}'/><c:out value='${taskName}'/>)  <c:out value='${jobId}'/>', requestLink,"");
	document.write(tree);
	document.write("&nbsp;");
	
	

  //-->
</script>
</body>
</html>
