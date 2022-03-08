
var _jsvmCoreFunc_ie=function(){var jsre=_JSVM_Namespace.runtimeEnvironment;var Exception=_JSVM_Namespace.kernel.Exception;var defaultClassloader4IE=new function(){var cacheEnable=true;var classResourceBases=[];var libResources=[];var classHome=null;var libHome=null;var logs=null;var cache=new function(){var _memoryCache=new function(){var dict=new ActiveXObject("Scripting.Dictionary");this.get=function(name){if(!dict.Exists(name)){return null;}else{return dict.Item(name);}}
this.put=function(name,value){if(dict.Exists(name)){dict.Item(name)=value;}else{dict.Add(name,value);}}
this.remove=function(name){if(dict.Exists(name)){dict.Remove(name);}}}
var userdataEnable=true;this.setUserDataEnable=function(b){userdataEnable=b;}
this.getUserDataEnable=function(){return userdataEnable;}
var _userdataCache=new function(){var createUserData=function(){var elmt=document.createElement("meta");elmt.addBehavior("#default#userdata");document.getElementsByTagName("head")[0].appendChild(elmt);return elmt;}
var ude0=createUserData();var ude1=createUserData();var defaultExpires=jsre.config.getParameter("ExpireFlag");var udIsOk=true;if(defaultExpires==null){if(/ jsvmCookie_ExpireFlag=([^;]*)/.test(" "+document.cookie)){defaultExpires=RegExp.$1;}else{defaultExpires=String(new Date().getTime());document.cookie="jsvmCookie_ExpireFlag="+defaultExpires;}}
var encodeName=function(name){return "jsvm_cache_class_"+name.replace(/(\/)|(\\)|@|&|%|(\.)|,|(\")|'|:/gi, "_");}
var saveClass=function(name,value){if(!udIsOk){return;}
try{var udName=encodeName(name);ude0.load(udName);ude0.setAttribute("code",value);ude0.setAttribute("expires",defaultExpires);ude0.save(udName);}catch(ex){udIsOk=false;}}
var loadClass=function(name){if(!udIsOk){return null;}
try{var udName=encodeName(name);ude0.load(udName);return(ude0.getAttribute("expires")==defaultExpires)?ude0.getAttribute("code"):null;}catch(ex){udIsOk=false;return null;}}
var removeClass=function(name){if(!udIsOk){return;}
try{var udName=encodeName(name);ude0.load(udName);this.element.expires=0;ude0.save(udName);}catch(ex){udIsOk=false;return null;}}
var libUserDataName="jsvm_cache_libraryinfos";var libUserDataInited=false;var initLibUserData=function(){if(!libUserDataInited){ude1.load(libUserDataName);libUserDataInited=true;}}
var saveLib=function(name,value){if(!udIsOk){return;}
try{initLibUserData();var doc=ude1.XMLDocument;var root=doc.documentElement;var node=root.selectSingleNode("//LibItem[@name = \""+name+"\"]");if(node==null){node=doc.createNode(1,"LibItem","");root.appendChild(node);node.setAttribute("name",name);}
for(var att in value){node.setAttribute(att,value[att]);}
node.setAttribute("expires",defaultExpires);ude1.setAttribute("last_update_date",new Date().toString());ude1.save(libUserDataName);}catch(ex){udIsOk=false;}}
var loadLib=function(name){if(!udIsOk){return null;}
try{initLibUserData();var doc=ude1.XMLDocument;var root=doc.documentElement;var node=root.selectSingleNode("//LibItem[@name=\""+name+"\"]");var obj=null;if(node!=null&&node.getAttribute("expires")==defaultExpires){obj={};for(var i=0;i<node.attributes.length;i++){att=node.attributes.item(i);obj[att.nodeName]=att.nodeValue;}}
return obj;}catch(ex){udIsOk=false;return null;}}
var removeLib=function(name){if(!udIsOk){return;}
try{initLibUserData();var doc=ude1.XMLDocument;var root=doc.documentElement;var node=root.selectSingleNode("//LibItem[@name=\""+name+"\"]");if(node!=null){root.removeChild(node);ude1.save(libUserDataName);}}catch(ex){udIsOk=false;}}
var TaskItem=function(){this.type=0;this.name=null;this.content=null;this.state=0;}
var bufferQueue=new function(){var queue=new Array(0);var index=0;this.pop=function(){if(index>=queue.length){throw new Exception(0x002A,"ie.js/UserDataCache:BufferQueue is Empty.",null);}
return queue[index++];}
this.push=function(o){var l=queue.length;queue[l]=o;}
this.empty=function(){return(index>=queue.length);}}
var writeThread=new function(){var state=0;var runFlag=false;var delay=100;window._jsvmThread_B6E667B1462148E192598F129F0B211C=this;this.start=function(){runFlag=true;if(state==0){this.run();}}
this.stop=function(){runFlag=false;}
this.run=function(){if(!runFlag){state=0;return;}
state=1;if(!bufferQueue.empty()){var item=bufferQueue.pop();switch(item.type){case 0:saveClass(item.name,item.content);break;case 1:savePackage(item.name,item.content);break;case 2:saveLib(item.name,item.content);break;}}
state=2;if(runFlag){window.setTimeout("_jsvmThread_"+"B6E667B1462148E192598F129F0B211C.run()",delay);state=3;}else{state=0;}}
this.isRunning=function(){return(state>0);}}
this.get=function(type,name){switch(type){case 0:return loadClass(name);case 1:return loadPackage(name);case 2:return loadLib(name);default:return null;}}
this.put=function(type,name,value){var item=new TaskItem();item.type=type;item.name=name;item.content=value;bufferQueue.push(item);}
this.remove=function(type,name){switch(type){case 0:return removeClass(name);case 1:return removePackage(name);case 2:return removeLib(name);}}
writeThread.start();}
this.getClass=function(name){var code=_memoryCache.get("0"+name);if(code==null&&userdataEnable){code=_userdataCache.get(0,name);if(code!=null){_memoryCache.put("0"+name,code);}}
return code;}
this.putClass=function(name,code){_memoryCache.put("0"+name,code);if(userdataEnable){_userdataCache.put(0,name,code);}}
this.getPackage=function(name){var obj=_memoryCache.get("1"+name);if(obj==null&&userdataEnable){obj=_userdataCache.get(1,name);if(obj!=null){_memoryCache.put("1"+name,obj);}}
return obj;}
this.putPackage=function(name,obj){_memoryCache.put("1"+name,obj);if(userdataEnable){_userdataCache.put(1,name,obj);}}
this.getLib=function(name){var obj=_memoryCache.get("2"+name);if(obj==null&&userdataEnable){obj=_userdataCache.get(2,name);if(obj!=null){_memoryCache.put("2"+name,obj);}}
return obj;}
this.putLib=function(name,lib){_memoryCache.put("2"+name,lib);if(userdataEnable){_userdataCache.put(2,name,lib);}}}
var resourceLoader=new function(){var xmlHttp=null,xmlDom=null;try{xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");xmlDom=new ActiveXObject("Microsoft.XMLDOM");xmlDom.async=false;}catch(ex){throw new Exception(0x0020,"ie.js/Create ResourceLoader Error: Can't Create XmlHttp or XmlDom Object.",ex);}
this.loadTxtResource=function(src){xmlHttp.open("GET",src,false);try{xmlHttp.send(null);}catch(ex){throw new Exception(0x0021,"ie.js/ResourceLoader/loadTxtResource(String): Can't load Resource [src:"+src+"] {XmlHttp.send() Error:"+ex.getMessage().replace(/\r\n$/,"")+"}",ex);}
if(xmlHttp.status==200||xmlHttp.status==0){return xmlHttp.responseText;}
throw new Exception(0x0021,"ie.js/ResourceLoader/loadTxtResource(String): Can't load Resource [src:"+src+"] {HTTP-STATUS:"+xmlHttp.status+"}",null);}
this.loadXmlResource=function(src){if(xmlDom.load(src)){return xmlDom.documentElement.cloneNode(true);}
throw new Exception(0x0022,"ie.js/ResourceLoader/loadXmlResource(String): Can't load XML [src:"+src+"]",null);}}
var parseClassResourceFromXmlNode=function(parentName,node){var pName=(parentName==null)?"":(((parentName=="")?"":(parentName+"."))+node.getAttribute("name"));var cNodes=node.selectNodes("Class");for(var i=0;i<cNodes.length;i++){var cNode=cNodes.item(i);var className=(pName=="")?"":(pName+".")+cNode.getAttribute("name");var code=cNode.text;cache.putClass(className,code);}
var pNodes=node.selectNodes("Package");for(var i=0;i<pNodes.length;i++){var pNode=pNodes.item(i);parseClassResourceFromXmlNode(pName,pNode);}}
var loadLibFromXml=function(path){try{if(!(/^(\.|\\|\/|(\w){2,8}:)/.test(path))){path=libHome+"/"+path;}
var node=resourceLoader.loadXmlResource(path);if(node.nodeName=="DeployConfig"){var libNodes=node.selectNodes("//LibItem");for(var i=0;i<libNodes.length;i++){var libNode=libNodes.item(i);var name=libNode.getAttribute("name");var lastModified=libNode.getAttribute("lastModified");if(cacheEnable){var info=cache.getLib(name);if(info!=null&&info.lastModified>=lastModified){return;}}
var type=libNode.getAttribute("type");var src=libNode.getAttribute("src");if(type=="js"){loadScriptLib(src);}else{loadLibFromXml(src);}}}else{var lib={}
for(var i=0;i<node.attributes.length;i++){att=node.attributes.item(i);lib[att.nodeName]=att.nodeValue;}
if(cacheEnable){var info=cache.getLib(lib.name);if(info!=null&&info.lastModified==lib.lastModified){return;}}
parseClassResourceFromXmlNode(null,node);cache.putLib(lib.name,lib);}}catch(ex){throw new Exception(0x002D,"ie.js/Classloader:loadLibFromXml(String): failed. [path:"+path+"]",ex);}}
var loadLibFromObject=function(obj){try{var lib=obj.manifest;if(cacheEnable){var info=cache.getLib(lib.name);if(info!=null&&info.lastModified==lib.lastModified){return;}}
var entity=obj.entity;for(var c in entity){cache.putClass(c,entity[c]);}
cache.putLib(lib.name,lib);}catch(ex){throw new Exception(0x002E,"ie.js/Classloader:loadLibFromObject(Object): fail. [obj:"+obj+"]",ex);}}
var loadScriptLib=function(src){document.write("<script src=\""+((/^(\.|\\|\/|(\w){2,8}:)/.test(src))?src:(libHome+"/"+src))+"\"></script>");}
this.loadClassSource=function(name){var err;var classDirs=[classHome].concat(classResourceBases)
for(var i=0;i<classDirs.length;i++){var path=classDirs[i]+"/"+name.replace(/\./gi,"/")+".jsc";try{var code=resourceLoader.loadTxtResource(path);return code;}catch(ex){err=ex;if((ex instanceof Exception)&&(ex.number & 0x0000FFFF)==0x0021){continue;}}}
throw new Exception(0x0024,"ie.js/Classloader/loadClassSource(String): Can't load ["+name+"] Class Resource.",err);}
this.initialize=function(){for(var i=0;i<libResources.length;i++){this.loadLib(libResources[i]);}}
this.loadClass=function(name){try{var code=cache.getClass(name);if(null!=code){return code;}
code=this.loadClassSource(name);if(cacheEnable&&code!=null){cache.putClass(name,code);}
return code;}catch(ex){throw new Exception(0x002B,"ie.js/Classloader.loadClass(String): Class: '"+name+"' NotFound.",ex);}}
this.loadPackage=function(name){throw new Exception(0x001B,"ie.js/Classloader.loadPackage(String) not implemented.");}
this.loadLib=function(arg){try{(typeof(arg)=="string")?(/\.[j|J][s|S]$/.test(arg)?loadScriptLib(arg):loadLibFromXml(arg)):loadLibFromObject(arg);}catch(ex){logs.log(new Exception(0x002C,"ie.js/Classloader.loadLib(arg): fail [arg:"+arg+"]",ex));}}
this.setCacheEnable=function(b){cacheEnable=(b==true);cache.setUserDataEnable(cacheEnable);}
this.getCacheEnable=function(){return cacheEnable;}
this.setClasspath=function(cp){if(cp!=null&&cp!=""){var cps=cp.replace(/;$/,"").split(";")
for(var i=0;i<cps.length;i++){if(/\.(\w)+$/.test(cps[i].toLowerCase())){var l=libResources.length;libResources[l++]=cps[i];}else{var l=classResourceBases.length;classResourceBases[l++]=cps[i].replace(/\/$/,"");}}}}
this.setClassHome=function(ch){classHome=ch;}
this.getClassHome=function(){return classHome;}
this.setLibHome=function(lh){libHome=lh;}
this.getLibHome=function(){return libHome;}
this.setLogs=function(lg){logs=lg;}}
defaultClassloader4IE.setClassHome(((tmp=jsre.config.getParameter("class_home"))==null)?(jsre.jsvmHome+"/classes"):tmp.replace("${jsvmHome}",jsre.jsvmHome));defaultClassloader4IE.setLibHome(((tmp=jsre.config.getParameter("lib_home"))==null)?(jsre.jsvmHome+"/lib"):tmp.replace("${jsvmHome}",jsre.jsvmHome));defaultClassloader4IE.setClasspath(jsre.classpath.replace("${jsvmHome}",jsre.jsvmHome));defaultClassloader4IE.setLogs(jsre.JSVM.logs);defaultClassloader4IE.setCacheEnable(!jsre.debug);defaultClassloader4IE.initialize();jsre.JSVM.setClassloader(defaultClassloader4IE);};try{var jsre=_JSVM_Namespace.runtimeEnvironment;if(jsre.state==1){_jsvmCoreFunc_ie();jsre.setResource("$code{ie}",_jsvmCoreFunc_ie);jsre.log("JSVM_Namespace.rtenv: "+"Load core function 'ie' succ.");}}catch(ex){jsre.state=0;jsre.log("JSVM_Namespace.rtenv: "+"Load core function 'ie' fail.");}finally{jsre=_jsvmCoreFunc_ie=void(0);}
