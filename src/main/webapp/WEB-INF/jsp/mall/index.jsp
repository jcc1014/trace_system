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
</head>
<body>

	<!--头部 header-->

	<div>
		<header>
			<div class="header">
				<a href="#"><i class="icon icon-menu"></i></a>
				<h1>特产商城</h1>
				<i class="icon icon-soso"></i>
			</div>
		</header>
		<div style="height: 2.5rem;"></div>
	</div>
	<!--轮播图 banner-->
	<div class="m-slider" id="slider">

		<div class="ks_dbox ks_ts">
			<c:forEach var="item" items="${bannerList}">
				<div class="ks_wrap">
					<a href="http://${item.banner_url}"  title="${item.banner_title }">
					<img src="${path}/banner/${item.banner_path}">
					</a>
				</div>
			</c:forEach>
		</div>
		<div class="ks-circles">
			<ul class="ks_wt"></ul>
		</div>
	</div>
	<!--导航 nav-->
	<nav>
		<!-- <div class="nav-box">
			<a href="javascript:;"><img src="images/nav01.png"><span>大聚惠</span></a>

			<a href="javascript:;"><img src="images/nav02.png"><span>特产购</span></a>

			<a href="javascript:;"><img src="images/nav03.png"><span>超市百货</span></a>

			<a href="javascript:;"><img src="images/nav04.png"><span>特供直销</span></a>

			<a href="javascript:;"><img src="images/nav05.png"><span>美食娱乐</span></a>   

		</div> -->

	</nav>
	<!-- 精选促销 -->
	<!-- <article style="margin-bottom: 0;">

		<h1>热销商品</h1>

	</article>

	<div class="commodity-box">

		<ul class="commodity">

			<li><a href="productDetails.html"> <img
					src="images/d_sp_01.jpg"> <span>胡萝卜</span> <span
					class="price">￥22.00 <s>￥25.00</s></span>

			</a></li>

			<li><a href="javascript:;"> <img src="images/d_sp_02.jpg">

					<span>樱桃</span> <span class="price">￥40.00 <s>￥50.00</s></span>

			</a></li>

			<li><a href="javascript:;"> <img src="images/d_sp_03.jpg">

					<span>西红柿</span> <span class="price">￥2.00 <s>￥2.50</s></span>

			</a></li>

		</ul>

	</div> -->

	<article style="margin-bottom: 0;">
		<h1>精选促销</h1>
	</article>
	<div class="commodity-box">
		<ul class="commodity">
			<c:forEach var="item" items="${list}">
				<li>
					<a href="${path}/mall/goodsDetails.do?goods_id=${item.goods.goods_id}"> 
						<img src="${address}/${item.goodsPic.pic_path}"> 
						<span>${item.goods.goods_name}</span> 
						<span class="price">￥${item.goods.new_price} <s>￥${item.goods.old_price}</s></span>
					</a>
				</li>
			</c:forEach>
		</ul>
	</div>
	<!-- footer 底部菜单 -->
	<footer>
		<a href="javascript:;" class="pick"> <i class="icon icon-f1"></i>
			首页
		</a> <a href="community.html"> <i class="icon icon-f2"></i>
			 社区
		</a> <a href="shoppingCart.html"> <i class="icon icon-f3"></i> 
			购物车
		</a> <a href="user.html"> <i class="icon icon-f4"></i>
			 我
		</a>
	</footer>
	<!-- 引入js资源 -->
	<script type="text/javascript" src="${path}/js/zepto.min.js"></script>

	<script type="text/javascript" src="${path}/js/zepto.kslider.js"></script>
	<script type="text/javascript">
	  $(function(){
	     //slider
	      $('#slider').slider({
	        className: 'slider_box',
	        tick: 4000 //播放间隔
	     });
	     var imgPieces=$('.m-slider').find('.ks_wrap');
	     for(var i=0;i<imgPieces.length;i++){
	       $('.ks_wt').append('<li></li>');
	       $('.ks_wt').find('li').eq(0).addClass('active');
	     }

	  });

	</script>

</body>

</html>