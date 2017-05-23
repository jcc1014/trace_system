function showUrl(title,url,wight,height) {
	var dwight = "800px";
	var dheight = "500px";
	if(height) {
		dheight = height+"px";
	}
	if(wight) {
		dwight = wight+"px";
	}
	
	var myLayer = window.parent.layer;
	if(!myLayer) {
		myLayer = layer;
	}
	myLayer.open({
		type: 2,
		area: [dwight,dheight],
	    title:title,
		content:url
	}); 
	
/*	$.post(url,{},function(data) {
		var myLayer = window.parent.layer;
		if(!myLayer) {
			myLayer = layer;
		}
		myLayer.open({
		    type: 1,
		    area: ['800px',dheight],
		    title:title,
		    content: data
		 });
	},"html");*/
}

function msg(content) {
	var myLayer = window.parent.layer;
	if(!myLayer) {
		myLayer = layer;
	}
	myLayer.msg(content, {time: 2000});
}

function wait(content) {
	var myLayer = window.parent.layer;
	if(!myLayer) {
		myLayer = layer;
	}
	if(!content) {
		content = "璇风◢鍚�....";
	}
	myLayer.msg(content,{shade:0.3,time: 100000});
}

function hide() {
	var myLayer = window.parent.layer;
	if(!myLayer) {
		myLayer = layer;
	}
	myLayer.closeAll();
}

function error(content) {
	var myLayer = window.parent.layer;
	if(!myLayer) {
		myLayer = layer;
	}
	myLayer.msg(content, {time: 2000});
}

function success(content) {
	var myLayer = window.parent.layer;
	if(!myLayer) {
		myLayer = layer;
	}
	myLayer.msg(content, {time: 2000});
}

function tip(content) {
	var myLayer = window.parent.layer;
	if(!myLayer) {
		myLayer = layer;
	}
	myLayer.msg(content, {time: 2000});
}

//纭瀵硅瘽妗�
function confirm(url,msg) {
	layer.open({
	    content:msg,
	    yes:function() {
	    	window.location.href=url;
	    }
	});
}

function showDomHtml(title,msg,area) {
	var myLayer = layer;
	var defaultArea = ['400px',"300px"];
	if(area) {
		defaultArea = area;
	}
	myLayer.open({
		type: 1,
		title:title,
	    content:msg,
	    area:defaultArea,
	    btn:[]
	});
}

function showDialog(title,msg,callBack,area) {
	var myLayer = window.parent.layer;
	if(!myLayer) {
		myLayer = layer;
	}
	var defaultArea = ['400px','300px'];
	if(area) {
		defaultArea = area;
	}
	myLayer.open({
		title:title,
	    content:msg,
	    area:defaultArea,
	    yes:function(index) {
	    	myLayer.close(index);
	    	if(callBack) {
	    		callBack();
	    	}
	    	return false;
	    }
	});
}

$(function() {
	layui.define(['layer', 'code', 'form', 'element', 'util','upload'], function(exports){
		var $ = layui.jquery;
		var layer = layui.layer;
		var form = layui.form();
		//var util = layui.util;
		var device = layui.device();
		//闃绘IE7浠ヤ笅璁块棶
		if(device.ie && device.ie < 8){
			layer.alert('Layui鏈€浣庢敮鎸乮e8锛屾偍褰撳墠浣跨敤鐨勬槸鍙よ€佺殑 IE'+ device.ie + '锛屼綘涓殑鑲畾涓嶆槸绋嬪簭鐚匡紒');
		}
		//鎵嬫満璁惧鐨勭畝鍗曢€傞厤
		var treeMobile = $('.site-tree-mobile');
		var shadeMobile = $('.site-mobile-shade');

		treeMobile.on('click', function(){
			$('body').addClass('site-mobile');
		});

		shadeMobile.on('click', function(){
			$('body').removeClass('site-mobile');
		});
		exports('global', {});
		
		//鑿滃崟鍊熺偣 鍥炬爣
		window.global = {
		  preview: function(){
		    var preview = document.getElementById('LAY_preview');
		    return preview ? preview.innerHTML : '';
		  }()
		};
	});	
});

function str2Json(str) {
	var json = null;
	try{
		json = JSON.parse(str);
		for(var key in json) {
			var tempValue = json[key];
			json[key] = str2Json(tempValue);
		}
		return json;
	}
	catch(e) {
		return str;
	}
}

$.getUrlParam = function (name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) return unescape(r[2]); return null;
};

function resizeShowTab() {
	if(window.parent) {
		window.parent.$(".layui-show").find("iframe").load();
	}
	else {
		$(".layui-show").find("iframe").load();
	}
}

function showSelectFile(uploaddiv,func) {
	//window.parent.UE.getEditor('editor_image');
	var parentDiv = $(uploaddiv).parent();
	editor_image = window.parent.window.UE.getEditor('editor_image');
	editor_image.removeListener("contentChange");
	editor_image.addListener("contentChange",function(){
		var imgContent = editor_image.getContent();
		var start = imgContent.indexOf("http://");
		var end = imgContent.indexOf(" alt=",start);
		if(start==-1 || end==-1) {
			return ;
		}
		var src = imgContent.substring(start,end-1);
		if(func) {
			func(src);
		}
		else {
			parentDiv.find("img").attr("src",src);
			parentDiv.find("input").val(src);
		}
	});
	
	try {
		editor_image.setContent("");	
	}
	catch(e) {}
	window.parent.document.getElementById("edui137_body").click();
	window.parent.$("#edui_fixedlayer").css("z-index",99999991);
	
}


var chars = ['0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'];
var num = ['0','1','2','3','4','5','6','7','8','9'];
function randNum(n) {
	var res = "";
    for(var i = 0; i < n ; i ++) {
        var id = Math.floor(Math.random()*10);
        res += num[id];
    }
    return res;
}

function randStr(n) {
	var res = "";
    for(var i = 0; i < n ; i ++) {
        var id = Math.floor(Math.random()*62);
        res += chars[id];
    }
    return res;
}