<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>采购</title>
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
				<div class="item" style="border: 1px solid #d81e06;" onclick="meat();">
					<img alt="肉类" src="${path}/images/orderModule/meat.png" width="100%" height="85%;">
					<div style="color: #d81e06;">肉类采购</div>
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

function setup(){
	window.location.href = '${path}/produce/setup.do'
}

function meat(){
	window.location.href = '${path}/meat/list.do';
}
</script>
</body>
</html>
