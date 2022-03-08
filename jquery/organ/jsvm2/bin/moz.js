
var _jsvmCoreFunc_moz=function(){var jsre=_JSVM_Namespace.runtimeEnvironment;var Exception=_JSVM_Namespace.kernel.Exception;var defaultClassloader4Moz=new function(){var cacheEnable=true;var classResourceBases=[];var libResources=[];var classHome=null;var libHome=null;var logs=null;var cache=new function(){var dict={};this.getClass=function(name){return dict[name];}
this.putClass=function(name,code){dict[name]=code;}}
var resourceLoader=new function(){var xmlHttp=null,xmlDom=null;try{xmlHttp=new XMLHttpRequest();xmlDom=document.implementation.createDocument("","",null);xmlDom.async=false;}catch(ex){throw new Exception(0x0020,"moz.js/Create ResourceLoader Error: Can't Create XmlHttp or XmlDom Object.",ex);}
this.loadTxtResource=function(src){xmlHttp.open("GET",src,false);try{xmlHttp.send(null);}catch(ex){throw new Exception(0x0021,"moz.js/ResourceLoader/loadTxtResource(String): Can't load Resource [src:"+src+"] {XmlHttp.send() Error:"+ex.message+"}",ex);}
if(xmlHttp.status==200||xmlHttp.status==0){return xmlHttp.responseText;}
throw new Exception(0x0021,"moz.js/ResourceLoader/loadTxtResource(String): Can't load Resource [src:"+src+"] {HTTP-STATUS:"+xmlHttp.status+"}",null);}
this.loadXmlResource=function(src){if(xmlDom.load(src)){return xmlDom.documentElement.cloneNode(true);}
throw new Exception(0x0022,"moz.js/ResourceLoader/loadXmlResource(String): Can't load XML [src:"+src+"]",null);}}
var parseClassResourceFromXmlNode=function(parentName,node){var pName=(parentName==null)?"":(((parentName=="")?"":(parentName+"."))+node.getAttribute("name"));var cNodes=node.childNodes;var l=cNodes.length
for(var i=0;i<l;i++){var cNode=cNodes[i];if(cNode.tagName=="Class"){var className=(pName=="")?"":(pName+".")+cNode.getAttribute("name");if(cNode.firstChild){var code=cNode.firstChild.nodeValue;cache.putClass(className,code);}else if(cNode.tagName=="Package"){parseClassResourceFromXmlNode(pName,cNode);}}}}
var loadLibFromXml=function(path){try{if(!(/^(\.|\\|\/|(\w){2,8}:)/.test(path))){path=libHome+"/"+path;}
var node=resourceLoader.loadXmlResource(path);if(node.tagName=="DeployConfig"){var libNodes=node.childNodes;var l=libNodes.length;for(var i=0;i<l;i++){var libNode=libNodes[i];if(libNode.tagName!="LibItem"){continue;}
var type=libNode.getAttribute("type");var src=libNode.getAttribute("src");if(type=="js"){loadScriptLib(src);}else{loadLibFromXml(src);}}}else{parseClassResourceFromXmlNode(null,node);}}catch(ex){throw new Exception(0x002D,"moz.js/Classloader:loadLibFromXml(String): failed. [path:"+path+"]",ex);}}
var loadLibFromObject=function(obj){try{var entity=obj.entity;for(var c in entity){cache.putClass(c,entity[c]);}}catch(ex){throw new Exception(0x002E,"moz.js/Classloader:loadLibFromObject(Object): fail. [obj:"+obj+"]",ex);}}
var loadScriptLib=function(src){document.write("<script src=\""+((/^(\.|\\|\/|(\w){2,8}:)/.test(src))?src:(libHome+"/"+src))+"\"></script>");}
this.loadClassSource=function(name){var err;var classDirs=[classHome].concat(classResourceBases)
for(var i=0;i<classDirs.length;i++){var path=classDirs[i]+"/"+name.replace(/\./gi,"/")+".jsc";try{var code=resourceLoader.loadTxtResource(path);return code;}catch(ex){err=ex;if((ex instanceof Exception)&&(ex.number & 0x0000FFFF)==0x0021){continue;}}}
throw new Exception(0x0024,"moz.js/Classloader/loadClassSource(String): Can't load ["+name+"] Class Resource.",err);}
this.initialize=function(){for(var i=0;i<libResources.length;i++){this.loadLib(libResources[i]);}}
this.loadClass=function(name){try{var code=cache.getClass(name);if(null!=code){return code;}
code=this.loadClassSource(name);if(cacheEnable&&code!=null){cache.putClass(name,code);}
return code;}catch(ex){throw new Exception(0x002B,"moz.js/Classloader.loadClass(String): Class: '"+name+"' NotFound.",ex);}}
this.loadPackage=function(name){throw new Exception(0x001B,"moz.js/Classloader.loadPackage(String) not implemented.");}
this.loadLib=function(arg){try{(typeof(arg)=="string")?(/\.[j|J][s|S]$/.test(arg)?loadScriptLib(arg):loadLibFromXml(arg)):loadLibFromObject(arg);}catch(ex){logs.log(new Exception(0x002C,"moz.js/Classloader.loadLib(arg): fail [arg:"+arg+"]",ex));}}
this.setCacheEnable=function(b){cacheEnable=(b==true);}
this.getCacheEnable=function(){return cacheEnable;}
this.setClasspath=function(cp){if(cp!=null&&cp!=""){var cps=cp.replace(/;$/,"").split(";")
for(var i=0;i<cps.length;i++){if(/\.(\w)+$/.test(cps[i].toLowerCase())){var l=libResources.length;libResources[l++]=cps[i];}else{var l=classResourceBases.length;classResourceBases[l++]=cps[i].replace(/\/$/,"");}}}}
this.setClassHome=function(ch){classHome=ch;}
this.getClassHome=function(){return classHome;}
this.setLibHome=function(lh){libHome=lh;}
this.getLibHome=function(){return libHome;}
this.setLogs=function(lg){logs=lg;}}
defaultClassloader4Moz.setClassHome(((tmp=jsre.config.getParameter("class_home"))==null)?(jsre.jsvmHome+"/classes"):tmp.replace("${jsvmHome}",jsre.jsvmHome));defaultClassloader4Moz.setLibHome(((tmp=jsre.config.getParameter("lib_home"))==null)?(jsre.jsvmHome+"/lib"):tmp.replace("${jsvmHome}",jsre.jsvmHome));defaultClassloader4Moz.setClasspath(jsre.classpath.replace("${jsvmHome}",jsre.jsvmHome));defaultClassloader4Moz.setLogs(jsre.JSVM.logs);defaultClassloader4Moz.setCacheEnable(!jsre.debug);defaultClassloader4Moz.initialize();jsre.JSVM.setClassloader(defaultClassloader4Moz);};try{var jsre=_JSVM_Namespace.runtimeEnvironment;if(jsre.state==1){_jsvmCoreFunc_moz();jsre.setResource("$code{moz}",_jsvmCoreFunc_moz);jsre.log("JSVM_Namespace.rtenv: "+"Load core function 'moz' succ.");}}catch(ex){jsre.state=0;jsre.log("JSVM_Namespace.rtenv: "+"Load core function 'moz' fail.");}finally{jsre=_jsvmCoreFunc_moz=void(0);}
