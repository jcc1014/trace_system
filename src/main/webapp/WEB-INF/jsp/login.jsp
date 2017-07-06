<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="./common/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>${sysname}</title>
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="apple-mobile-web-app-status-bar-style" content="black"> 
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="format-detection" content="telephone=no">
	<link href="${path}/res/font-awesome.css" rel="stylesheet" media="screen">
	<link href="${path}/res/font-awesome.min.css" rel="stylesheet" media="screen">
	
	<link href="${path}/res/iconfont.css" rel="stylesheet" media="screen">
	
	<link rel="stylesheet" href="${path}/layui/css/layui.css" rel="stylesheet">
	<link rel="stylesheet" href="${path}/layui/css/global.css" rel="stylesheet">
	<link rel="stylesheet" href="${path}/layui/css/style.css" rel="stylesheet">
	<script src="${path}/js/jquery-2.1.1.min.js" type="text/javascript"></script>
	
<style>
.layui-form-item .layui-input-inline {
		margin: 0 0 10px 0px
	}
/* body{background: url("${path}/images/veg.jpg")no-repeat; position:fixed;width:100%;height:100%;
filter:"progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='scale')";
} */
.bg{position:fixed;width:100%;}
.layui-elip{color:#009688;font-size: 25px;}
.layui-form{background: #fff;padding: 20px 20px;height: 340px;margin-top: 20px;
	border: 1px solid #009688;border-radius:15px;box-shadow: 1px 1px 3px #009688; }
.login-main{margin-top: 100px;height: 400px;}
.login-main header {margin-top: 30px;margin-bottom: 30px;}
</style>
</head>
<body>
<img alt="" src="${path}/images/veg.jpg" class="bg">
<!-- 用户登录 -->
<div class="login-main" id="login">
	<form class="layui-form" id="loginform">
	<header class="layui-elip">后台管理系统登录</header>
		<div class="layui-form-item">
			<div class="layui-input-inline">
				<input name="username" lay-verify="required" placeholder="请输入登录用户名"  type="text" autocomplete="off" class="layui-input">
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-input-inline">
				<input name="password" lay-verify="required" placeholder="请输入登录密码"  type="password" autocomplete="off" class="layui-input">
			</div>
		</div>
		<div class="layui-input-inline login-btn">
			<button type="submit" lay-submit="" lay-filter="login" class="layui-btn">登录</button>
		</div>
		<!-- <hr/> -->
		<!-- <p><a href="javascript:showMain('register');" class="fl">注册账号</a><a href="javascript:showMain('newpassword');" class="fr">忘记密码？</a></p> -->
	</form>
</div>

<!-- 找回密码 -->
<div class="login-main" id="newpassword" style="display:none;">
	<header class="layui-elip">找回密码</header>
	<form class="layui-form" id="newpasswordform">
		<div class="layui-form-item">
			<div class="layui-input-inline" style="width:65%;float:left;">
				<input name="email" lay-verify="email" placeholder="请输入注册账号的邮箱"  type="text" autocomplete="off" class="layui-input">
			</div>
			<div class="layui-input-inline" style="width:29%;float:right;">
				<div onclick="sendEmailCode()" class="layui-btn">获取验证码</div>
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-input-inline">
				<input name="code" lay-verify="required" placeholder="请输入邮件的验证码"  type="text" autocomplete="off" class="layui-input">
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-input-inline">
				<input name="password" lay-verify="required" placeholder="请输入新的登录密码"  type="password" autocomplete="off" class="layui-input">
			</div>
		</div>
		<div class="layui-input-inline login-btn">
			<button type="submit" lay-submit="" lay-filter="newpassword" class="layui-btn">修改</button>
		</div>
		<hr/>
		<p><a href="javascript:showMain('register');" class="fl">注册账号</a><a href="javascript:showMain('login');" class="fr">我有账号</a></p>
	</form>
</div>

<!-- 用户注册 -->
<div class="login-main" id="register" style="display:none;">
	<header class="layui-elip">新用户注册</header>
	<form class="layui-form" id="registerForm">
		<div class="layui-form-item">
			<div class="layui-input-inline" style="width:65%;float:left;">
				<input name="email" lay-verify="email" placeholder="请输入您的邮箱"  type="text" autocomplete="off" class="layui-input">
			</div>
			<div class="layui-input-inline" style="width:29%;float:right;">
				<div onclick="sendRegistEmailCode()" class="layui-btn">获取验证码</div>
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-input-inline">
				<input name="code" lay-verify="required" placeholder="请输入邮件的验证码"  type="text" autocomplete="off" class="layui-input">
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-input-inline">
				<input name="userName" lay-verify="required" placeholder="请输入用户名"  type="text" autocomplete="off" class="layui-input">
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-input-inline">
				<input name="password" lay-verify="required" placeholder="请输入登录密码"  type="password" autocomplete="off" class="layui-input">
			</div>
		</div>
		<div class="layui-input-inline login-btn">
			<button type="submit" lay-submit="" lay-filter="register" class="layui-btn">立即注册</button>
		</div>
		<hr/>
		<p><a href="javascript:;" class="fl"></a><a href="javascript:showMain('login');" class="fr">我有账号</a></p>
	</form>
</div>
<script>
$(function() {
	var form = layui.form();
	form.on('submit(login)', function(data) {
		//wait("正在登陆......");
		$.post("${path}/loginCheck.do",$("#loginform").serialize(),function(data) {
			hide();
			data = eval("(" + data + ")");
			if(data.code == 200) {
				window.location.href='${path}/index.do';
			}
			else {
				error(data.msg);
			}
			
		},"json");
		return false;
	});
	
	//修改密码
	form.on('submit(newpassword)', function(data) {
		wait("正在修改......");
		$.post("changePassword.json",$("#newpasswordform").serialize(),function(data) {
			hide();
			if(data.code == 200) {
				success("修改成功请登录");
				showMain("login");
			}
			else {
				error(data.msg);
			}
			
		},"json");
		return false;
	});
	
	//新用户注册
	form.on('submit(register)', function(data) {
		wait("正在注册......");
		$.post("register.json",$("#registerForm").serialize(),function(data) {
			hide();
			if(data.code == 200) {
				success("注册成功请登录");
				showMain("login");
			}
			else {
				error(data.msg);
			}
			
		},"json");
		return false;
	});
	
});

function sendEmailCode() {
	wait("请稍后......");
	$.post("sendChangePasswordEmailCode.json",$("#newpasswordform").serialize(),function(data) {
		hide();
		if(data.code == 200) {
			success("发送成功,请登录你的邮箱查询");
		}
		else {
			error(data.msg);
		}
		
	},"json");
	return false;
}

//新用户注册
function sendRegistEmailCode() {
	wait("请稍后......");
	$.post("sendRegistEmailCode.json",$("#registerForm").serialize(),function(data) {
		hide();
		if(data.code == 200) {
			success("发送成功,请登录你的邮箱查询");
		}
		else {
			error(data.msg);
		}
		
	},"json");
	return false;
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
