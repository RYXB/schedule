/**
 * 
 * JSTree 
 * ���� xukaihua
 * date 2012.12.22
 * 
 * 
 * <p>
 *     <br> 2 ��Ҫ������
 *      	<br>  1��ʹ�ø�����Ҫһ��div���Ҷ���id
 *        			new JSTree(id) ���������Ķ���
 *         
 *      	<br> 2���ڵ���� �ڵ㺯����� JSTree �����У����Դ����ڵ�����Ƚ����Ķ��󴴽�����
 *        			 var jsTree = new JSTree(id);
 *       			 var treeNode = new jsTree.TreeNode();
 *       			 treeNode�а� appendChild����
 *       			 �÷�������Ϊ����̬�뾲̬��ӽڵ㣬
 *       			 ��̬��ָ����divչʾ֮ǰ�����
 *        			 ��̬��ָ����divչʾ֮�����
 *        			 getCheckBox ��øýڵ��ϵĸ�ѡ�����ǰ������ʾ��ѡ��
 *           <br> 3��addNode Ϊ������ӽڵ㣬�÷�����������������bootTree����֮ǰ��ӣ�����
 *        ����ӵĽڵ��޷���div��չʾ����Ҫ��̬��ӵ��� TreeNode.appendChild(child)
 *           <br> 4)creatRoot ��������������ڵ�
 *           <br> 5)bootTree ��DIV��չʾ��
 *           <br> 6)setOnClickEvent ���õ����¼�
 *           <br> 7)setOnDblClickEvent ����˫���¼�
 *           <br> 8)setFocus ���ý���
 *           <br> 9)getSelectedNodes ��ȡѡ�е��ӽڵ�
 *           <br> 10)setIsOpen ��ʼ��ʱ�������Ƿ�չ�� true չ���� false ��չ��
 *           <br> 11)setShowCheckBox �����Ƿ���ʾ��ѡ�� true��ʾ��false ����ʾ
 *           <br> 12)setTitle �����ı���Ϣ
 *           <br> 13)setHideHelpLine �����Ƿ����ظ�����
 *           <br> 14)getTreeNode(id) ͨ��ڵ��id ��ø�node
 *           <br> 15)setIsDblClickShowTree �Ƿ�˫�������ڵ�
 *           <br> 16)setIslazyLoad �Ƿ�ʵ���ӳټ���
 *           <br> 17)isRootEventDisabled �Ƿ���ø�ڵ���¼�
 *           <br> 18)setTreeBackground �������ı�����ɫ
 * </p>
 */
function JSTree(id){
	var TreePane = U.getElement(id);
	var DataSetName={};
	var DataSet = {};//�����ݶ���
	var LoadTreeSet = {};//�Ѿ����صĽڵ�
	var isOpen = false;//�Ƿ��
	var isShowCheckBox = false;//�Ƿ���ʾ��ѡ��
	var isHideHelpLine = false;//�Ƿ����ظ�����
	var isDblClickShowTree = true//�Ƿ�˫������
	var isLazyLoad = false;//�Ƿ��ӳټ��� Ĭ�ϲ��ӳټ���,�����ӳټ��ص�ʱ���������ǹرյ� Ҳ���� isOpen������false,����������
	var isRootEventDisabled = true;//�Ƿ����� ��ڵ��¼���Ч
	var treeBackground = TreePane.style.backgroundColor == ""?'#fff':TreePane.style.backgroundColor;//Ĭ����ɫ
	
	var Root = {};//��ڵ�
	
	var end_line = "images/xtree/end_line.gif";
	var center_line = "images/xtree/center_line.gif";
	var show_line = "images/xtree/show_line.gif";
	var open_node = "images/xtree/open_node.gif";
	var close_node = "images/xtree/close_node.gif";
	
	/**
	 * hasChild �Ƿ����ӽڵ�
	 * imagePath ͼƬ·��
	 * title �ı���Ϣ
	 * id  id
	 * parentId ���ڵ� id
	 * item  �ڵ㸽����Ϣ
	 */
	this.addNode = function(hasChild,imagePath,title,id,backgroundcolor,parentId,item,sendId){
		var TreeNode = new this.TreeNode();
		TreeNode['hasChild'] = hasChild;
		TreeNode['imagePath'] = imagePath;
		TreeNode['backgroundcolor'] = backgroundcolor;
		TreeNode['title'] = title;
		TreeNode['id'] = id;
		TreeNode['parentId'] = parentId;
		TreeNode['item'] = item;
		TreeNode['sendId'] = sendId;
		var pNode = DataSet[parentId];
		
		pNode.children.push(TreeNode);
		
		DataSet[id] = TreeNode;
		DataSetName[title]=TreeNode;
	};
	
	this.createRoot = function(hasChild,imagePath,backgroundcolor,title,id,item){
		var TreeNode = new this.TreeNode();
		TreeNode['hasChild'] = hasChild;
		TreeNode['imagePath'] = imagePath;
		TreeNode['backgroundcolor'] = backgroundcolor;
		TreeNode['title'] = title;
		TreeNode['id'] = id;
		TreeNode['item'] = item;
		DataSet[id] = TreeNode;
		DataSetName[title]=TreeNode;
		//�����˸�ڵ�
		Root = TreeNode;
	};
	
	/**
	 * �����
	 */
	this.bootTree = function(){
		initStyle();
		showTree([Root],TreePane);
		bindEvent();
	};
	
	/*
	 *ͨ��id��ȡ�ڵ�
	 */
	this.getTreeNode = function (nodeId){
		return DataSet[nodeId];
	};
	this.getTreeNodeByName=function(nodeName){
		return DataSetName[nodeName];
	};
	
	
	var end_line_style = "";
	var show_line_style = "";
	var center_line_style = "";
	
	function initStyle(){ 
		TreePane.style.backgroundColor = treeBackground;
		var end_line_style = "backgronud-color:transparent;background-image:url("+(isHideHelpLine == true?"":end_line)+");background-repeat:no-repeat;background-position:8px;background-position-y:1px;margin-left:0px;width:auto;height:auto";
		var show_line_style = "background-image:url("+(isHideHelpLine == true?"":show_line)+");background-repeat:repeat-y;background-position-x:8px;background-position-y:1px;margin-left:0px;padding-left:"+(isShowCheckBox == true?"35px":"7px")+";height:auto;width:auto;display:;background-color:transparent;";
		var center_line_style = "backgronud-color:transparent;background-image:url("+(isHideHelpLine == true?"":center_line)+");background-repeat:no-repeat; background-position:8px;background-position-y:1px;margin-left:0px;width:auto;height:auto";
		var no_show_line_style = "border:1px dashed "+treeBackground+";margin-left:0px;padding-left:"+(isShowCheckBox == true?"35px":"7px")+";height:auto;width:auto;display:;background-color:transparent;"
		addSheet(".endLine{"+end_line_style+"}");
		addSheet(".showLine{"+show_line_style+"}");
		addSheet(".centerLine{"+center_line_style+"}");
		addSheet(".noShowLine{"+no_show_line_style+"}");
	};
	
	function showTree(nodes,content){
		var joinStr="";
		var showStr="";
		for(var i =0;i<nodes.length;i++){
			var arr = [];
			var node = nodes[i];
			node.isLoad = true;//��Ǹýڵ��Ƿ��Ѿ�����
			LoadTreeSet[node.id] = node;
			if (i<nodes.length-1){
				joinStr = "centerLine";
				showStr = "showLine";
			} else {
				joinStr = "endLine";
				showStr="noShowLine";
			}
			var domNode_p = document.createElement("div");
			domNode_p.id = 'parent_'+node.id;
			domNode_p.innerHTML = "<ul style='margin:0px;'><li style='list-style:none;height:20px;width:auto;'><img isOpen = 'true' id = 'click_"+node.id+"' src='"+open_node+"' style='vertical-align: middle;height:16px;width:16px;'/><input id = 'check_"+node.id+"' value='"+node.id+"' type='checkbox' class='inputcheck'  style='display:"+(isShowCheckBox == false?"none":"")+";vertical-align: middle;margin-left:0px'/><a id='image_"+node.id+"' ><image src='"+node.imagePath+"' style='margin-left:3px;;vertical-align: middle; height:16px;height:16px'/></a><span style='background-color:"+node.backgroundcolor+";margin-left:5px;width:auto;height:20px;line-height:20px;cursor:default;vertical-align: middle;' id = 'title_"+node.id+"'>"+node.title+"</span></li></ul>";
			domNode_p.className = joinStr;
			var domNode_c = document.createElement("div");
			domNode_c.id = 'child_' + node.id;
			domNode_c.className = showStr;
			content.appendChild(domNode_p);
			content.appendChild(domNode_c);
			if (isLazyLoad == true){
				continue;
			}
			if (node.children){
				var content1 = U.getElement("child_" + node.id);
				showTree(node.children,content1);
			}
		}
	};
	
	/**
	 * ���ڵ��������ÿһ���ڵ㶼�������
	 */
	this.TreeNode = function(){
		this.children = [];
		this.appendChild = function(child){
			if(!child){
				return;
			}
			if(!child.id){
				return;
			}
			this.children.push(child);
			child.parentId = this.id;
			DataSet[child.id] = child;
			DataSetName[child.title]=child;
			var content = U.getElement('child_' + this.id);
			this.hasChild = true;
			if(content&&isLazyLoad == false){
				LoadTreeSet = {};
				showTree([child], content)
				bindEvent();
			}
		};
		this.getCheckBox = function(){
			var checkBox = U.getElement('check_'+this.id);
			return checkBox;
		};
		
		this.openChildren = function(){
			if(isOpen == true){
				return;
			}
			var clickBlock = U.getElement('click_' + this.id);
			clickBlock.onclick();
			
		}
	};
	/**
	 * ���¼�
	 * @return
	 */
	function bindEvent(){
		for(var key in LoadTreeSet){
			addEvent(DataSet[key]);
		}
	}
	/**
	 * ����¼�
	 * @param node
	 * @return
	 */
	function addEvent(node){
		addClickBlockEvent(node);
		addCheckBoxEvent(node);
		addTitleEvent(node);
		addSelectEvent(node);
		addImageEvent(node);
	};
	
	
	function addCheckBoxEvent(node){
		var checkBox = U.getElement('check_' + node.id)
	};
	
	function addSelectEvent(node){
		var checkBox = node.getCheckBox();
		checkBox.onclick = function(){
			var value = this.checked;
			selectDown(node,value);
			selectUp(node);
		}
	};
	
	function addImageEvent(node){
		var image = U.getElement('image_' + node.id);
		var title = U.getElement('title_'+node.id);
		image.onclick = function(){
			if (title.onclick){
				title.onclick();
			}
			title.focus();
		}
		image.ondblclick= function(){
			if (title.ondblclick){
				title.ondblclick();
			}
		}
		image.onblur = function(){title.onblur();};
	}
	
	/**
	 * ����ͬ��ѡ���
	 * @param node
	 * @return
	 */
	function selectUp(node){
		var parentId = node.parentId;
		if (!node.isLoad){
			return;
		}
		if (!DataSet[parentId]){
			return;
		}
		if(DataSet[parentId].children){
			var flag = true;
			for (var i = 0;i<DataSet[parentId].children.length;i++){
				if(DataSet[parentId].getCheckBox().checked == DataSet[parentId].children[i].getCheckBox().checked){
					flag = false;
					break;
				}
			}
			if (flag == true){
				DataSet[parentId].getCheckBox().checked = !DataSet[parentId].getCheckBox().checked;
				
				
			} else{
				if(DataSet[parentId].getCheckBox().checked == false){
					DataSet[parentId].getCheckBox().checked = true;
				} 
			}
			
		}
		selectUp(DataSet[parentId]);
	}
	
	/**
	 * ����ͬ��ѡ���
	 * @param node
	 * @param value
	 * @return
	 */
	function selectDown(node,value){
		if (!node.isLoad){
			return;
		}
		var checkBox = node.getCheckBox();
		checkBox.checked = value;
		if(!node.children){
			return;
		}
		for (var i =0;i<node.children.length;i++){
			selectDown(node.children[i],value);
		}
	}
	
	var onClickEvent = null;
	var onDblClickEvent = null;
	function addTitleEvent(node){
		if (isRootEventDisabled == true && Root == node){
			return;
		}
		var title = U.getElement('title_'+node.id);
		if(onClickEvent){
			title.onclick = onClickEvent(node);
		};
		
		title.ondblclick = function(){
			if(onDblClickEvent){
				onDblClickEvent(node)();
			};
			
			if(isDblClickShowTree == true){
				var showClick = U.getElement('click_'+node.id);
				showClick.onclick();
			}
		};
		
		title.onfocus = function(){this.style.backgroundColor='#d3d3d3'};
		title.onblur = function(){this.style.backgroundColor=treeBackground};
		
	};
	
	function addClickBlockEvent(node){
		var showClick = U.getElement('click_'+node.id);
		showClick.onclick = function(){
			if (this.isOpen == 'true'){
				U.getElement('child_'+node.id).style.display = 'none';
				this.src = close_node;
				this.isOpen = 'false';
			} else {
				this.src = open_node;
				this.isOpen = 'true';
				
				if (isLazyLoad == true && !node.isShow){
					node.isShow = true;
					LoadTreeSet = {};
					var content = U.getElement('child_' + node.id);
					showTree(node.children, content);
					bindEvent();
				 }
				
				U.getElement('child_'+node.id).style.display = '';
				
				//ѡ��״̬�ж�
				if (node.getCheckBox().checked == true){
					for(var i = 0;i<node.children.length;i++){
						node.children[i].getCheckBox().checked = true;
					}
				}
			}
			
		}
		
		if (node.hasChild == false){
			showClick.style.visibility = "hidden";
		} else {
			showClick.style.visibility = "visible";
		}
		
		//������ӳټ�����Ҫ�ر���
		if(isOpen == false||isLazyLoad == true){
			U.getElement('child_'+node.id).style.display = 'none';
			showClick.src = close_node;
			showClick.isOpen = 'false';
		}
	};
	
	//��ӵ����¼�
	this.setOnClickEvent = function(func){
		onClickEvent = func;
	};
	//���˫���¼�
	this.setOnDblClickEvent = function(func){
		onDblClickEvent = func;
	};
	//���û��ĳ���ڵ��ý���
	this.setFocus = function(nodeId){
		var node = DataSet[nodeId];
		var titleEl = U.getElement('title_'+node.id);
		titleEl.focus();
	};
	
	/**
	 * ���ѡ�е��ӽڵ�
	 */
	this.getSelectedNodes = function(){
		var nodes = [];
		if(isShowCheckBox == false){
			alert('no have checkBox');
			return;
		}
		for (var key in DataSet){
			var node = DataSet[key];
			if(node.children.length == 0&&node.getCheckBox().checked == true){
				nodes.push(node);
			}
		}
		return nodes;
	};
	
	//�������Ƿ�չ��
	this.setIsOpen = function(flag){
		isOpen = flag;
	};
	
	//�������Ƿ�չʾcheckBox
	this.setShowCheckBox = function(flag){
		isShowCheckBox = flag;
	};
	
	//�����ı���Ϣ
	this.setTitle = function(id,str){
		var title = U.getElement('title_'+id);
		title.innerHTML = str;
	};
	
	//�����Ƿ����ظ�����
	this.setHideHelpLine = function(flag){
		isHideHelpLine = flag;
		
	};
	
	//�Ƿ�˫����ʾ��
	this.setIsDblClickShowTree = function(flag){
		isDblClickShowTree = flag;
	};
	
	//�Ƿ��ӳټ���
	this.setIslazyLoad = function(flag){
		isLazyLoad = flag;
	};
	
	//�Ƿ����ø�ڵ��¼���Ч
	this.setIsRootEventDisabled = function(flag){
		isRootEventDisabled = flag;
	};
	
	//�������ı�����ɫ
	this.setTreeBackground = function(color){
		treeBackground = color;
	}
	
	function addSheet() {
		var doc, cssCode;
		if (arguments.length == 1) {
			doc = document;
			cssCode = arguments[0]
		} else if (arguments.length == 2) {
			doc = arguments[0];
			cssCode = arguments[1];
		} else {
			alert("addSheet������������������!");
		}
		if (!+"\v1") {// �����Զ�ת��͸���ȹ��ܣ��û�ֻ������W3C��͸����ʽ������Զ�ת����IE��͸���˾�
			var t = cssCode.match(/opacity:(\d?\.\d+);/);
			if (t != null) {
				cssCode = cssCode.replace(t[0], "filter:alpha(opacity="
						+ parseFloat(t[1]) * 100 + ")")
			}
		}
		cssCode = cssCode + "\n";// ����ĩβ�Ļ��з�����firebug�µĲ鿴��
		var headElement = doc.getElementsByTagName("head")[0];
		var styleElements = headElement.getElementsByTagName("style");
		if (styleElements.length == 0) {// ������styleԪ���򴴽�
			if (doc.createStyleSheet) { // ie
				doc.createStyleSheet();
			} else {
				var tempStyleElement = doc.createElement('style');// w3c
				tempStyleElement.setAttribute("type", "text/css");
				headElement.appendChild(tempStyleElement);
			}
		}
		var styleElement = styleElements[0];
		var media = styleElement.getAttribute("media");
		if (media != null && !/screen/.test(media.toLowerCase())) {
			styleElement.setAttribute("media", "screen");
		}
		if (styleElement.styleSheet) { // ie
			styleElement.styleSheet.cssText += cssCode;
		} else if (doc.getBoxObjectFor) {
			styleElement.innerHTML += cssCode;// ���֧��ֱ��innerHTML�����ʽ���ִ�
		} else {
			styleElement.appendChild(doc.createTextNode(cssCode))
		}
	};
	
}


U = {};

U.getElement = function(id){
	return typeof id == 'object'?id:document.getElementById(id);
}

