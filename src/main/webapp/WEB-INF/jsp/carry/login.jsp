<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>配送系统</title>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" type="text/css" href="${path}/css/ui.css">
	<!-- <link href="favicon.ico" type="image/x-icon" rel="icon">
    <link href="iTunesArtwork@2x.png" sizes="114x114" rel="apple-touch-icon-precomposed"> -->
</head>
<style type="text/css">
body p {
	position: absolute;
	top: 50%;
	left: 50%;
	margin-top: -15px;
	margin-left: -60px;
	width: 120px;
	height: 30x;
}
</style>
<script src="${path}/js/jquery-2.1.1.min.js" type="text/javascript"></script>
<script type="text/javascript">
/* window.onload = function(){
	var ua = navigator.userAgent.toLowerCase();
	var isWeixin = ua.indexOf('micromessenger') != -1;
	if (!isWeixin) {
		alert('请在微信中打开！');
		$("body").empty().append('<p>请在微信中打开</p>');

	}
} */
</script>
<style type="text/css">
	.dot {
		animation: sploosh 2.5s cubic-bezier(0.165, 0.84, 0.44, 1);
	}
	.dot2 {
		animation: sploosh2 2.5s cubic-bezier(0.165, 0.84, 0.44, 2);
	}
	.dot3 {
		animation: sploosh3 2.5s cubic-bezier(0.165, 0.84, 0.44, 3);
	}
	.dot,.dot2,.dot3{
		height:20px;
		width: 100%;
		font-size: 40px;
		color: #fff;
		text-align: center;
		border-radius:100% 100% 0 0;
		position: absolute;
		z-index: 10;
		animation-iteration-count:3;
		-webkit-animation-iteration-count:3; /* Safari 和 Chrome */
		background: transparent;
	}
	@keyframes sploosh {
		0% {
			box-shadow: 0 0 0 10px rgba(255, 220, 1, 0.7);
			background: rgba(255, 220, 1, 0.7);
		}
		100% {
			box-shadow: 0 0 0 20px rgba(255, 220, 1, 0);
			background: rgba(255, 220, 1, 0);
		}
	}
	@keyframes sploosh2 {
		0% {
			box-shadow: 0 0 0 30px rgba(255, 220, 1, 0.7);
			background: rgba(255, 220, 1, 0.7);
		}
		100% {
			box-shadow: 0 0 0 40px rgba(255, 220, 1, 0);
			background: rgba(255, 220, 1, 0.3);
		}
	}
	@keyframes sploosh3 {
		0% {
			box-shadow: 0 0 0 50px rgba(255, 220, 1, 0.7);
			background: rgba(255, 220, 1, 0.7);
		}
		100% {
			box-shadow: 0 0 0 60px rgba(255, 220, 1, 0);
			background: rgba(255, 220, 1, 1);
		}
	}
</style>

<body>
<div class="header">
	<div class="" style="background:none"></div>
	<div class="toolbar statusbar-padding">
		<div class="header-title">
			<div class="title"></div>
		</div>
	</div>
</div>

<div class="aui-login-ba" style="position:relative; overflow:hidden">

	<span class="aui-login-logo"><!-- <img src="images/title.png"> --></span>

	<canvas id="waves" class="waves" style="position:absolute; bottom:-60px; left:-210px;"></canvas>

</div>

<div class="aui-logon-con">
	<div class="b-line">
		<input type="text" id="username" placeholder="手机号">
	</div>
	<div class="b-line">
		<input type="password" id="password" placeholder="密码">
	</div>
	<div class="aui-login-l">
		<a href="javascript:;" onclick="login();">登录</a>
	</div>
</div>
<script type="text/javascript" src="${path}/js/jquery.min.js"></script>
<script>jQuery.noConflict()</script>
<script type="text/javascript" src="${path}/layer/layer.js"></script>
<script src="${path}/js/css3/49f8daee.vendors.js"></script>
<script src="${path}/js/css3/26f2fc0d.index.js"></script>
<script type="text/javascript" src="${path}/js/commonUtil.js"></script>
<script type="text/javascript">
function login(){
	var username = $("#username").val();
	if(""==username){
		layer.msg("请输入手机号！",{time:1000});
		return;
	}
	var password = $("#password").val();
	if(""==password){
		layer.msg("请输入密码！",{time:1000});
		return;
	}
	$.ajax({
		url:'${path}/carry/loginCheck.do',
		type:'post',
		dataType:'json',
		data:{'username':username,'password':password},
		success:function(rs){
			if(""!=rs){
				rs = $.parseJSON(rs);
				if(rs.code == "200"){
					layer.msg(rs.msg,{time:1000},function(){
						window.location.href= '${path}/carry/index.do';
					});
				}else{
					layer.msg(rs.msg,{time:1000});
				}
			}
		}
	})
}
</script>
</body>
</html>	