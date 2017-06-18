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
				<a href="${path}/mall/mall_index.do"><i class="icon icon-return"></i></a>
				<h1>商品详情</h1>
			</div>
		</header>
		<div style="height: 2.5rem;"></div>
	</div>
	<div class="product-head">
		 <img src="${address}/${goodsPic.pic_path}"> 
	</div>
	<article class="product-text">
		<span>${goods.goods_name}</span> <span class="price">￥${goods.new_price} <s>￥${goods.old_price}</s></span>
	</article>
	<!-- <a id="norms" href="javascript:;" class="select-btn select-btn-s">选择规格<i
		class="icon icon-select"></i></a> -->
	<!-- 选择规格 -->
	<!-- <div class="norms-box">

		<div class="norms-box-bg"></div>

		<div class="norms-content">

			<div class="norms-content-t norms-content-one">

				<div class="norms-img">
					<img src="images/cp_gg.png">
				</div>

				<div class="norms-c-text">

					<span>首款海绵包包</span> <span class="price">￥68.00 <s>$75.00</s></span>

				</div>

				<div class="norms-off-btn">
					<img src="images/off_btn.png">
				</div>

			</div>

			<div class="norms-content-t norms-content-two">

				数量 <span class="icon norms-out"></span> <span>1</span> <span
					class="icon norms-add"></span>

			</div>

			<div class="norms-content-three">

				颜色<br> <span class="pick">黑色</span> <span>白色</span>

			</div>

		</div>

	</div> -->
	<!-- <a href="javascript:;" class="select-btn select-btn-t"><img
		src="images/sjlogo.png">海绵包包 <i class="icon icon-select"></i></a>

	<a href="javascript:;" class="select-btn select-btn-t select-btn-d"><img
		src="images/tel.png">020-8888-8888</a> -->
	<!-- 详情内容 product-content -->
	<div class="product-content">

		<ul id="tab_btn" class="product-content-ul">

			<li class="pick"><span>超市列表</span></li>

			<li><span>地图显示</span></li>

		</ul>

		<ul class="product-content-ul2">

			<li class="tab_content show">
			<!--商店列表  -->
			<c:forEach var="item" items="${list}">
				<div>
					<div>${item.shop.shop_name}</div>
					<div>${item.shop.shop_address}</div>
					<div>选择</div>
				</div>
			</c:forEach>
			</li>

			<li class="tab_content">
				<div style="width: 100%;height: 500px;">
					<iframe src="${path}/mall/map.do" width="100%;" height="100%;"></iframe>
				</div>
			</li>

		</ul>

	</div>

	<!-- 加入购物车底部 -->

	<!-- <div class="add-shopping">

		<a href="javascript:;" class="shopping-btn"> <em>2</em> <i
			class="icon icon-car"></i>

		</a> <a href="confirmOrder.html" class="btn btn-red fr">立即购买</a> <a
			href="javascript:;" class="btn btn-yellow fr">加入购物车</a>

		<div class="cl"></div>

	</div> -->

	<!-- 引入js资源 -->

	<script type="text/javascript" src="${path}/js/zepto.min.js"></script>
	<script type="text/javascript">
	    //TAB切换
	    var tab_Btns_box=document.getElementById('tab_btn');
	    var tab_Btns=tab_Btns_box.getElementsByTagName('li');
	    var tab_contents=document.getElementsByClassName('tab_content');
	    for(var i=0;i<tab_Btns.length;i++){
	    tab_Btns[i].index=i;
	    tab_Btns[i].onclick=function(){
	     for(var i=0;i<tab_Btns.length;i++){
		     if(i!==this.index){
		     	tab_Btns[i].classList.remove('pick')
		     }
	     }
	     tab_Btns[this.index].className="pick";
	     for(var j=0;j<tab_contents.length;j++){
		     if(j!==this.index){
		         tab_contents[j].classList.remove('show');
		     }
	         tab_contents[this.index].classList.add('show');
	     }
	    }
	    }

	</script>

	<script type="text/javascript">

        $(document).ready(function(){

          $("#norms").click(function(){

          $(".norms-box").show();

          });

          $(".norms-box-bg").click(function(){

          $(".norms-box").hide();

          });

          $(".norms-off-btn").click(function(){

          $(".norms-box").hide();

          });

        });

    </script>

</body>

</html>