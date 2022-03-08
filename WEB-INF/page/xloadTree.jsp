<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<title>菜单</title>
<script type="text/javascript" src="<c:url value='/js/xtree.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/xmlextras.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/xloadtree.js'/>"></script>
<link type="text/css" rel="stylesheet" href="<c:url value='/css/xtree.css'/>" />
<style type="text/css">
body {
background:	aliceblue;
color:		aliceblue;
}
</style>
<script type="text/javascript">
 function onclickMenu(str){ 
   window.parent["main"].location.href = "<c:out value='${path}' />"+str;
 }
</script>
</head>
<body>
<script type="text/javascript">
 

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

var tree =new WebFXLoadTree("菜单", "<c:url value='/js/xloadTree.xml'/>");
//tree.setBehavior("classic");
document.write(tree);
</script>
</body>
</html>
