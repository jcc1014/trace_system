<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>后台管理系统</title>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="format-detection" content="telephone=no">
<link href="${path}/res/font-awesome.css" rel="stylesheet" media="screen">
<link href="${path}/res/font-awesome.min.css" rel="stylesheet" media="screen">
<link href="${path}/res/iconfont.css" rel="stylesheet" media="screen">
<link rel="stylesheet" href="${path}/layui/css/layui.css">
<link rel="stylesheet" href="${path}/layui/css/global.css">
<link rel="stylesheet" href="${path}/layui/css/style.css">
<script src="${path}/js/jquery-2.1.1.min.js" type="text/javascript"></script>
<script src="${path}/layer/layer.js" type="text/javascript"></script>
<style type="text/css">
body h1 {
	position: absolute;
	top: 50%;
	left: 50%;
	margin-top: -50px;
	margin-left: -50px;
	width: 100px;
	height: 100x;
}
</style>
<script type="text/javascript">
	/* $(function() {
		var ua = navigator.userAgent.toLowerCase();
		var isWeixin = ua.indexOf('micromessenger') != -1;
		if (!isWeixin) {
			alert('请在微信中打开！');
			$("body").empty().append('<h1>请在微信中打开</h1>');

		}
	}) */
</script>
<style>
.layui-form-item .layui-input-inline {margin: 0 0 10px 0px;border-radius:5px;}
.bg{position:fixed;width:100%;}
.layui-elip{color:#009688;font-size: 25px;}
/* .layui-form{background: #fff;padding: 20px 20px;height: 340px;margin-top: 20px;
	border: 1px solid #009688;border-radius:15px;box-shadow: 1px 1px 3px #009688; } */
.login-main{margin-top: 100px;height: 400px;}
.login-main header {margin-top: 30px;margin-bottom: 30px;}
body{background-color: #eff;}
</style>
</head>
<body>
<!-- 用户登录 -->
<div class="login-main" id="login">
	<form class="layui-form" id="loginform">
	<header class="layui-elip">后台管理系统登录</header>
		<div class="layui-form-item">
			<div class="layui-input-inline">
				<input id="username" lay-verify="required" value="${username}" placeholder="请输入登录用户名"  type="text" autocomplete="off" class="layui-input">
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-input-inline">
				<input id="password" lay-verify="required" value="${password}" placeholder="请输入登录密码"  type="password" autocomplete="off" class="layui-input">
			</div>
		</div>
		<div class="layui-input-inline login-btn">
			<button type="button" onclick="login();" class="layui-btn">登录</button>
		</div>
	</form>
</div>

<script>
function login(){
	var username = $("#username").val();
	if(""==username){
		layer.msg('请填写用户名！',{time:1000});
		return;
	}
	var password = $("#password").val();
	if(""==password){
		layer.msg('请填写密码！',{time:1000});
		return;
	}
	$.ajax({
		url:'${path}/baseInfo/loginCheck.do',
		type:'post',
		data:{'username':username,'password':password},
		dataType:'json',
		success:function(rs){
			if(null!=rs&&""!=rs){
				rs = $.parseJSON(rs);
				if("200"==rs.code){
					layer.msg(rs.msg,{time:1000},function(){
						window.location.href = '${path}/baseInfo/index.do';
					});
				}else{
					layer.msg(rs.msg,{time:1000});
				}
				
			}
		}
	})
}
	

function showMain(id) {
	$(".login-main").hide();
	$("#"+id).show();
}
</script>
</body>
<script src="${path}/layui/lay/dest/layui.all.js" charset="utf-8"></script>
<script src="${path}/layui/global.js" charset="utf-8"></script>
</html>
