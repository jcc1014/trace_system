<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>配送系统</title>
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
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=6GGn0bxXgdfWXVoynp7bijkg4G3FXV9h"></script>  
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
#r-result,#r-result table{width:100%;}
</style>
</head>
<body>

	<!--头部 header-->

	<div>
		<header>
			<div class="header">
				<!-- <a href="#"><i class="icon icon-menu"></i></a> -->
				<h1>地图</h1>
				<!-- <i class="icon icon-soso"></i> -->
			</div>
		</header>
		<div style="height: 2.5rem;"></div>
	</div>
	<!--中间容器  -->
	<div id="map" style="width:100%;height: 300px;">
	<div id="r-result" style="height: 300px;display: none;"></div>
		
		
	</div>
	<!-- footer 底部菜单 -->
	<footer>
		<a href="${path}/carry/map.do" class="pick"> <i class="icon icon-f1"></i>
			首页
		</a> 
		<a href="${path}/carry/shopList.do"> <i class="icon icon-f2"></i>
			 我的
		</a>
		<a href="${path}/mall/getCartList.do"> <i class="icon icon-f3"></i> 
			历史
		</a>
		<a href="${path}/mall/user.do"> <i class="icon icon-f4"></i>
			 设置
		</a>
	</footer>
	<script type="text/javascript">
	function getLocation() {
		var options = {
			enableHighAccuracy : true,
			maximumAge : 1000,
			timeout: 5000
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
		var longitude = position.coords.longitude; //经度
		var latitude = position.coords.latitude; //纬度
		
		//创建地图实例  
		var map = new BMap.Map("map");
		//创建一个坐标
		var point = new BMap.Point(longitude, latitude);
		//addMarker(point);
		//地图初始化，设置中心点坐标和地图级别  
		map.centerAndZoom(point, 14);
		var size = new BMap.Size(10, 20);
		map.addControl(new BMap.CityListControl({
			anchor : BMAP_ANCHOR_TOP_LEFT,
			offset : size,
		}));
		//定位控件
		var geolocationControl = new BMap.GeolocationControl();
		geolocationControl.addEventListener("locationSuccess", function(e){
		    // 定位成功事件
		    var address = '';
		    address += e.addressComponent.province;
		    address += e.addressComponent.city;
		    address += e.addressComponent.district;
		    address += e.addressComponent.street;
		    address += e.addressComponent.streetNumber;
		    alert("当前定位地址为：" + address);
		  });
		  geolocationControl.addEventListener("locationError",function(e){
		    // 定位失败事件
		    alert(e.message);
		  });
		  map.addControl(geolocationControl);
		
		//坐标转换完之后的回调函数
	    translateCallback = function (data){
	      if(data.status === 0) {
	        var myIcon = new BMap.Icon("${path}/images/marker2.png",
	        		new BMap.Size(30,30));
	        var marker = new BMap.Marker(data.points[0],{icon:myIcon});
	        map.addOverlay(marker);
	        marker.setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画
	        map.setCenter(data.points[0]);
	        /* var circle = new BMap.Circle(data.points[0],2000,{fillColor:"blue", strokeWeight: 1 ,fillOpacity: 0.3, strokeOpacity: 0.3});
	        map.addOverlay(circle); */
	      }
	    }

	    setTimeout(function(){
	        var convertor = new BMap.Convertor();
	        var pointArr = [];
	        pointArr.push(point);
	        convertor.translate(pointArr, 1, 5, translateCallback)
	    }, 1000);
	    
	    getMapShop(map);

	}
	
	function geocoder(map,address,id){
		// 创建地址解析器实例
		var myGeo = new BMap.Geocoder();
		// 将地址解析结果显示在地图上,并调整地图视野
		myGeo.getPoint(address, function(point){
			if (point) {
				var myIcon = new BMap.Icon("${path}/images/marker_shop2.png",
			        		new BMap.Size(30,30));
				var marker = new BMap.Marker(point,{icon:myIcon});
				marker.addEventListener("click",function(){
					layer.open({
						type: 2,
						title:'商店信息',
						area:['90%','35%'],
						content:'${path}/carry/getShopOrder.do?id='+id,
					}); 
				
					/* if(confirm("该店地址是："+address+",是否选择？")){
						selectShop(id);
					} */
				});
				map.addOverlay(marker);
			}else{
				alert("您选择地址没有解析到结果!");
			}
		}, "济南市");
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
	
	function selectShop(id){
		//检查此店订单是否满足
		$.ajax({
			url:'${path}/mall/checkOrder.do',
			type:'post',
			data:{'shop_id':id},
			success:function(rs){
				if(""!=rs){
					rs = $.parseJSON($.parseJSON(rs));
					if("200"==rs.code){
						window.location.href = "${path}/mall/payOrder.do?type=1&shop_id="+id
					}else if("1"==rs.code){
						layer.confirm(rs.code,{tilte:'提示',btn:['确定','取消']},function(){
							//结算数量够的
							window.location.href = "${path}/mall/payOrder.do?type=2&shop_id"+id
						},function(){
							layer.closeAll();
						})
					}else if("-1"==rs.code){
						layer.msg(rs.msg,{time:2000});
					}else{
						layer.msg("出错了，请稍后再试！",{time:2000});
					}
				}
			}
		})
	}
	
	function getMapShop(map){
		var json = $.parseJSON('${shopJson}');
		$.each(json,function(i,obj){
			geocoder(map,obj.address,obj.shop_id);
		})
	}
	
	function route(map,start,end){
		/* var walking = new BMap.WalkingRoute(map, {renderOptions: {map: map, panel: "r-result", autoViewport: true}});
		walking.search("祝甸西", "泉城广场");
		layer.open({
			type: 1,
			title:'信息',
			area:['90%','35%'],
			content:$('#r-result'),
		}); */
	}
	</script>
</body>
</html>