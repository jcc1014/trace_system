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
	<script type="text/javascript">
	  $(function(){
		  /* window.onload = function(){
			var ua = navigator.userAgent.toLowerCase();
			var isWeixin = ua.indexOf('micromessenger') != -1;
			if (!isWeixin) {
				alert('请在微信中打开！');
				$("body").empty().append('<p>请在微信中打开</p>');

			}
		} */
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

	<!--头部 header-->

	<div>
		<header>
			<div class="header">
				<a href="#"><i class="icon icon-menu"></i></a>
				<h1>新济阳商城</h1>
				<!-- <i class="icon icon-soso"></i> -->
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
					<%-- <a href="${path}/mall/goodsDetails.do?goods_id=${item.goods.goods_id}"> 
					</a> --%>
						<img src="${address}/${item.goodsPic.pic_path}"> 
						<span>${item.goods.goods_name}
						</span> 
						<span class="price">￥${item.goods.new_price} <s>￥${item.goods.old_price}</s></span>
						<button type="button" onclick="addCart('${item.goods.goods_id}','${item.goods.goods_name}','${item.goods.new_price}');" class="btn btn-primary btn-mini" >购买</button>
				</li>
			</c:forEach>
		</ul>
	</div>
	<!-- footer 底部菜单 -->
	<footer>
		<!-- <a href="javascript:;" class="pick"> <i class="icon icon-f1"></i>
			追溯
		</a>  -->
		<a href="${path}/mall/mall_index.do" class="pick"> <i class="icon icon-f1"></i>
			首页
		</a> 
		<a href="${path}/mall/shopList.do"> <i class="icon icon-f2"></i>
			 店铺
		</a>
		<a href="${path}/mall/getCartList.do"> <i class="icon icon-f3"></i> 
			购物车
		</a>
		<a href="${path}/mall/user.do"> <i class="icon icon-f4"></i>
			 我
		</a>
	</footer>
	<div id="cartPage" style="display: none;">
		<input type="hidden" id="add_goods_id"/>
		<div  class="norms-content-t">名称：<span id="add_goods_name"></span></div>
		<div  class="norms-content-t">单价：<span id="add_goods_price"></span>&nbsp;元/斤</div>
		<div  class="norms-content-t">
			数量 ：<a class="addIcon"></a> <input id="add_goods_num" type="number" value="0" style="width: 50px;height: 30px;padding: 0px;margin: 0px;"/><a
				class="subIcon"></a>

		</div>
		<div class="norms-content-t"><input type="button" onclick="saveCart();" class="btn" value="加入购物车"/></div>
	</div>
	
	<script type="text/javascript">
	  function addCart(id,name,price){
		  //先验证登录状态
		  userid = '${sessionScope.user.userid}';
		  if(''==userid){
			  layer.msg("请先进行登录！",{time:1000},function(){
				  window.location.href = "${path}/mall/login.do";
			  })
		  }else{
			  $("#add_goods_id").val(id);
			  $("#add_goods_name").html(name);
			  $("#add_goods_price").html(price);
			  layer.open({
				  type: 1,
				  title: '加入购物车',
				  closeBtn: 1,
				  area: ['80%','50%'],
				  content: $('#cartPage') 
			  }) 
		  }
	  }
	  
	  function saveCart(){
		  var add_goods_num = $("#add_goods_num").val();
		  if(0==add_goods_num||"0"==add_goods_num||""==add_goods_num){
			  layer.msg('请填写数量！',{time:1000});
			  return;
		  }
		  if(isNaN(add_goods_num)){
			  layer.msg('数量应为数字！',{time:1000});
			  return;
		  }
		  var number = parseFloat(add_goods_num);
		  var goods_id = $("#add_goods_id").val();
		  var price = parseFloat($("#add_goods_price").html().trim());
		  var amount = number*price;
		  $.ajax({
			  type:'post',
			  url:'${path}/mall/addCart.do',
			  data:{'number':number,'goods_id':goods_id,'price':price,'amount':amount},
			  success:function(rs){
				  if(null!=rs){
					layer.msg('加入购物车成功！',{time:1000},function(){
						layer.closeAll();
					});
				  }
			  }
			  
		  })
	  }
	</script>
</body>
</html>