<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<!DOCTYPE HTML>
<html>
  <head>
    <meta charset="UTF-8">
    <title>${sysname }</title>
    <link rel="stylesheet" href="${path}/layui/css/layui.css">
    <link rel="stylesheet" href="${path}/res/global.css">
    <link rel="stylesheet" href="${path}/res/bootstrap.min.css">
    <link rel="stylesheet" href="${path}/res/city-picker.css">
    <script type="text/javascript" src="${path}/layui/layui.js"></script>
    <script type="text/javascript" src="${path}/js/commonUtil.js"></script>
    <script type="text/javascript" src="${path}/js/jquery.min.js"></script>
    <script type="text/javascript" src="${path}/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${path}/js/citypicker/city-picker.data.js"></script>
    <script type="text/javascript" src="${path}/js/citypicker/city-picker.js"></script>
    <!-- 百度地图api 秘钥=DD279b2a90afdf0ae7a3796787a0742e -->
    <script src="http://api.map.baidu.com/api?v=2.0&ak=DD279b2a90afdf0ae7a3796787a0742e" type="text/javascript"></script>
  </head>
 <body>
 <div class="layui-tab layui-tab-brief main-tab-container" style="margin-top: 20px;">
  	<ul class="layui-tab-title main-tab-title">
      <div class="main-tab-item">商家信息</div>
    </ul>
    
    <div class="layui-tab-content" style="margin-top: 40px;margin-left: 200px;">
			<form class="layui-form">
				<div class="layui-tab-item layui-show">
					<input type="hidden" name="id" value="">
					<div class="layui-form-item">
						<label class="layui-form-label">商家名称</label>
						<div class="layui-input-inline input-custom-width">
							<input type="text" id="shop_name" name="shop_name"
								 autocomplete="off" placeholder="请输入商家名"
								class="layui-input">
						</div>
					</div>
					<!-- <div class="layui-form-item">
						<label class="layui-form-label">所在地区</label>
						<div class="layui-input-inline input-custom-width">
							<input id="shoparea" class="layui-input" readonly autocomplete="off" name="shoparea"
								type="text" value="" data-toggle="city-picker">
						</div>
					</div> -->
					<div class="layui-form-item">
						<label class="layui-form-label">详细地址</label>
						<div class="layui-input-inline input-custom-width">
							<textarea id="address" style="resize:none;" placeholder="请输入商家详细地址" class="layui-textarea"></textarea>
						</div>
					</div>
					<!-- <div class="layui-form-item">
						<label class="layui-form-label">邮政编码</label>
						<div class="layui-input-inline input-custom-width">
							<input type="text" id="zipcode" name="zipcode"
								 autocomplete="off" placeholder="请输入邮编"
								class="layui-input">
						</div>
					</div> -->
					<div class="layui-form-item">
						<label class="layui-form-label">商家坐标</label>
						<div class="layui-input-inline input-custom-width">
							<input type="text" id="shop_coordinate" name="shop_coordinate"
								 autocomplete="off" placeholder="点击获取经纬度" readonly
								class="layui-input">
								<!-- <input type="text" id="getcoordinate" name="getcoordinate" 
								hidden="hidden" autocomplete="off"
								class="layui-input"> -->
						</div>
					</div>
					
					
					<div class="layui-form-item" style="margin-top: 50px;">
						<div class="layui-input-block">
							<button type="button" class="layui-btn" id="shop_save">保存</button>
							<!-- <button type="button" class="layui-btn layui-btn-primary" id="back">返回</button> -->
						</div>
					</div>
				</div>
			</form>
		</div>
		
		
</div>
<script type="text/javascript">
layui.use(
		[ 'element', 'form', 'upload', 'layedit', 'laydate' ],function() {
		var element = layui.element(), 
		form = layui.form(), 
		layedit = layui.layedit, 
		laydate = layui.laydate, 
		jq = layui.jquery;
		
	jq("#shop_coordinate").on('click',function() {
		if (navigator.geolocation) {
			var i =layer.load({offset: '45%',time: 300000}) ;
			navigator.geolocation.getCurrentPosition(function(position) {
				lat = position.coords.latitude;//经度
				lon = position.coords.longitude;//纬度
				layer.close(i);
				if(lat=="" || lat==null || lat==undefined || lon=="" || lon==null || lon==undefined){
					layer.msg("获取位置失败，请重试");
					return;
				}
				jq("#shop_coordinate").val("经度:"+lat+";纬度:"+lon);
				jq("#shop_coordinate").unbind("click");
				/* var point = new BMap.Point(lon, lat);    // 创建点坐标
				var gc = new BMap.Geocoder();
				gc.getLocation(point, function(rs){
       				var addComp = rs.addressComponents;
       				var getAddress = addComp.province+"/"+addComp.city+"/"+addComp.district;
       				jq("#getcoordinate").val(getAddress);
       			}); */
			});
		} else {
			layer.msg("您的浏览器不支持GPS定位");
		} 
	});
	
	jq("#shop_save").on('click',function(){
		var shopname = jq("#shop_name").val();
		//var shoparea = jq("#shoparea").val();
		var address = jq("#address").val();
		var shop_coordinate = jq("#shop_coordinate").val();
		//var zipcode = jq("#zipcode").val();
		//var getcoordinate = jq("#getcoordinate").val();
		if(shopname==null || shopname=="" || shopname==undefined){
			 layer.msg('请输入商家名称');
			 return;
		}
		/* if(shoparea==null || shoparea=="" || shoparea==undefined){
			layer.msg('请选择商家所在地区');
			return;
		}else if(shoparea.indexOf("/")==-1 || shoparea.match(new RegExp("/","g")).length<2){
			layer.msg('请完善商家所在地区');
			return;
		} */
		if(address==null || address=="" || address==undefined){
			layer.msg('请填写详细地址');
			return;
		}
		var re =/^[a-z\d\u4E00-\u9FA5]+$/i;
		if(!re.test(address)){
			layer.msg('详细地址不可包含特殊字符');
			return;
		}
		/* if(zipcode==null || zipcode=="" || zipcode==undefined){
			layer.msg('邮政编码不可为空');
			return;
		} */
		/* var re= /^[1-9][0-9]{5}$/;
		if(!re.test(zipcode)){
			layer.msg('邮政编码格式不正确，请重新输入');
			return;
		} */
		if(shop_coordinate==null || shop_coordinate=="" || shop_coordinate==undefined){
			layer.msg('商家坐标不可空，请重新加载');
			return;
		} 
		
		jq.ajax({
			url : '${path}/shop/addSave.do',
			type : 'post',
			data:{'address':address,'coordinate':shop_coordinate,'shop_name':shopname},
			dataType : 'json',
			success : function(rs) {
				rs = eval("(" + rs + ")");
				layer.msg(rs.msg,{time:1000}, function() {
					self.location.reload();
				});
			}
		})
	});
})
</script>
</body>
</html>
