<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
<style type="text/css">
body, html, #allmap {
	width: 100%;
	height: 100%;
	overflow: hidden;
	margin: 0;
	font-family: "微软雅黑";
}
</style>
<script type="text/javascript" src="${path}/js/jquery.min.js"></script>
<script type="text/javascript"
	src="http://api.map.baidu.com/api?v=2.0&ak=6GGn0bxXgdfWXVoynp7bijkg4G3FXV9h"></script>
<script>
window.onload = getLocation;
function getLocation() {
	//创建地图实例  
	var map = new BMap.Map("container");
	var address = $("#address",window.parent.document).val();
	geocoder(map,address);
}

function geocoder(map,address){
	// 创建地址解析器实例
	var myGeo = new BMap.Geocoder();
	// 将地址解析结果显示在地图上,并调整地图视野
	myGeo.getPoint(address, function(point){
		if (point) {
			map.centerAndZoom(point, 14);
			var marker = new BMap.Marker(point);
			map.addOverlay(marker);
			marker.addEventListener("click",function(){
				if(confirm("该店地址是："+address+",是否选择？")){
					$("#shop_coordinate",window.parent.document).val(point.lng+";"+point.lat);
					parent.closeLayer();
				}
			});
		}else{
			alert("您选择地址没有解析到结果!");
		}
	}, "山东省");
}



</script>
</head>
<body>
	
   <div id="container" style="width: 100%;height: 90%;"></div>
</body>
</html>