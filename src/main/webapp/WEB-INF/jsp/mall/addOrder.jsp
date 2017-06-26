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
				<a href="${path}/mall/shopList.do"><i class="icon icon-return"></i></a>
				<h1>${shop.shop_name }</h1>
				<i class="icon icon-soso"></i>
			</div>
		</header>
		<div style="height: 2.5rem;"></div>
	</div>
	<!-- 精选促销 -->
	<article style="margin-bottom: 0;">
		<h1>店内商品</h1>
	</article>
	<div class="commodity-box">
		<ul class="commodity">
			<c:forEach var="item" items="${list}">
				<li>
						<img src="${address}/${item.goodsPic.pic_path}"> 
						<span>${item.goods.goods_name}
						</span> 
						<span class="price">￥${item.goods.new_price} <%-- <s>￥${item.goods.old_price}</s> --%></span>
						<button type="button" onclick="addCart('${item.goods.goods_id}','${item.goods.goods_name}','${item.goods.new_price}');" class="btn btn-primary btn-mini" >购买</button>
				</li>
			</c:forEach>
		</ul>
	</div>
	<div id="cartPage" style="display: none;">
		<input type="hidden" id="add_goods_id"/>
		<div  class="norms-content-t">名称：<span id="add_goods_name"></span></div>
		<div  class="norms-content-t">单价：<span id="add_goods_price"></span>&nbsp;元/斤</div>
		<div  class="norms-content-t">
			数量 ：<a class="addIcon"></a> <input id="add_goods_num" type="number" value="0" style="width: 50px;height: 30px;padding: 0px;margin: 0px;"/><a
				class="subIcon"></a>

		</div>
		<div class="norms-content-t"><input type="button" onclick="saveCart();" class="btn" value="增加"/></div>
	</div>
	
	<script type="text/javascript">
	  function addCart(id,name,price){
		  //先验证登录状态
		  userid = '${sessionScope.user.userid}';
		  if(''==userid){
			  alert("请先进行登录！",function(){
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
				  area: ['300px','300px'],
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
			  url:'${path}/mall/addOrderSave.do',
			  data:{'shop_id':'${shop.shop_id}','number':number,'goods_id':goods_id,'price':price,'amount':amount,'type':'${type}'},
			  success:function(rs){
				  if(null!=rs){
					layer.msg('加入成功！',{time:1000},function(){
						layer.closeAll();
						window.location.href = "${path}/mall/payOrder.do?type=${type}";
					});
				  }
			  }
			  
		  })
	  }
	</script>
</body>
</html>