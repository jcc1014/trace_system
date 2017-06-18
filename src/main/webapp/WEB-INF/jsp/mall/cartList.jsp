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
</style>
</head>
<body>
	<!--头部 header-->
	<div>
		<header>
			<div class="header">
				<a href="${path}/mall/mall_index.do"><i class="icon icon-return"></i></a>
				<h1>购物车</h1>
				<a href="javaScript:void(0);" class="cart-edit" id="edit" onclick="editCart();">编辑</a>
			</div>
		</header>
		<div style="height: 2.5rem;"></div>
	</div>
	<!-- 购物车 -->
	<form class="setCmp">
		<c:forEach var="item" items="${list}">
			<div class="Cart">
				<div class="payment" >
					<input type="radio" class="radio-la" value="" id="${item.order.order_id }"
						name="radio_${item.order.order_id }"> <label for="${item.order.order_id }"></label>
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
				</div>
			</article>
		</c:forEach>
	</form>
	<nav class="navbar-fixed-bottom navbar-fixed-bottom-cart">
		<div class="container container-cart">
			<div class="navbar-text navbar-left pull-left m-cart-disbursement">
				合计：￥${sum_amount}</div>
			<a href="javascript:;" class="btn btn-warning navbar-btn pull-right" id="checkout">去结算</a>
			<a href="javascript:;" class="btn btn-warning navbar-btn pull-right hide" id="del_btn" onclick="del();">删除</a>
		</div>
	</nav>
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
function editCart(){
	var edit = $("#edit").html();
	if("编辑"==edit){
		$("#edit").html("完成");
		$("#del_btn").removeClass("hide");
		$("#checkout").addClass("hide");
	}else{
		$("#edit").html("编辑");
		$("#del_btn").addClass("hide");
		$("#checkout").removeClass("hide");
	}
}

function del(){
	var ids = $("input[type='radio']:checked");
	if(ids.length>0){
		var str = "";
		$.each(ids,function(i,obj){
			str += $(this).attr("id")+";";
		})
		str = str.substr(0,str.length-1);
		//layer.msg(str);
		$.ajax({
			url:'${ctx}/mall/delCart.do',
			type:'post',
			data:{'order_ids':str},
			success:function(rs){
				if(null!=rs&&""!=rs){
					layer.msg("删除成功！",{time:1000},function(){
						window.location.ref = '${path}/mall/getCartList.do';
					});
				}
			}
		})
	}else{
		layer.msg('请先选中再删除！',{time:1000});
		return;
	}
}

</script>
</body>
</html>