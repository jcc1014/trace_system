<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>需求单</title>
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="apple-mobile-web-app-status-bar-style" content="black"> 
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="format-detection" content="telephone=no">
	<link href="${path}/css/bootstrap.css" rel="stylesheet" media="screen">
	<script src="${path}/js/jquery-2.1.1.min.js" type="text/javascript"></script>
	<script src="${path}/js/bootstrap.min.js" type="text/javascript"></script>
	<style type="text/css">
		body{background-color: #eee;}
		.main{margin-top: 10rem !important;}
		.row{height:20rem;}
		.item{border: 1px solid #eee;background-color: #E0EEEE;height: 18rem;padding: 1rem;border-radius:15px}
		.item div{text-align: center;font-size: 2rem;line-height: 2rem;
		.navbar-brand{color: #009688 !important;}
		width: 100%;padding-top: 0.5rem;}
	</style>
</head>
<body>
	<nav class="navbar navbar-default">
		<div class="container-fluid">
			<!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
					aria-expanded="false">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="${path}/baseInfo/index.do">后台管理系统</a>
			</div>
		</div>
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<!-- <li><a href="#">我的消息</a></li> -->
				<li><a href="${path}/baseInfo/logout.do">退出登录</a></li>
			</ul>
		</div>
		<!-- /.navbar-collapse -->
	</nav>
	<div class="container-fluid main" >
		<div class="row">
			<div class="col-md-6 col-xs-6">
				<div class="item" style="border: 1px solid #1296db;" onclick="today();">
					<img alt="需求单" src="${path}/images/orderModule/today.png" width="100%" height="85%;">
					<div style="color: #009688;">需求单</div>
				</div>
			</div>
			<div class="col-md-6 col-xs-6">
				<div class="item" style="border: 1px solid #EE7600;" onclick="history();">
					<img alt="需求历史" src="${path}/images/orderModule/history.png" width="100%" height="85%;">
					<div style="color: #1296db;">需求历史</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-6 col-xs-6">
				<div class="item" style="border: 1px solid #515151;" onclick="jd();">
					<img alt="个人设置" src="${path}/images/orderModule/market.png" width="100%" height="85%;">
					<div style="color: #EE7600;">基本信息</div>
				</div>
			</div>
			<div class="col-md-6 col-xs-6">
				<div class="item" style="border: 1px solid #515151;" onclick="sh();">
					<img alt="收货列表" src="${path}/images/orderModule/sh.png" width="100%" height="85%;">
					<div style="color: #EE7600;">收货列表</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-6 col-xs-6">
				<div class="item" style="border: 1px solid #1296db;" onclick="rou();">
					<img alt="需求单" src="${path}/images/orderModule/today.png" width="100%" height="85%;">
					<div style="color: #009688;">肉类需求单</div>
				</div>
			</div>
			<div class="col-md-6 col-xs-6">
				<div class="item" style="border: 1px solid #515151;" onclick="rsh();">
					<img alt="收货列表" src="${path}/images/orderModule/sh.png" width="100%" height="85%;">
					<div style="color: #EE7600;">肉类收货列表</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-6 col-xs-6">
				<div class="item" style="border: 1px solid #EE7600;" onclick="fl();">
					<img alt="蔬菜分类" src="${path}/images/orderModule/type.png" width="100%" height="85%;">
					<div style="color: #8968CD;">蔬菜分类查询</div>
				</div>
			</div>
			<div class="col-md-6 col-xs-6">
				<div class="item" style="border: 1px solid #009688;" onclick="setup();">
					<img alt="个人设置" src="${path}/images/orderModule/setup.png" width="100%" height="85%;">
					<div style="color: #515151;">个人设置</div>
				</div>
			</div>
		</div>
	</div>
<script type="text/javascript">
function today(){
	window.location.href = '${path}/require/today_require.do';
}

function history(){
	window.location.href = '${path}/require/history.do'
}

function setup(){
	window.location.href = '${path}/produce/setup.do'
}

function jd(){
	window.location.href = '${path}/require/info.do';
}
function sh(){
	window.location.href = '${path}/distribution/today_sh.do';
}
function fl(){
	window.location.href = "${path}/sczl/query.do";
}
function rou(){
	window.location.href = "${path}/meat/requireList.do";
}
function rsh(){
	window.location.href = "${path}/meat/confirmList.do";
}
</script>
</body>
</html>
