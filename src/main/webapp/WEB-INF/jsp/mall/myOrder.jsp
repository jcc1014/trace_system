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
article{margin-top: 0.5rem;background-color: #eee;}
</style>
</head>
<body>
	<!--头部 header-->
	<div>
		<header>
			<div class="header">
				<a href="${path}/mall/user.do"><i class="icon icon-return"></i></a>
				<h1>
				<c:if test="${status eq '1' }">待付款</c:if>
				<c:if test="${status eq '2' }">已付款</c:if>
				<c:if test="${status eq '3' }">已完成</c:if>
				</h1>
			</div>
		</header>
		<div style="height: 2.5rem;"></div>
	</div>
	<!-- 购物车 -->
	<form class="setCmp">
		<c:forEach var="item" items="${list}">
			<article class="confirmOrder" id="${item.order.order_id }">
				<div class="product-text">
					<span>订单号：${item.order.order_number }</span>
					<span>订单时间：${item.order.ordertime }</span>
					<span>商品名称：${item.goods.goods_name}</span>
					 <span class="price price-cart">单价： ￥${item.order.price}
						<div class="norms-content-t norms-content-two">
							<span style="width: 8rem">数量：${item.order.number}	（斤）</span> 
						</div>
					</span>
					<span>总价：${item.order.amount}</span>
				</div>
			</article>
		</c:forEach>
	</form>
	<!-- footer 底部菜单 -->
	<footer>
		<!-- <a href="javascript:;" class="pick"> <i class="icon icon-f1"></i>
			追溯
		</a>  -->
		<a href="${path}/mall/mall_index.do" > <i class="icon icon-f1"></i>
			首页
		</a> 
		<a href="${path}/mall/shopList.do"> <i class="icon icon-f2"></i>
			 店铺
		</a>
		<a href="${path}/mall/getCartList.do" class="pick"> <i class="icon icon-f3"></i> 
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