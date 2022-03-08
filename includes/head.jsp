<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript" src="<c:url value='/jquery/jquery-1.8.0.min.js'/>"></script>
<link rel="stylesheet" type="text/css" href="<c:url value='/jquery/themes/default/easyui.css'/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value='/jquery/themes/icon.css'/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value='/jquery/ext/portal.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/default.css'/>">	
<script type="text/javascript" src="<c:url value='/jquery/jquery.validate.js'/>"></script>
<script type="text/javascript" src="<c:url value='/jquery/jquery.json-2.4.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/jquery/jquery.easyui.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/jquery/ext/jquery.portal.js'/>"></script>
<script type="text/javascript" src="<c:url value='/jquery/ext/jquery.cookie.js'/>"></script>
<script type="text/javascript" src="<c:url value='/jquery/locale/easyui-lang-zh_CN.js'/>"></script>
<script type="text/javascript">
    
    document.onkeydown = function (e) {     
	   var ev = window.event || e;       
	   var code = ev.keyCode || ev.which;        
	   if(code==8){
	     if ((window.event.srcElement.readOnly!=null&&window.event.srcElement.readOnly==true)||window.event.srcElement.readOnly==null) {                 
		   ev.keyCode ? ev.keyCode = 0 : ev.which = 0;         
		   if ( e && e.preventDefault ) 
			  e.preventDefault();             
		 }        
	   }
     };
     Date.prototype.Format = function(fmt)   
              { //author: meizz    
                var o = {   
                         "M+" : this.getMonth()+1,                 //æä»½    
                         "d+" : this.getDate(),                    //æ¥    
                         "H+" : this.getHours(),                   //å°æ¶    
                         "m+" : this.getMinutes(),                 //å    
                         "s+" : this.getSeconds(),                 //ç§    
                         "q+" : Math.floor((this.getMonth()+3)/3), //å­£åº¦    
                         "S"  : this.getMilliseconds()             //æ¯«ç§    
                       };   
               if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
                 for (var k in o)
                       if (new RegExp("(" + k + ")").test(fmt)) 
                          fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
                  return fmt;
        };
     String.prototype.replaceAll = function(reallyDo, replaceWith, ignoreCase) { 
          if (!RegExp.prototype.isPrototypeOf(reallyDo)) { 
              return this.replace(new RegExp(reallyDo, (ignoreCase ? "gi": "g")), replaceWith); 
          } else { 
              return this.replace(reallyDo, replaceWith); 
          } 
     }; 
     function createMask() {
   		document.body.appendChild(document.createElement("<div id='shield' style='visibility:hidden;position:absolute;top:0px;left:0px;text-align:center;vertical-align:middle;background-color:#DDD;z-index:10001;filter:alpha(opacity=75);' + shieldStyle + '></div>"));
   		document.getElementById("shield").innerHTML = "<iframe id='shieldIframe' style='width:100%;height:100%;border:none;filter:alpha(opacity=0);'></iframe>";
   		document.body.appendChild(document.createElement("<div id='loadcontent' style='visibility:hidden;position:absolute;top:0px;left:0px;background-color:#E5E5E5;text-align:center;vertical-align:middle;z-index=10002'></div>"));
   	    document.getElementById('loadcontent').innerHTML = "<img id='loadimg' onclick=''></img><br></br><div id='loadtext' >Processing, please wait ...</div>";
   		
   		var docHeight, docWidth;
   		with(document.body) {
   			docHeight = scrollHeight < clientHeight ? clientHeight - 4 : scrollHeight;
   			docWidth = scrollWidth < clientWidth ? clientWidth: scrollWidth;
   		} 
   		document.getElementById("loadimg").src = "<c:url value ='/images/dialog-loading.gif' />";
   		document.getElementById("shield").style.width = (docWidth) + "px";		
   		document.getElementById("shield").style.height = (docHeight) + "px";
   		document.getElementById('loadcontent').style.left = (document.body.clientWidth - document.getElementById('loadcontent').clientWidth) / 2 + "px";
   		document.getElementById('loadcontent').style.top = (document.body.clientHeight - document.getElementById('loadcontent').clientHeight) / 2 + "px";
   		document.getElementById("shield").style.visibility = "";
   		document.getElementById("loadcontent").style.visibility = "";
   		//document.getElementById("shield").focus();
         } 
       function removeMaskStub(winObj) {
       	try {
       		with (((winObj == undefined) ? window : winObj).document) {
       			
       			getElementById("shield").removeNode(true);
       			getElementById("loadcontent").removeNode(true);
       		}
       	} catch (e) {}
       } 
       
       var easyuiPanelOnMove = function(left, top) { 
       if($(this).attr("id")!=null&&$(this).attr("id")!=undefined&&$(this).attr("id")!="undefined"&&$(this).attr("id")!=""){
        var parentObj = $(this).panel('panel').parent();  
        if (left < 0) {
            $(this).window('move', {
                left : 1
            });
        }
        if (top < 0) {
            $(this).window('move', {
                top : 1
            });
        }
        var width = $(this).panel('options').width;
        var height = $(this).panel('options').height;
        var right = left + width;
        var buttom = top + height;
        var parentWidth = parentObj.width();
        var parentHeight = parentObj.height();
        if(parentObj.css("overflow")=="hidden"){
            if(left > parentWidth-width){
                $(this).window('move', {
                    "left":parentWidth-width
                });
        }
            if(top > parentHeight-$(this).parent().height()){
                $(this).window('move', {
                    "top":parentHeight-$(this).parent().height()
                });
        }
        }
      }
    };
    $.fn.panel.defaults.onMove = easyuiPanelOnMove;
    $.fn.window.defaults.onMove = easyuiPanelOnMove;
    $.fn.dialog.defaults.onMove = easyuiPanelOnMove;
         
 </script>