<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../common/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>追溯信息</title>
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <link rel="stylesheet" href="${path}/layui/css/layui.css">
  <link rel="stylesheet" href="${path}/res/global.css">
  <script type="text/javascript" src="${path}/layui/layui.js"></script>
  <style type="text/css">
	label {
	width: 20% !important;
	}
	video{
		border: 1px solid #ee394a;
	}
	footer{
		position: fixed;
	    right: 0;
	    bottom: 0;
	    left: 0;
	    padding: .25rem 0;
	    border-top: 1px solid #e6e6e6;
	    background-color:#ee394a;
		text-align: center;
		vertical-align: middle;
		color: #fff;
		line-height: 30px;
		font-size: 16px;
	}
  </style>
  <!-- Link Swiper's CSS -->
    <link rel="stylesheet" href="${path}/dist/css/swiper.min.css">

    <!-- Demo styles -->
    <style>
    html, body {
        position: relative;
        height: 100%;
    }
    body {
        background: #eee;
        font-family: Helvetica Neue, Helvetica, Arial, sans-serif;
        font-size: 14px;
        color:#000;
        margin: 0;
        padding: 0;
    }
    .swiper-container {
        width: 100%;
        height: 15%;
        
    }
    .swiper-slide {
        text-align: center;
        font-size: 18px;
        background: #fff;
        
        /* Center slide text vertically */
        display: -webkit-box;
        display: -ms-flexbox;
        display: -webkit-flex;
        display: flex;
        -webkit-box-pack: center;
        -ms-flex-pack: center;
        -webkit-justify-content: center;
        justify-content: center;
        -webkit-box-align: center;
        -ms-flex-align: center;
        -webkit-align-items: center;
        align-items: center;
    }
    </style>
  <!-- 注意：如果你直接复制所有代码到本地，上述css路径需要改成你本地的 -->
</head>
<body>
<div class="swiper-container">
        <div class="swiper-wrapper">
            <div class="swiper-slide"><img alt="1" src="${path}/images/gg1.jpg" width="100%" height="100%"/></div>
            <div class="swiper-slide"><img alt="2" src="${path}/images/gg2.jpg" width="100%" height="100%"/></div>
            <div class="swiper-slide"><img alt="3" src="${path}/images/gg3.jpg" width="100%" height="100%"/></div>
        </div>
        <!-- Add Pagination -->
        <div class="swiper-pagination"></div>
        <!-- Add Arrows -->
        <!-- <div class="swiper-button-next"></div>
        <div class="swiper-button-prev"></div> -->
</div>             
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  <legend>追溯信息</legend>
</fieldset>
<div class="layui-collapse" >
	<div class="layui-colla-item">
		<h2 class="layui-colla-title">采购信息</h2>
		<div class="layui-colla-content layui-show">
			<div class="layui-form-item">
				<label class="layui-form-label">种类:</label>
				<div class="layui-input-inline">
					<input type="text" name="title" required
						value="${meat.kind }" disabled="disabled"
						class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">品级:</label>
				<div class="layui-input-inline">
					<input type="text" name="title" required
						value="${meat.grade }" disabled="disabled"
						class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">生产厂家:</label>
				<div class="layui-input-inline">
					<input type="text" name="title" required
						value="${meat.sccj }" disabled="disabled"
						class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">入库时间:</label>
				<div class="layui-input-inline">
					<input type="text" name="title" required
						value="${meat.rksj }" disabled="disabled"
						class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">检测报告:</label>
				<div class="layui-input-inline">
					<img alt="检测报告" src="${path}/meat/${meat.jcbg}" style="width: 90%;height: 300px;">
				</div>
			</div>
		</div>
	</div>
	<div class="layui-colla-item">
		<h2 class="layui-colla-title">配送信息</h2>
		<div class="layui-colla-content layui-show">
			<div class="layui-form-item">
				<label class="layui-form-label">配送码:</label>
				<div class="layui-input-inline">
					<input type="text" name="title" required
						value="${psMeat.code }" disabled="disabled"
						class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">配送数量:</label>
				<div class="layui-input-inline">
					<input type="text" name="title" required
						value="${psMeat.num }" disabled="disabled"
						class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">姓名:</label>
				<div class="layui-input-inline">
					<input type="text" name="title" required
						value="${psMeat.xm }" disabled="disabled"
						class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">车牌号:</label>
				<div class="layui-input-inline">
					<input type="text" name="title" required
						value="${psMeat.cph }" disabled="disabled"
						class="layui-input">
				</div>
			</div>
		</div>
	</div>
<footer class="bottom" style="margin-top: 20px;">进入商城</footer>
	<script>
		layui.use([ 'element', 'layer' ], function() {
			var element = layui.element();
			var layer = layui.layer;

			//监听折叠
			element.on('collapse(test)', function(data) {
				layer.msg('展开状态：' + data.show);
			});
		});
	</script>
<!-- Swiper JS -->
 <script src="${path}/dist/js/swiper.min.js"></script>
<script src="${path}/js/jquery.min.js" type="text/javascript"></script>
<!-- Initialize Swiper -->
<script>
    var swiper = new Swiper('.swiper-container', {
        pagination: '.swiper-pagination',
        nextButton: '.swiper-button-next',
        prevButton: '.swiper-button-prev',
        paginationClickable: true,
        spaceBetween: 30,
        centeredSlides: true,
        autoplay: 2500,
        autoplayDisableOnInteraction: false
    });
    
    $(".bottom").on('click',function(){
    	window.location.href = "${path}/mall/mall_index.do"
    })
</script>
</body>
</html>