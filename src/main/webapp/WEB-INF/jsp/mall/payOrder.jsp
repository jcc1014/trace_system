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
.navbar-fixed-bottom-cart {
    bottom: 0rem;
}
</style>
</head>
<body>
	<!--头部 header-->
	<div>
		<header>
			<div class="header">
				<h1>结算订单</h1>
				<a href="javaScript:void(0);" class="cart-edit" id="edit" onclick="addOrder();">增加</a>
			</div>
		</header>
		<div style="height: 2.5rem;"></div>
	</div>
	<!-- 购物车 -->
	<form class="setCmp">
		<article class="confirmOrder">
				<div class="product-text">
					<div>收货人：${order_address.name}</div>
					<div>地址：${order_address.sheng}${order_address.shi}${order_address.qu}${order_address.address_detail}</div>
					<div>手机号：${order_address.phone}</div>
					<div>
						<input name="type" type="radio" value="1" checked="checked"/>送货上门
						&nbsp;&nbsp;&nbsp;
						<input name="type" type="radio" value="2"/>自取
					</div> 
				</div>
			</article>
		<c:forEach var="item" items="${list}">
			<div class="Cart">
				<div class="payment" >
					<input type="radio" data-status="0" class="radio-la" value="${item.order.amount}" id="${item.order.order_id }"
						name="radio_${item.order.order_id }" class="order" checked="checked" disabled="disabled"> <label for="${item.order.order_id }"></label>
				</div>
			</div>
			<article class="confirmOrder">
				<img src="${item.goodsPic.pic_path}" width="">
				<div class="product-text">
					<span>${item.goods.goods_name}</span>
					 <span class="price price-cart"> ￥${item.order.amount}
						<div class="norms-content-t norms-content-two">
							<!-- <span class="icon norms-out"></span>  -->
							<span style="width: 8rem">${item.order.number}	（斤）</span> 
							<!-- <span class="icon norms-add"></span> -->
						</div>
					</span>
					<span style="text-align: right;margin-top: 0.5rem;">
					<button type="button" class="btn btn-warning"
					 onclick="delOrder('${item.order.order_id}')">删除</button></span>
				</div>
			</article>
		</c:forEach>
			
	</form>
	<nav class="navbar-fixed-bottom navbar-fixed-bottom-cart">
		<div class="container container-cart">
			<div class="navbar-text navbar-left pull-left m-cart-disbursement">
				合计：￥<span id="sum">${sum_amount}</span></div>
			<a href="javascript:;" class="btn btn-warning navbar-btn pull-right" onclick="pay();" id="checkout">去结算</a>
		</div>
	</nav>
<script type="text/javascript">

function pay(){
	var radio = $("input[name='type']:checked");
	if(radio.length>0){
		var type = radio;
		var sum = $("#sum").html();
		//调用支付
		layer.confirm('确定支付吗？',{title:'支付',btn:['确定','取消']},function(){
			$.ajax({
				url:'${path}/mall/pay.do',
				type:'post',
				data:{'type':type.val(),'orderType':'${type}','shop_id':'${shop_id}'},
				success:function(rs){
					if(""!=rs){
						rs = $.parseJSON(rs);
						if(typeof(rs)!="object"){
							rs = $.parseJSON(rs);
						}
						layer.msg(rs.msg,{tiem:1000},function(){
							window.location.href = "${path}/mall/myOrder.do?status=2";
						})
					}
				}
			})
		},function(){
			layer.closeAll();
		})
		//支付成功
	} else {
		layer.msg('请先选择送货方式！', {
			time : 1000
		});
		return;
	}
}

function delOrder(order_id){
	layer.confirm('确定删除吗？',{title:'删除',btn:['确定','取消']},function(){
		$.ajax({
			url:'${path}/mall/delPayOrder.do',
			type:'post',
			data:{'order_id':order_id,'orderType':'${type}'},
			success:function(rs){
				if(""!=rs){
					rs = $.parseJSON(rs);
					if(typeof(rs)!="object"){
						rs = $.parseJSON(rs);
					}
					layer.msg(rs.msg,{time:1000},function(){
						if(""==rs.goods_orders&&"1"==rs.orderType){
							layer.msg('没有可以结算的商品！',{time:1000},function(){
								window.location.href = '${path}/mall/mall_index.do';
							})
						}else if(""==rs.enoughOrder&&"2"==rs.orderType){
							layer.msg('没有可以结算的商品！',{time:1000},function(){
								window.location.href = '${path}/mall/mall_index.do';
							})
						}
						else{
							self.location.reload();
						}
					})
				}
			}
		})
	},function(){
		layer.closeAll();
	})
}

function addOrder(){
	//转到增加订单页面 shopid,
	window.location.href = "${path}/mall/addOrder.do?shop_id=${shop_id}&type=${type}";
}
</script>
</body>
</html>