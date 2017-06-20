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
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=6GGn0bxXgdfWXVoynp7bijkg4G3FXV9h"></script>  
<style type="text/css">
.confirmOrder img {
    width: 4.0rem;
    height: 4.0rem;
    float: left;
    margin-right: .5rem;
}
.hide{display: none;}
#edit:FOCUS{color: #fff;}
.Cart .select-btn-t {
    padding-left: 2.5rem;
}
.Cart .select-btn-t img {
    left: .45rem;
}
.product-text span {
    display: initial;
    color: #1a1a1a;
    line-height: 1.0rem;
    font-size: 0.85rem;
    display: -webkit-box;
    -webkit-line-clamp: 2; 
    -webkit-box-orient: vertical;
    text-overflow: clip !important;
    overflow: visible;
</style>
</head>
<body>
	<!--头部 header-->
	<div>
		<header>
			<div class="header">
				<a href="${path}/mall/mall_index.do"><i class="icon icon-return"></i></a>
				<h1>商家列表</h1>
			</div>
		</header>
		<div style="height: 2.5rem;"></div>
	</div>
	<ul id="tab_btn" class="product-content-ul">
		<li class="pick"><span>商家列表</span></li>
		<li><span>商家地图</span></li>
	</ul>
	<ul class="product-content-ul2">
		<li class="tab_content show">
			<form class="setCmp" style="margin-top: 0.5rem;">
				<c:forEach var="item" items="${shopList}">
					<div class="Cart">
						<a href="javascript:;" class="select-btn select-btn-t"><img
							src="${path}/images/sjlogo.png">${item.shop_name}</a>
					</div>
					<article class="confirmOrder">
						<img src="${path}/images/cp_gg.png">
						<div class="product-text">
							<span class="address">店址：${item.address}</span> <span class="hue"
								style="margin-top: 0.5rem;">电话：${item.shop_phone}</span> <span
								style="text-align: right; margin-top: 0.5rem;"> <a
								href="${path}/mall/shopGoodsList.do?shop_id=${item.shop_id}"
								class="btn btn-primary">选择</a>
							</span>
						</div>
					</article>
				</c:forEach>
			</form>
		</li>
		<li class="tab_content">商家地图
			<div id="container" style="width: 100%;height: 500px;"></div>
		</li>
	</ul>
	
<script type="text/javascript">

	//TAB切换
	var tab_Btns_box = document.getElementById('tab_btn');
	var tab_Btns = tab_Btns_box.getElementsByTagName('li');
	var tab_contents = document.getElementsByClassName('tab_content');
	for (var i = 0; i < tab_Btns.length; i++) {
		tab_Btns[i].index = i;
		tab_Btns[i].onclick = function() {
			for (var i = 0; i < tab_Btns.length; i++) {
				if (i !== this.index) {
					tab_Btns[i].classList.remove('pick')
				}
			}
			tab_Btns[this.index].className = "pick";
			for (var j = 0; j < tab_contents.length; j++) {
				if (j !== this.index) {
					tab_contents[j].classList.remove('show');
				}
				tab_contents[this.index].classList.add('show');
			}
		}
	}
	function getLocation() {
		var options = {
			enableHighAccuracy : true,
			maximumAge : 1000
		}
		if (navigator.geolocation) {
			//浏览器支持geolocation
			navigator.geolocation.getCurrentPosition(onSuccess, onError,
					options);

		} else {
			alert("浏览器不支持geolocation");
		}
	}

	//成功时
	function onSuccess(position) {
		//返回用户位置
		//经度
		var longitude = position.coords.longitude;
		//纬度
		var latitude = position.coords.latitude;
		//使用百度地图API
		//创建地图实例  
		var map = new BMap.Map("container");

		//创建一个坐标
		var point = new BMap.Point(longitude, latitude);
		//addMarker(point);
		//地图初始化，设置中心点坐标和地图级别  
		map.centerAndZoom(point, 15);
		var marker = new BMap.Marker(point);
		map.addOverlay(marker);
		var size = new BMap.Size(10, 20);
		var convertor = new BMap.Convertor();
	    var pointArr = [];
	    pointArr.push(point);
	    convertor.translate(pointArr, 1, 5, translateCallback)
		 //坐标转换完之后的回调函数
	    translateCallback = function (data){
	      if(data.status === 0) {
	        var marker = new BMap.Marker(data.points[0]);
	        bm.addOverlay(marker);
	        var label = new BMap.Label("转换后的百度坐标（正确）",{offset:new BMap.Size(20,-10)});
	        marker.setLabel(label); //添加百度label
	        bm.setCenter(data.points[0]);
	      }
	    }

		mp.addControl(new BMap.CityListControl({
			anchor : BMAP_ANCHOR_TOP_LEFT,
			offset : size,
		// 切换城市之间事件
		// onChangeBefore: function(){
		//    alert('before');
		// },
		// 切换城市之后事件
		// onChangeAfter:function(){
		//   alert('after');
		// }
		}));

	}

	//失败时
	function onError(error) {
		switch (error.code) {
		case 1:
			alert("位置服务被拒绝");
			break;

		case 2:
			alert("暂时获取不到位置信息");
			break;

		case 3:
			alert("获取信息超时");
			break;

		case 4:
			alert("未知错误");
			break;
		}

	}
	
	// 编写自定义函数,创建标注
	function addMarker(point){
	  var marker = new BMap.Marker(point);
	  map.addOverlay(marker);
	}
	
	window.onload = getLocation;
</script>
</body>
</html>