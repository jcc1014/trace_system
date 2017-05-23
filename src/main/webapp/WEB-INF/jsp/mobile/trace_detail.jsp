<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>${sysname}</title>
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <link rel="stylesheet" href="${path}/layui/css/layui.css">
  <link rel="stylesheet" href="${path}/res/global.css">
  <script type="text/javascript" src="${path}/layui/layui.js"></script>
  <style type="text/css">
	label {
	width: 18% !important;
	}
	video{
		border: 1px solid #efefef;
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
    <h2 class="layui-colla-title">农户信息</h2>
    <div class="layui-colla-content layui-show">
		<div class="layui-form-item">
			    <label class="layui-form-label">姓名:</label>
			    <div class="layui-input-inline">
			      <input type="text" name="title" required  value="${farmer.farmer_name}" autocomplete="off" class="layui-input">
			    </div>
		</div>
		<div class="layui-form-item">
			    <label class="layui-form-label">手机号:</label>
			    <div class="layui-input-inline">
			      <input type="text" name="title" required  value="${farmer.farmer_phone}" autocomplete="off" class="layui-input">
			    </div>
		</div>
		<div class="layui-form-item">
			    <label class="layui-form-label">合作社:</label>
			    <div class="layui-input-inline">
			      <input type="text" name="title" required  value="${farmer.farmer_hzs}" autocomplete="off" class="layui-input">
			    </div>
		</div>
		<div class="layui-form-item">
			 <c:if test="${farmerVideo ne '' && farmerVideo!=null}">
					<video src="${path }/video/${farmerVideo }" controls="controls" height="300" width="100%">
					</video>
			 </c:if>
			    <!-- <div class="layui-input-inline" style="width: 100%!important;">
			    </div> -->
		</div>
    </div>
  </div>
  <div class="layui-colla-item">
    <h2 class="layui-colla-title">采购信息</h2>
    <div class="layui-colla-content layui-show">
		<div class="layui-form-item">
			    <label class="layui-form-label">采购人:</label>
			    <div class="layui-input-inline">
			      <input type="text" name="title" required  value="${purchase.purchase_name}" autocomplete="off" class="layui-input">
			    </div>
		</div>
		<div class="layui-form-item">
			    <label class="layui-form-label">采购种类:</label>
			    <div class="layui-input-inline">
			      <input type="text" name="title" required  value="${purchase.purchase_type}" autocomplete="off" class="layui-input">
			    </div>
		</div>
		<div class="layui-form-item">
			    <label class="layui-form-label">采购数量:</label>
			    <div class="layui-input-inline">
			      <input type="text" name="title" required  value="${purchase.purchase_num}" autocomplete="off" class="layui-input">
			    </div>
		</div>
		<div class="layui-form-item">
			    <label class="layui-form-label">采购时间:</label>
			    <div class="layui-input-inline">
			      <input type="text" name="title" required  value="${purchase.purchase_time}" autocomplete="off" class="layui-input">
			    </div>
		</div>
		<div class="layui-form-item">
			    <!-- <div class="layui-input-inline" style="width: 100%!important;">
			    </div> -->
			    <c:if test="${pruchaseVideo ne ''&& pruchaseVideo != null}">
					<video src="${path }/video/${pruchaseVideo}" controls="controls" height="300" width="100%">
					</video>
			    </c:if>
			    
		</div>
    </div>
  </div>
  <div class="layui-colla-item">
    <h2 class="layui-colla-title">检验信息</h2>
    <div class="layui-colla-content layui-show">
		<div class="layui-form-item">
			    <label class="layui-form-label">检验人:</label>
			    <div class="layui-input-inline">
			      <input type="text"  required  value="${test.test_name}" autocomplete="off" class="layui-input">
			    </div>
		</div>
		<div class="layui-form-item">
			    <label class="layui-form-label">检验时间:</label>
			    <div class="layui-input-inline">
			      <input type="text"  required  value="${test.test_time}" autocomplete="off" class="layui-input">
			    </div>
		</div>
		<div class="layui-form-item">
			    <label class="layui-form-label">机器编号:</label>
			    <div class="layui-input-inline">
			      <input type="text"  required  value="${test.test_machine}" autocomplete="off" class="layui-input">
			    </div>
		</div>
		<div class="layui-form-item">
			    <label class="layui-form-label">检验结果:</label>
			    <div class="layui-input-inline">
			      <input type="text"  required  value="${test.test_result}" autocomplete="off" class="layui-input">
			    </div>
		</div>
		<div class="layui-form-item">
			    <label class="layui-form-label">结果影响:</label>
			    <div class="layui-input-inline">
			      <input type="text"  required  value="${test.test_influence}" autocomplete="off" class="layui-input">
			    </div>
		</div>
    </div>
  </div>
  <div class="layui-colla-item">
    <h2 class="layui-colla-title">抽检信息</h2>
    <div class="layui-colla-content layui-show">
		<div class="layui-form-item">
			    <label class="layui-form-label">抽检人:</label>
			    <div class="layui-input-inline">
			      <input type="text" name="title" required  value="${sampling.test_name}" autocomplete="off" class="layui-input">
			    </div>
		</div>
		<div class="layui-form-item">
			    <label class="layui-form-label">抽检时间:</label>
			    <div class="layui-input-inline">
			      <input type="text" name="title" required  value="${sampling.test_time}" autocomplete="off" class="layui-input">
			    </div>
		</div>
		<div class="layui-form-item">
			    <label class="layui-form-label">机器编号:</label>
			    <div class="layui-input-inline">
			      <input type="text" name="title" required  value="${sampling.test_machine}" autocomplete="off" class="layui-input">
			    </div>
		</div>
		<div class="layui-form-item">
			    <label class="layui-form-label">抽检结果:</label>
			    <div class="layui-input-inline">
			      <input type="text" name="title" required  value="${sampling.test_result}" autocomplete="off" class="layui-input">
			    </div>
		</div>
		<div class="layui-form-item">
			    <label class="layui-form-label">结果影响:</label>
			    <div class="layui-input-inline">
			      <input type="text" name="title" required  value="${sampling.test_influence}" autocomplete="off" class="layui-input">
			    </div>
		</div>
    </div>
  </div>
  <div class="layui-colla-item">
    <h2 class="layui-colla-title">运输信息</h2>
    <div class="layui-colla-content layui-show">
		<div class="layui-form-item">
			    <label class="layui-form-label">运输司机:</label>
			    <div class="layui-input-inline">
			      <input type="text" name="title" required  value="${transport.transport_user}" autocomplete="off" class="layui-input">
			    </div>
		</div>
		<div class="layui-form-item">
			    <label class="layui-form-label">车辆编号:</label>
			    <div class="layui-input-inline">
			      <input type="text" name="truck" required  value="${transport.transport_truck}" autocomplete="off" class="layui-input">
			    </div>
		</div>
		<div class="layui-form-item">
			    <label class="layui-form-label">目的地:</label>
			    <div class="layui-input-inline">
			      <input type="text" name="destination" required  value="${transport.transport_destination}" autocomplete="off" class="layui-input">
			    </div>
		</div>
    </div>
  </div>
</div>
  
<script>
layui.use(['element', 'layer'], function(){
  var element = layui.element();
  var layer = layui.layer;
  
  //监听折叠
  element.on('collapse(test)', function(data){
    layer.msg('展开状态：'+ data.show);
  });
});
</script>
<!-- Swiper JS -->
 <script src="${path}/dist/js/swiper.min.js"></script>

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
</script>
</body>
</html>