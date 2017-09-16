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
<link href="${path}/css/bass.css" rel="stylesheet" />
<link href="${path}/css/style.css" rel="stylesheet" />
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
<style type="text/css">
.commodity li {
    display: inline-block;
    width: 31%;
    height: 160px;
    margin-right: 2%;
    margin-bottom: .25rem;
    background-color: #fff;
}
.commodity li>img {
    width: 100%;
    height: 80px;
}
.commodity-box {
    padding-left: 0.9rem;
    margin-bottom: 3rem;
}
</style>
<!-- 引入js资源 -->
	<script type="text/javascript" src="${path}/js/jquery.min.js"></script>
	<script>jQuery.noConflict()</script>
	<script type="text/javascript" src="${path}/layer/layer.js"></script>
	<script type="text/javascript" src="${path}/js/zepto.min.js"></script>
	<script type="text/javascript" src="${path}/js/zepto.kslider.js"></script>
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=6GGn0bxXgdfWXVoynp7bijkg4G3FXV9h"></script>  
<style type="text/css">
.btn-mini{width: 50px;padding: 2px;margin-bottom: 5px;}
.norms-content-two {
    line-height: 1.5rem;
    padding: .5rem;
    font-size: .8rem;
}
.norms-content-t{
	line-height: 1.5rem;
	padding: .5rem;
	font-size: .8rem;
}
.addIcon{background-image: url("${path}/images/add_icon.png");width: 16px;height: 16px;}
.subIcon{background-image: url("${path}/images/sub_icon.png");width: 16px;height: 16px;}
</style>
</head>
<body>
	<div id="selectMapPointDiv">
		
		<article class="confirmOrder" id="${shop.shop_id }">
			<img src="${path}/shopPic/${shop.shop_pic}">
			<div class="product-text">
				<span class="address">店址：${shop.address}</span> <span class="hue"
					style="margin-top: 0.5rem;">电话：${shop.shop_phone}</span>
					 
			</div>
			<c:forEach items="${list}" var="item" >
			<div id="${item.order.id }">
				<div>订单号：${item.order.order_number }</div>
				<div>接收人：${item.address.name }</div>
				<div>手机号：${item.address.phone }</div>
				<div>地址：${item.address.sheng }${item.address.shi }${item.address.qu }${item.address.address_detail }</div>
				<span style="text-align: right; margin-top: 0.5rem;"> <a
					href="javascript:;" onclick="selectOrder('${item.order.id}')"
					class="btn btn-primary">选择</a></span>
			</div>
			</c:forEach>
		</article>
		
	</div>
</body>
</html>