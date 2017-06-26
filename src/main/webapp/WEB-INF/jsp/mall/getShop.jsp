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
				<c:forEach var="item" items="${shopList}" varStatus="index">
					<div class="Cart">
						<a href="javascript:;" class="select-btn select-btn-t"><img
							src="${path}/images/shop.png">${item.shop_name}</a>
					</div>
					<article class="confirmOrder" id="article_${item.shop_id }">
						<img src="${path}/shopPic/${item.shop_pic}">
						<div class="product-text">
							<span class="address">店址：${item.address}</span> <span class="hue"
								style="margin-top: 0.5rem;">电话：${item.shop_phone}</span> <span
								style="text-align: right; margin-top: 0.5rem;"> <a
								href="javascript:;" onclick="selectShop('${item.shop_id}')"
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
<div id="selectMapPointDiv" style="display:none;">
</div>	
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
		var map = new BMap.Map("container");
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
	        var circle = new BMap.Circle(data.points[0],2000,{fillColor:"blue", strokeWeight: 1 ,fillOpacity: 0.3, strokeOpacity: 0.3});
	        map.addOverlay(circle);
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
					$("#selectMapPointDiv").empty().append($("#article_"+id).clone());
					layer.open({
						type: 1,
						title:'商店信息',
						area:['90%','35%'],
						content:$('#selectMapPointDiv'),
					}); 
				
					/* if(confirm("该店地址是："+address+",是否选择？")){
						selectShop(id);
					} */
				});
				map.addOverlay(marker);
			}else{
				alert("您选择地址没有解析到结果!");
			}
		}, "山东省");
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
						window.location.href = "${path}/mall/payOrder.do?type=1"
					}else if("1"==rs.code){
						layer.confirm(rs.code,{tilte:'提示',btn:['确定','取消']},function(){
							//结算数量够的
							window.location.href = "${path}/mall/payOrder.do?type=2"
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
	
</script>
</body>
</html>