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
		<h2 class="layui-colla-title">种类信息</h2>
		<div class="layui-colla-content layui-show">
			<div class="layui-form-item">
				<label class="layui-form-label">种类:</label>
				<div class="layui-input-inline">
					<input type="text" name="title" required
						value="${distributionInfo.kind }" disabled="disabled"
						class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">品级:</label>
				<div class="layui-input-inline">
					<input type="text" name="title" required
						value="${distributionInfo.grade }" disabled="disabled"
						class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">三品一标:</label>
				<div class="layui-input-inline">
					<input type="text" name="title" required
						value="${distributionInfo.spyb }" disabled="disabled"
						class="layui-input">
				</div>
			</div>
			<%-- <div class="layui-form-item">
				<label class="layui-form-label">单价:</label>
				<div class="layui-input-inline">
					<input type="text" name="title" required
						value="${detail.price }" disabled="disabled"
						class="layui-input">
				</div>
			</div> --%>
		</div>
	</div>
	<!--销售信息  -->
	<div class="layui-colla-item">
		<h2 class="layui-colla-title">销售信息</h2>
		<div class="layui-colla-content layui-show">
			<div class="layui-form-item">
				<label class="layui-form-label">销售单位:</label>
				<div class="layui-input-inline">
					<input type="text" name="title" required
						value="${distributionInfo.require_name }" disabled="disabled"
						class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">采购数量:</label>
				<div class="layui-input-inline">
					<input type="text" name="title" required
						value="${distributionInfo.require_num }" disabled="disabled"
						class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">地址:</label>
				<div class="layui-input-inline">
					<input type="text" name="title" required
						value="${xsdw.address }" disabled="disabled"
						class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">类型:</label>
				<div class="layui-input-inline">
					<input type="text" name="title" required
						<c:if test="${xsdw.type eq 'A' }">value="市场"</c:if>
						<c:if test="${xsdw.type eq '1' }">value="生产基地"</c:if>
						<c:if test="${xsdw.type eq '2' }">value="超市"</c:if>
						<c:if test="${xsdw.type eq '3' }">value="食堂"</c:if>
						<c:if test="${xsdw.type eq '4' }">value="济南合作单位"</c:if>
						<c:if test="${xsdw.type eq '5' }">value="供应基地"</c:if>
						<c:if test="${xsdw.type eq '6' }">value="饭店"</c:if>
						disabled="disabled" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">手机:</label>
				<div class="layui-input-inline">
					<input type="text" name="title" required
						value="${xsdw.phone }" disabled="disabled"
						class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				 <c:if test="${xsdw.video ne '' && xsdw.video!=null}">
				 	<label class="layui-form-label">视频:</label>
					<video src="${path }/video/${xsdw.video }" controls="controls" height="300" width="100%">
					</video>
				 </c:if>
			</div>
		</div>
	</div>
	<!--产地信息  -->
	<div class="layui-colla-item">
		<h2 class="layui-colla-title">产地信息</h2>
		<div class="layui-colla-content layui-show">
			<div class="layui-form-item">
				<label class="layui-form-label">产地名称:</label>
				<div class="layui-input-inline">
					<input type="text" name="title" required
						value="${ycd.name }" disabled="disabled"
						class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">产地地址:</label>
				<div class="layui-input-inline">
					<input type="text" name="title" required
						value="${ycd.address }" disabled="disabled"
						class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">产地类型:</label>
				<div class="layui-input-inline">
					<input type="text" name="title" required
						<c:if test="${ycd.type eq 'A' }">value="市场"</c:if>
						<c:if test="${ycd.type eq '1' }">value="生产基地"</c:if>
						<c:if test="${ycd.type eq '2' }">value="超市"</c:if>
						<c:if test="${ycd.type eq '3' }">value="食堂"</c:if>
						<c:if test="${ycd.type eq '4' }">value="济南合作单位"</c:if>
						<c:if test="${ycd.type eq '5' }">value="供应基地"</c:if>
						<c:if test="${ycd.type eq '6' }">value="饭店"</c:if>
						disabled="disabled" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">手机号:</label>
				<div class="layui-input-inline">
					<input type="text" name="title" required
						value="${ycd.phone }" disabled="disabled"
						class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				 <c:if test="${xsdw.video ne '' && xsdw.video!=null}">
				 	<label class="layui-form-label">产地视频:</label>
					<video src="${path }/video/${xsdw.video }" controls="controls" height="300" width="100%">
					</video>
				 </c:if>
			</div>
		</div>
	</div>
	<!--取样检验信息  -->
	<div class="layui-colla-item">
		<h2 class="layui-colla-title">取样检验</h2>
		<div class="layui-colla-content layui-show">
			<div class="layui-form-item">
				<label class="layui-form-label">取样员:</label>
				<div class="layui-input-inline">
					<input type="text" name="title" required
						value="${trace.test_name }" disabled="disabled"
						class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				 <c:if test="${trace.sampling_video ne '' &&trace.sampling_video != null}">
				 	<label class="layui-form-label">取样视频:</label>
					<video src="${path }/testVideo/${trace.sampling_video}" controls="controls" height="300" width="100%">
					</video>
				 </c:if>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">检验员:</label>
				<div class="layui-input-inline">
					<input type="text" name="title" required
						value="${trace.test_user }" disabled="disabled"
						class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">检验结果:</label>
				<div class="layui-input-inline">
					<input type="text" name="title" required
						value="农残检验合格" disabled="disabled"
						class="layui-input">
				</div>
			</div>
			<c:if test="${trace.ycdzm ne '' && trace.ycdzm != null}">
			<div class="layui-form-item">
				<label class="layui-form-label">原产地证明:</label>
				<div class="layui-input-inline">
					<img alt="原产地证明" src="${path}/ycdzm/${trace.ycdzm}" style="width: 90%;height: 300px;">
				</div>
			</div>
			</c:if>
		</div>
	</div>
	<!--采购信息  -->
	<div class="layui-colla-item">
		<h2 class="layui-colla-title">采购信息</h2>
		<div class="layui-colla-content layui-show">
			<div class="layui-form-item">
				<label class="layui-form-label">供应商:</label>
				<div class="layui-input-inline">
					<input type="text" name="title" required
						value="${trace.farmer_name }" disabled="disabled"
						class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">手机号:</label>
				<div class="layui-input-inline">
					<input type="text" name="title" required
						value="${trace.farmer_phone}" disabled="disabled"
						class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">采购员:</label>
				<div class="layui-input-inline">
					<input type="text" name="title" required
						value="${trace.purchase_user }" disabled="disabled"
						class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">采购时间:</label>
				<div class="layui-input-inline">
					<input type="text" name="title" required
						value="${trace.purchase_time  }" disabled="disabled"
						class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">运输员:</label>
				<div class="layui-input-inline">
					<input type="text" name="title" required
						value="${trace.transport_user }" disabled="disabled"
						class="layui-input">
				</div>
			</div>
		</div>
	</div>
	<!--配送运输信息  -->
	<div class="layui-colla-item">
		<h2 class="layui-colla-title">配送信息</h2>
		<div class="layui-colla-content layui-show">
			<div class="layui-form-item">
				<label class="layui-form-label">配送数量:</label>
				<div class="layui-input-inline">
					<input type="text" name="title" required
						value="${detail.distribution_num }" disabled="disabled"
						class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">配送员:</label>
				<div class="layui-input-inline">
					<input type="text" name="title" required
						value="${detail.distribution_user }" disabled="disabled"
						class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">手机号:</label>
				<div class="layui-input-inline">
					<input type="text" name="title" required
						value="${detail.phone }" disabled="disabled"
						class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">配送车辆:</label>
				<div class="layui-input-inline">
					<input type="text" name="title" required
						value="${detail.distribution_car }" disabled="disabled"
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