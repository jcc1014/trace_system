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
<link rel="stylesheet" type="text/css" href="${path}/css/ui.css">
<!-- <link href="favicon.ico" type="image/x-icon" rel="icon">
<link href="iTunesArtwork@2x.png" sizes="114x114" rel="apple-touch-icon-precomposed"> -->
<link href="${path}/css/bass.css" rel="stylesheet" />
<link href="${path}/css/style.css" rel="stylesheet" />
<link rel="stylesheet" href="${path}/layui/css/layui.css">
<!-- 引入js资源 -->
<script type="text/javascript" src="${path}/layui/layui.js"></script>
<script type="text/javascript" src="${path}/js/jquery.min.js"></script>
<script src="${path}/js/vendor/jquery.ui.widget.js"></script>
<script src="${path}/js/jquery.iframe-transport.js"></script>
<script src="${path}/js/jquery.fileupload.js"></script>
<style type="text/css">
.bar {
    height: 18px;
    background: #0c73cc;
}
.hide{display: none;}
</style>
</head>
<body>
	<!-- 个人中心 -->
	<article class="user-head">
	<div class="user-bg-img">
		<img src="${path}/images/user_bg.png">
		<div class="user-img">
			<img style="height:100%" id="my_pic" src="${path}/uploadPic/${sessionScope.member.photo}">
		</div>
	</div>
	<div class="user-order">
		<%-- <a href="javascript:;" class="select-btn select-btn-t"><img
			src="${path}/images/indent.png">我的订单 <span onclick="getOrder('')">查看所有订单</span> <i
			class="icon icon-select"></i></a> --%>
	</div>
	<div class="user-nav">
		<a href="javascript:;'" onclick="getOrder('1')"> <i class="icon icon-f1"></i> 待付款</a> 
		<a href="javascript:;" onclick="getOrder('2')"> <i class="icon icon-f2"></i> 待收货</a> 
		<a href="javascript:;" onclick="getOrder('3')"> <i class="icon icon-f3"></i> 已收货</a>
	</div>

	</article>

	<article class="user-list"> 
		<a href="${path}/mall/address_list.do" class="select-btn select-btn-t">
			<img src="${path}/images/collct.png">收货地址 <i class="icon icon-select"></i>
		</a> 
		<a href="javascript:;" class="select-btn select-btn-t" onclick="commity();">
		<img src="${path}/images/service.png">我的社区<i class="icon icon-select"></i>
		</a>
		<a href="javascript:;" class="select-btn select-btn-t">
		<img src="${path}/images/about.png">关于我们<i class="icon icon-select"></i>
		</a>
		<a href="${path}/mall/personal_setting.do" class="select-btn select-btn-t">
		<img src="${path}/images/set.png">个人设置<i class="icon icon-select"></i>
		</a> 
		<a href="${path}/mall/logout.do" class="select-btn select-btn-t">
		<img src="${path}/images/logout.png">切换账号<i class="icon icon-select"></i>
		</a> 
	</article>

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
		<a href="${path}/mall/getCartList.do"> <i class="icon icon-f3"></i> 
			购物车
		</a>
		<a href="${path}/mall/user.do" class="pick"> <i class="icon icon-f4"></i>
			 我
		</a>
	</footer>
<script type="text/javascript">
function commity(){
	layer.msg('社区暂未开放，请等候通知！');
}

function setup(){
	window.location.href="${path}/mall/personalInfo.do";
}

function about(){
	window.location.href = "${path}/mall/about.do"
}

function getOrder(type){
	window.location.href = "${path}/mall/myOrder.do?status="+type;
}

</script>
</body>

</html>