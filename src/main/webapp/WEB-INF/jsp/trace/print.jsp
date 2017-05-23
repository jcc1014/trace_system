<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<html> 
<title>打印</title> 
<head>
<link rel="stylesheet" href="${path}/layui/css/layui.css">
<link rel="stylesheet" href="${path}/res/global.css">
<script type="text/javascript" src="${path}/layui/layui.js"></script>
<style type="text/css" media=print> 
img{
width: 3cm;
height: 3cm;
}
</style> 
</head>
<body style="text-align: center;padding-top: 10px;"> 
<input id="btnPrint"  class="layui-btn layui-btn-mini" type="button" value="打印" onclick="javascript:window.print();" /> 

<input id="btnPrint2" class="layui-btn layui-btn-mini" type="button" value="打印预览" onclick="preview(1);" /> 
<hr/>
<script> 
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
<!--startprint1--><c:if test="${qrcode.qrcode_path eq ''||qrcode.qrcode_path ==null}">暂时无法打印</c:if><c:if test="${qrcode.qrcode_path ne ''&&qrcode.qrcode_path !=null}"><img src="${path}/qrcode/${qrcode.qrcode_path}" width="150" height="150"></c:if><!--endprint1--> 
</body> 
</html> 