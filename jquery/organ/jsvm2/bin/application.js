
var _jsvmCoreFunc_application=function(){var jsre=_JSVM_Namespace.runtimeEnvironment;_import("js.lang.System");_import("js.util.HashMap");_import("js.dom.Window");window.application=new function(){this.title="Web Application";this.main="url("+js.dom.Window.getCommonWebURL()+")";this.moduleUrl="off";this.mainFrame=null;this.state=0;var shareProxyClassloader=System.isIeBrowser()?new function(){var classloader=System.getClassloader();this.loadClass=function(name){try{return classloader.loadClass(name);}catch(ex){System.out.print("Application throw exceptions: ");ex.printStackTrace();return null;}}
this.loadPackage=function(name){try{return classloader.loadPackage(name);}catch(ex){ex.printStackTrace();return null;}}}:System.getClassloader();this.getShareClassloader=function(){return shareProxyClassloader;}
var _window=window;var _document=_window.document;this.getWindow=function(){return _window;}
this.getDocument=function(){return _document;}
this.live=function(){return(!_window.closed);}
var ctxPath=null;this.getContextPath=function(){return(ctxPath!=null)?ctxPath:(ctxPath=_document.URL.replace(/[^\\\/]*$/,""));}
this.getParameter=function(name){var re=new RegExp("([\?]|&)("+name+"=)([^&]*)");return re.test(_window.location.search)?unescape(RegExp.$3):null;}
var properties=new js.util.HashMap();this.setProperty=function(name,obj){properties.put(name,obj);}
this.getProperty=function(name){return properties.get(name);}
this.setMain=function(main){this.main=main;}
this.showMainForm=function(url){this.mainFrame.location.href=url;}
this.moduleManager=new function(){var webforms=new js.util.HashMap();this.add=function(webModule){try{webforms.put(webModule.uniqueID,webModule);}catch(ex){}}
this.remove=function(webModule){try{webforms.remove(webModule.uniqueID);}catch(ex){}}
this.closeAll=function(){var iterator=webforms.elements();while(iterator.hasNext()){try{iterator.next().close();}catch(ex){}}}
this.autoClearThread=new function(){var threadHandle=0;var uniqueID="_$jsvm_application_thread_"+(new Date()).getTime();eval("_window."+uniqueID+"=this;");this.delay=1000;this.start=function(){threadHandle=_window.setInterval("window."+uniqueID+".run();",this.delay);}
this.stop=function(){if(threadHandle!=null){_window.clearInterval(threadHandle);}}
this.run=function(){var iterator=webforms.keys();while(iterator.hasNext()){var key=iterator.next();var obj=webforms.get(key);try{obj.live();}catch(ex){webforms.remove(key);}}}}}
this.run=function(){this.moduleManager.autoClearThread.start();if(/^class\((.*)\)$/.test(this.main)){var mainClass=RegExp.$1;try{Class.forName(mainClass).main();}catch(ex){System.out.println("Application Run Main-Class Error!");ex.printStackTrace();}}
this.state=2;}
this.exit=function(){if(typeof(this.onExit)=="function"&&mode!=1&&this.onExit()==false){return;}
this.state=3;this.moduleManager.closeAll();this.moduleManager.autoClearThread.stop();_window.onbeforeunload=null;this.state=4;System.exit();}
this.initialize=function(){var application=this;this.main=jsre.config.getParameter("main");this.moduleUrl=((tmpvar=jsre.config.getParameter("ModuleUrl"))=="on")?tmpvar:"off";if(this.moduleUrl=="on"){application.setMain((tmpvar=application.getParameter("ModuleURL"))?("url("+tmpvar+")"):application.main);}
_document.clear();_document.write("<frameset Rows=\"*\"><frame frameborder=2"+" Id=\"Mainframe\" Name=\"Mainframe\" /></frameset>");_window.onload=function(){application.mainFrame=window.Mainframe;if(/^url\((.*)\)$/.test(application.main)){application.showMainForm(RegExp.$1);}}
_window.onunload=function(){if(application.state!=4){application.moduleManager.closeAll();}
application.showMainForm("about:blank");}
_window.onbeforeunload=function(){return "The application will exit, are you sure? ";}
_window.onerror=function(msg,url,line){System.out.printError("Runtime Error {"+url+"(line: "+line+") "+msg+" }");return false;}
_document.onkeydown=function(evt){try{evt=evt||event;if((evt.ctrlKey==true&&",17,66,70,78,80,".indexOf(","+evt.keyCode+",")!=-1)||evt.keyCode==116){evt.keyCode=0;evt.returnValue=false;}}catch(e){}}
this.state=1;}}
application.initialize();application.run();}
try{var jsre=_JSVM_Namespace.runtimeEnvironment;if(jsre.state==1){_jsvmCoreFunc_application();jsre.setResource("$code{application}",_jsvmCoreFunc_application);jsre.log("JSVM_Namespace.rtenv: "+"Load core function 'application' succ.");}}catch(ex){jsre.state=0;jsre.log("JSVM_Namespace.rtenv: "+"Load core function 'application' fail.");}finally{jsre=_jsvmCoreFunc_application=void(0);}
