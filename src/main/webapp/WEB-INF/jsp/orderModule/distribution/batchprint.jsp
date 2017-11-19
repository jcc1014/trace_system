<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../common/common.jsp" %>
<html> 
<title>打印</title> 
<head>
<link rel="stylesheet" href="${path}/layui/css/layui.css">
<link rel="stylesheet" href="${path}/res/global.css">
<script type="text/javascript" src="${path}/js/jquery.min.js"></script>
<script type="text/javascript" src="${path}/layer/layer.js"></script>
<style type="text/css" media=print> 
</style> 
</head>
<body style="text-align: center;padding-top: 10px;"> 
<input id="btnPrint"  class="layui-btn layui-btn-mini" type="button" value="打印" onclick="javascript:window.print();" /> 

<input id="btnPrint2" class="layui-btn layui-btn-mini" type="button" value="预览" onclick="preview(1);" /> 
<input id="large" class="layui-btn layui-btn-mini" type="button" value="大" onclick="large();" /> 
<input id="small" class="layui-btn layui-btn-mini" type="button" value="小" onclick="small();" /> 
<input id="up" class="layui-btn layui-btn-mini" type="button" value="上" onclick="up();" />
<input id="down" class="layui-btn layui-btn-mini" type="button" value="下" onclick="down();" /> 
<hr/>
<script> 
function large(){
	var width = $(".img").width();
	if(width<160){
		width = width+10+"px";
		$(".img").width(width).height(width);
	}else{
		layer.msg("不能放大了！",{time:1000});
	}
}
function small(){
	var width = $(".img").width();
	if(width>100){
		width = width-10+"px";
		$(".img").width(width).height(width);
	}else{
		layer.msg("不能缩小了！",{time:1000});
	}
}
function up(){
	var f = $(".img").offset();
	//alert(f.top+","+f.left);
	if(f.top>36){
		$(".img").offset({top:f.top-2,left:f.left})
	}else{
		layer.msg("不能向上了！",{time:1000});
	}
}
function down(){
	var f = $(".img").offset();
	//alert(f.top+","+f.left);
	if(f.top<50){
		$(".img").offset({top:f.top+2,left:f.left})
	}else{
		layer.msg("不能向下了！",{time:1000});
	}
}
function preview(oper) 
{ 
if (oper < 10) 
{ 
bdhtml=window.document.body.innerHTML;//获取当前页的html代码 
sprnstr="<!--startprint"+oper+"-->";//设置打印开始区域 
eprnstr="<!--endprint"+oper+"-->";//设置打印结束区域 
prnhtml=bdhtml.substring(bdhtml.indexOf(sprnstr)+18); //从开始代码向后取html 

prnhtml=prnhtml.substring(0,prnhtml.indexOf(eprnstr));//从结束代码向前取html 
window.document.body.innerHTML=prnhtml; 
window.print(); 
window.document.body.innerHTML=bdhtml; 
} else { 
window.print(); 
} 
} 
</script> 
<!--startprint1--><c:forEach var="item" items="${list}"><c:if test="${item.qrcode.qrcode_path eq ''||item.qrcode.qrcode_path ==null}">暂时无法打印</c:if><c:if test="${item.qrcode.qrcode_path ne ''&&item.qrcode.qrcode_path !=null}"><table><tr><td rowspan="4"><img class="img" style="width: 3cm;height: 3cm;margin-top: -10px;margin-left: 20px;" src="${path}/distribution/${item.qrcode.qrcode_path}" /></td><td style="vertical-align: top;">县域电商</td></tr><tr><td style="vertical-align: top;">食安济阳</td></tr><tr><td style="vertical-align: top;">福德农科</td></tr><tr><td style="vertical-align: top;">${fn:substring(item.qrcode.qrcode_path,0,fn:length(item.qrcode.qrcode_path)-18)}</td></tr></table></c:if></c:forEach><!--endprint1--> 
</body> 
</html> 