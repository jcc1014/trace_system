<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
  <style type="text/css">
  body, html,#allmap {width: 100%;height: 100%;overflow: hidden;margin:0;font-family:"微软雅黑";}
  </style>
  <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=6GGn0bxXgdfWXVoynp7bijkg4G3FXV9h"></script>  
  <script>

           function getLocation(){
               var options={
                   enableHighAccuracy:true, 
                   maximumAge:1000
               }
               if(navigator.geolocation){
                   //浏览器支持geolocation
                   navigator.geolocation.getCurrentPosition(onSuccess,onError,options);
                   
               }else{
                   alert("浏览器不支持geolocation");
               }
           }

           //成功时
           function onSuccess(position){
               //返回用户位置
               //经度
               var longitude =position.coords.longitude;
               //纬度
               var latitude = position.coords.latitude;
               //使用百度地图API
               //创建地图实例  
               var map =new BMap.Map("container");

               //创建一个坐标
               var point =new BMap.Point(longitude,latitude);
               //地图初始化，设置中心点坐标和地图级别  
               map.centerAndZoom(point,15);
               var size = new BMap.Size(10, 20);
                mp.addControl(new BMap.CityListControl({
                    anchor: BMAP_ANCHOR_TOP_LEFT,
                    offset: size,
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
           function onError(error){
               switch(error.code){
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

           window.onload=getLocation;
   </script>
</head>
<body>
  

   <div id="container" style="width:1000px;height:800px"></div>
</body>
</html>