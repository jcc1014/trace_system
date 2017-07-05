<%@ page language="java" contentType="text/html; chitemset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta chitemset="utf-8">
    <title>${mall}</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link href="${path}/css/ui.css" rel="stylesheet" />
    <script type="text/javascript" src="${path}/js/jquery.min.js"></script>
	<script type="text/javascript" src="${path}/layer/layer.js"></script>
    <style>
	    .table{width:100%;text-align: center;border: 0.5px solid #eeeeee}
	    .table tr{height:30px;}
	    .table td{border:0.5px solid #eee}
	    .table img{height: 100px;}
    	li{margin-top: 0.5rem;border-top: 1px solid #eee;}
    </style>
</head>
<body>

<div class="header">
	<div class="header-background"></div>
	<div class="toolbar statusbar-padding">
		<button class="bar-button back-button" onclick="history.back();" dwz-event-on-click="click"><i class="icon icon-back"></i></button>
		<div class="header-title">
			<div class="title">订单详情</div>
		</div>
	</div>
</div>

<div style="height:44px"></div>

<table class="table">
	<tr>
		<td>序号</td>
		<td>图片</td>
		<td>商品名称</td>
		<td>单价（元）</td>
		<td>数量</td>
	</tr>
	<c:forEach items="${list}" var="goods" varStatus="status">
		<tr>
			<td width="10%">${status.index + 1}</td>
			<td>
				<img src="${goods.pic}">
			</td>
			<td width="25%">${goods.name}</td>
			<td width="15%">${goods.price}</td>
			<td width="10%">${goods.number}</td>
		</tr>
	</c:forEach>
</table>

</body>
</html>