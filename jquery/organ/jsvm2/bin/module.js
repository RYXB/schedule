
var _jsvmCoreFunc_module=function(){var jsre=_JSVM_Namespace.runtimeEnvironment;var Exception=_JSVM_Namespace.kernel.Exception;var shareJsre=jsre.getParent();while(shareJsre!=null){if(shareJsre.mode=="application"){window.application=shareJsre.window.application;break;}
shareJsre=shareJsre.getParent();}
if(window.application==null){throw new Exception(0x0061,"Module must run under the application!");}
jsre.JSVM.setClassloader(new function(){var shareContainer=application.getShareClassloader();this.loadClass=function(name){var exp=null;try{var cls=shareContainer.loadClass(name);if(cls!=null){return cls;}}catch(ex){exp=ex;}
throw new Exception(0x002B,"module.js/ProxyClassloader.loadClass():"+" Class Not Found.",exp);}
this.loadPackage=function(name){return getClassloader().loadPackage(name);}
this.loadLib=function(obj){return shareContainer.loadLib(obj);}});jsre.JSVM.setContainer(new function(){var selfContainer=jsre.JSVM.getContainer();var shareContainer=shareJsre.JSVM.getContainer();this.putClass=function(name,entity){selfContainer.putClass(name,entity);}
this.getClass=function(name){return selfContainer.getClass(name);}
this.putClassCode=function(name,code){shareContainer.putClassCode(name,code);}
this.getClassCode=function(name){return shareContainer.getClassCode(name);}});jsre.JSVM.setCompiler(new function(){var compiler=shareJsre.JSVM.getCompiler();this.compile=function(code){try{return compiler.compile(code);}catch(ex){throw new Exception(0x002D,"module.js/ProxyCompiler.compile():"+" maybe share-jsre had destroyed.",ex);}}});jsre.JSVM.setConsole(new function(){var appConsole=shareJsre.JSVM.console;this.output=function(s){appConsole.output(s);}
this.input=function(){return appConsole.input();}});window.web=new function(){var _window=window;var _document=_window.document;var _application=null;this.state=0;this.uniqueID="_$jsvm_webmodule_"+(new Date()).getTime();this.getWindow=function(){return _window;}
this.getDocument=function(){return _document;}
this.getApplication=function(){return _application;}
this.live=function(){return(!_window.closed);}
this.close=function(){_window.close();}
this.initialize=function(){_application=window.application;var webModule=this;if(_application!=null){try{_application.moduleManager.add(this);}catch(ex){}}
_window.onload=function(){if(_window.init!=null){_window.init();}}
var destroy=_window.onunload;_window.onunload=function(){if(_application!=null){try{_application.moduleManager.remove(webModule);}catch(ex){}}
if(_window.destroy!=null){_window.destroy();}}
window.setInterval("try{application.live();}"+"catch(e){window.close();}",250);var dockeydown=_document.onkeydown;_document.onkeydown=function(evt){try{evt=evt||event;if((evt.ctrlKey&&",17,66,70,78,80,".indexOf(","+evt.keyCode+",")!=-1)||evt.keyCode==116){evt.keyCode=0;evt.returnValue=false;return;}}catch(e){}
if(dockeydown!=null){dockeydown(evt);}}
this.state=1;}}
web.initialize();}
try{var jsre=_JSVM_Namespace.runtimeEnvironment;if(jsre.state==1){_jsvmCoreFunc_module();jsre.setResource("$code{module}",_jsvmCoreFunc_module);jsre.log("JSVM_Namespace.rtenv: "+"Load core function 'module' succ.");}}catch(ex){jsre.state=0;jsre.log("JSVM_Namespace.rtenv: "+"Load core function 'module' fail.");}finally{jsre=_jsvmCoreFunc_module=void(0);}
