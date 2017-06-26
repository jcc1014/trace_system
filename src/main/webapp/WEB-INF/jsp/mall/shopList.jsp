<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>${mall}</title>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<link href="${path}/css/bass.css" rel="stylesheet" />
<link href="${path}/css/style.css" rel="stylesheet" />
<!-- 引入js资源 -->
<script type="text/javascript" src="${path}/js/jquery.min.js"></script>
<script>jQuery.noConflict()</script>
<script type="text/javascript" src="${path}/layer/layer.js"></script>
<script type="text/javascript" src="${path}/js/zepto.min.js"></script>
<script type="text/javascript" src="${path}/js/zepto.kslider.js"></script>
<style type="text/css">
.confirmOrder img {
    width: 4.0rem;
    height: 4.0rem;
    float: left;
    margin-right: .5rem;
}
.hide{display: none;}
#edit:FOCUS{color: #fff;}
.Cart .select-btn-t {
    padding-left: 2.5rem;
}
.Cart .select-btn-t img {
    left: .45rem;
}
.product-text span {
    display: initial;
    color: #1a1a1a;
    line-height: 1.0rem;
    font-size: 0.85rem;
    display: -webkit-box;
    -webkit-line-clamp: 2; 
    -webkit-box-orient: vertical;
    text-overflow: clip !important;
    overflow: visible;
</style>
</head>
<body>
	<!--头部 header-->
	<div>
		<header>
			<div class="header">
				<a href="${path}/mall/mall_index.do"><i class="icon icon-return"></i></a>
				<h1>商家列表</h1>
				<a href="#" class="cart-edit"><i class="icon icon-soso"></i></a>
			</div>
		</header>
		<div style="height: 2.5rem;"></div>
	</div>
	<form class="setCmp" style="margin-top: 0.5rem;">
		<c:forEach var="item" items="${shopList}">
			<div class="Cart">
				<a href="javascript:;" class="select-btn select-btn-t"><img
					src="${path}/images/shop.png">${item.shop_name}</a>
			</div>
			<article class="confirmOrder">
				<img src="${path}/shopPic/${item.shop_pic}">
				<div class="product-text">
					<span class="address">店址：${item.address}</span> 
					<span class="hue" style="margin-top: 0.5rem;">电话：${item.shop_phone}</span>
					<span style="text-align: right;margin-top: 0.5rem;">
						<a href="${path}/mall/shopGoodsList.do?shop_id=${item.shop_id}"  class="btn btn-primary">进店</a>
					</span>
				</div>
			</article>
		</c:forEach>
	</form>
	<!-- footer 底部菜单 -->
	<footer>
		<!-- <a href="javascript:;" class="pick"> <i class="icon icon-f1"></i>
			追溯
		</a>  -->
		<a href="${path}/mall/mall_index.do"> <i class="icon icon-f1"></i>
			首页
		</a> 
		<a href="${path}/mall/shopList.do" class="pick"> <i class="icon icon-f2"></i>
			 店铺
		</a>
		<a href="${path}/mall/getCartList.do"> <i class="icon icon-f3"></i> 
			购物车
		</a>
		<a href="${path}/mall/user.do"> <i class="icon icon-f4"></i>
			 我
		</a>
	</footer>
<script type="text/javascript">

</script>
</body>
</html>