
var _jsvmCoreFunc_kernel=function(){var jsre=_JSVM_Namespace.runtimeEnvironment;if(jsre.JSVM!=null){throw("kernel.js/JSVM already exist!");}
var Class=_JSVM_Namespace.kernel.Class=Function;Class.prototype.$super=null;Class.prototype.$package=null;Class.prototype.$class=Class;Class.prototype.$name="Class";Class.prototype.$window=window;Class.forName=function(name){return jsre.JSVM.loadClass(name);}
Class.prototype.newInstance=function(){var code="new this(";for(var i=0;i<arguments.length;i++){code+="arguments["+i+"],";}
code=code.replace(/,$/,"")+");";return eval(code);}
Class.prototype.getName=function(){return this.$name;}
Class.prototype.getPackage=function(){return this.$package;}
Class.prototype.getSuperclass=function(){return this.$super;}
Class.prototype.$extends=function(cls){try{if(typeof(cls)=="string"){cls=_JSVM_Namespace.kernel.Class.forName(cls);}
if(typeof(cls)!="function"){throw new Exception(0x0017,"Class.$extends(Class) Error:"+" the super class '"+cls+"' is an invalid class.");}
this.prototype=new cls();this.prototype.constructor=this;this.$super=cls;return this.prototype;}catch(ex){throw new Exception(0x0018,"Class.$extends(Class) fail.",ex);}}
if(typeof(Class.prototype.call)!="function"){Class.prototype.call=function(obj){if(typeof(obj)!="object"){throw new Exception(0x0010,"Class.call() arguments is not a object!");}
obj._tempMethod=this;var args=[];for(var i=0;i<arguments.length-1;i++){args[i]="arguments["+(i+1)+"]";}
var r=eval("obj._tempMethod("+args.join(",")+");");delete obj._tempMethod;return r;}}
if(typeof(Class.prototype.apply)!="function"){Class.prototype.apply=function(obj,_arguments){if(typeof(obj)!="object"){throw new Exception(0x0010,"Class.apply() arguments is not a object!");}
obj._tempMethod=this;var args=[];for(var i=0;i<_arguments.length;i++){args[i]="_arguments["+i+"]";}
var r=eval("obj._tempMethod("+args.join(",")+");");delete obj._tempMethod;return r;}}
var Object=_JSVM_Namespace.kernel.Object=function(){}
Object.$name="Object";Object.prototype.$class=Object;Object.prototype.window=window;Object.prototype.getClass=function(){return this.$class;}
Object.prototype.live=function(){return(!this.window.closed);}
Object.prototype.toString=function(){return("[Object "+this.$class.getName()+"]");}
Object.prototype.instanceOf=function(c){if(typeof(c)=="string"){c=Class.forName(c);}
return(this instanceof c)||(this.window._JSVM_Namespace!=null&&(this instanceof this.window._JSVM_Namespace.kernel.Class.forName(c.getName())));};Object=window.Object;var Package=_JSVM_Namespace.kernel.Package=function(name){var _name=name;this.getName=function(){return _name;}
this.getChildClass=function(name){return Class.forName(_name+"."+name);}}
Package.$name="Package";Package.prototype.$class=Package;Error.$super=null;Error.$package=null;Error.$name="Error";Error.prototype.$class=Error;Error.prototype.getName=function(){return this.name;}
Error.prototype.getMessage=function(){return this.message;}
Error.prototype.getCause=function(){return null;}
if(Error.prototype.name==null){Error.prototype.name="Error";Error.prototype.getMessage=function(){return this.description;}}
var Exception=_JSVM_Namespace.kernel.Exception=function(number,message,cause){this.number=_JSVM_Namespace.deviceNumber*0x10000+number;this.message=message;this.cause=cause;}
Exception.$extends(_JSVM_Namespace.kernel.Object);Exception.prototype.constructor=Exception.prototype.$class=Exception;Exception.$name="Exception";Exception.$package=null;Exception.prototype.getName=function(){return this.getClass().getName();}
Exception.prototype.getMessage=function(){return this.message;}
Exception.prototype.getCause=function(){return this.cause;}
Exception.prototype.toString=Error.prototype.toString=function(){return this.getName()+":"+this.getMessage();}
Exception.prototype.printStackTrace=Error.prototype.printStackTrace=function(){var s=this.toString();var e=this.cause;while(e!=null){s+="\r\n\tat "+e.toString();e=e.cause;}(arguments.length>0&&typeof(arguments[0].println)=="function")?arguments[0].println(s):jsre.JSVM.console.output(s+"\r\n");}
_JSVM_Namespace.kernel.JSVM_V2_01_050321=function(){if(this==window){throw new Error("Create instance must use \"new\" .");}
if(null!=_singleInstance){return _singleInstance;}
var _this=_singleInstance=this;this.version="2.01.050321";this.runMode="standalone";this.jsvmHome="";this.debug=false;this.state=0;var classloader=null;this.setClassloader=function(_classloader){classloader=_classloader;this.logs.log("JSVM.setClassloader() succ.");}
this.getClassloader=function(){return classloader;}
this.console=null;this.setConsole=function(_console){this.console=_console;this.logs.log("JSVM.setConsole() succ.");}
var container=null;this.setContainer=function(_container){container=_container;this.logs.log("JSVM.setContainer() succ.");}
this.getContainer=function(){return container;}
var compiler=null;this.setCompiler=function(_compiler){compiler=_compiler;this.logs.log("JSVM.setCompiler() succ.");}
this.getCompiler=function(){return compiler;}
var engine=null;this.setEngine=function(_engine){engine=_engine;this.logs.log("JSVM.setEngine() succ.");}
this.getEngine=function(){return engine;}
this.loadClass=function(name){var _class=container.getClass(name);if(_class==null){try{var code=container.getClassCode(name);if(code==null){code=classloader.loadClass(name);code=compiler.compile(code);container.putClassCode(name,code);}
_class=engine.defineClass(name,code);container.putClass(name,_class);}catch(ex){var err=new Exception(0x0018,"kernel.js/JSVM.loadClass() fail."+" [classname:"+name+"]",ex);this.logs.log(err);throw(err);}}
return _class;}
this.loadPackage=function(name){var err=new Exception(0x001B,"kernel.js/JSVM.loadPackage() not implemented.");this.logs.log(err);throw(err);}
this.logs=new function(){var list=[];var LogItem=function(log){this.date=new Date();this.log=log;}
LogItem.prototype.toString=function(){return "["+this.date.toLocaleString()+":"+this.date.getMilliseconds()+" JSVM] "+this.log;}
this.onchange=null;this.log=function(log){var l=list.length;list[l]=new LogItem(log);if(this.onchange!=null){this.onchange(list[l]);}}
this.getLogs=function(){return list.concat([]);}}
this.initialize=function(jsre){this.runMode=jsre.runMode;this.jsvmHome=jsre.jsvmHome;this.debug=jsre.debug;}}
var _singleInstance=null;jsre.JSVM=new _JSVM_Namespace.kernel.JSVM_V2_01_050321();jsre.JSVM.initialize(jsre);jsre.JSVM.logs.log("JSVM inited.");jsre.JSVM.setContainer(new function(){var classesCache=[];this.putClass=function(name,entity){classesCache[name]=entity;}
this.getClass=function(name){return classesCache[name];}
var classesCodeCache=[];this.putClassCode=function(name,code){classesCodeCache[name]=code;}
this.getClassCode=function(name){return classesCodeCache[name];}});jsre.JSVM.setConsole(new function(){this.output=function(msg){window.alert(msg);}
this.input=function(pmt){window.prompt(pmt);}});jsre.JSVM.setCompiler(new function(){var parsers={"native":{"parse":function(s){return s;}}};this.setParser=function(name,parser){parsers[name.toLowerCase()]=parser;}
this.getParser=function(name){return parsers[name.toLowerCase()];}
this.compile=function(sourceCode){var code=sourceCode;if(/^(\s*)#( *)(language)( *):( *)(\S+)(\s*)/.test(code)){code=code.replace(/^(\s*)#( *)(language)( *):( *)(\S+)(\s*)/,"");var language=RegExp.$6;var parser=this.getParser(language);if(parser!=null){try{code=parser.parse(code);}catch(ex){throw new Exception(0x001A,"kernel.js/JSVM.compiler.compile() error. [code: "+sourceCode+"]");}}else{throw new Exception(0x001C,"kernel.js/JSVM.compiler.compile() error. the parser for '"+language+"' can't been found.");}}
return "(function(){"+code+"})();";}});jsre.JSVM.setEngine(new function(){var _engine=this;this.executor=new function(){var _$import=function(name){return _JSVM_Namespace.runtimeEnvironment.JSVM.loadClass(name);}
var _$package=function(name){_engine.definePackage(name);}
var jsre,typeOf,isPackage;this.execute=function(code){try{eval(code);}catch(ex){var flag=false;var cause=ex.cause;while(cause!=null){if(cause.number==_JSVM_Namespace.deviceNumber*0x10000+0x0012){flag=true;break;}
cause=cause.cause;}
throw new Exception(0x0012,"kernel.js/JSVM.engine.executor.execute() fail. "+(flag?"":"[code: "+code+"]"),ex);}}}
var typeOf=function(name){var cs=name.split(".");var pn=null;for(var i=0;i<cs.length-1;i++){if(i!=0){pn+="."+cs[i];}else{pn=cs[i];}
if(eval('typeof('+pn+')')=="undefined"||eval(pn)==null){return "undefined";}}
return eval('typeof('+name+')');}
var isPackage=function(name){return(typeOf(name)=="object"&&(eval(name)instanceof _JSVM_Namespace.kernel.Package));}
var isClass=function(arg){return(typeOf(name)=="object"&&(eval(name)instanceof _JSVM_Namespace.kernel.Class));}
var classLock=new function(){var lockeds={};this.lock=function(name){lockeds[name]=true;}
this.unlock=function(name){lockeds[name]=null;}
this.isLocked=function(name){return(lockeds[name]==true);}}
this.defineClass=function(name,code){try{if(classLock.isLocked(name)){throw new Exception(0x0013,"kernel.js/JSVM.engine.defineClass() fail. class: '"+name+"' is locked.",ex);}
classLock.lock(name);this.executor.execute(code);eval("var c=eval(name);c.prototype"+".$class=c;c.$name=name;");return c;}catch(ex){throw new Exception(0x001E,"kernel.js/JSVM.engine.defineClass() fail.",ex);}finally{classLock.unlock(name);}}
this.definePackage=function(name){if(isPackage(name)){return;}
var pNames=name.split(".");var packageName=null;for(var i=0;i<pNames.length;i++){if(i==0){packageName=pNames[i];}else{packageName+="."+pNames[i];}
if(isPackage(packageName)){continue;}else if(typeOf(packageName)=="undefined"){eval("window."+packageName+" = new _JSVM_Namespace.kernel.Package(packageName);");}else{throw new Exception(0x0014,"kernel.js/JSVM.engine.definePackage() fail. {'"+packageName+"' has been defined.}");}}}});};try{var jsre=_JSVM_Namespace.runtimeEnvironment;if(jsre.state==1){_jsvmCoreFunc_kernel();jsre.setResource("$code{kernel}",_jsvmCoreFunc_kernel);jsre.log("JSVM_Namespace.rtenv: "+"Load core function 'kernel' succ.");}}catch(ex){jsre.state=0;jsre.log("JSVM_Namespace.rtenv: "+"Load core function 'kernel' fail.");}finally{jsre=_jsvmCoreFunc_kernel=void(0);}
