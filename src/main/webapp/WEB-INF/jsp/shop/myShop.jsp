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
      <div class="main-tab-item">修改信息</div>
    </ul>
    
    <div class="layui-tab-content" style="margin-top: 40px;margin-left: 200px;">
			<form class="layui-form">
				<div class="layui-tab-item layui-show">
					<input type="hidden" name="id" value="">
					<div class="layui-form-item">
						<label class="layui-form-label">商店名称</label>
						<div class="layui-input-inline input-custom-width">
							<input type="text" id="shop_name" name="shop_name"
								 autocomplete="off" placeholder="请输入商店名称"
								class="layui-input" value="${shop.shop_name }">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">负责人姓名</label>
						<div class="layui-input-inline input-custom-width">
							<input type="text" id="username" name="username"
								 autocomplete="off" placeholder="请输入负责人"
								class="layui-input" value="${sessionScope.user.username}" 
								readonly="readonly">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">商店电话</label>
						<div class="layui-input-inline input-custom-width">
							<input type="text" id="shop_phone" name="shop_name"
								 autocomplete="off" placeholder="请输入商店电话"
								class="layui-input" value="${shop.shop_phone}">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">负责人手机</label>
						<div class="layui-input-inline input-custom-width">
							<input type="text" id="phone" name="shop_name"
								 autocomplete="off" placeholder="请输入负责人手机"
								class="layui-input" value="${sessionScope.user.phone }">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">详细地址</label>
						<div class="layui-input-inline input-custom-width">
							<textarea id="address" style="resize:none;" placeholder="请输入商家详细地址" class="layui-textarea"
							>${shop.address}</textarea>
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">商家坐标</label>
						<div class="layui-input-inline input-custom-width">
							<input type="text" id="shop_coordinate" name="shop_coordinate"
								 autocomplete="off" placeholder="点击获取经纬度" readonly
								class="layui-input" value="${shop.coordinate }">
						</div>
					</div>
					<div class="layui-form-item">
                        <label class="layui-form-label">上传图片</label>
                        <div class="layui-input-inline" style="width:113px;">
						    <input type="file" name="file" id="upload" class="layui-upload-file">
                        </div>
					</div>
                   <div class="layui-form-item" id="pic_display" style="display: none">
                            <label class="layui-form-label">已传图片</label>
                   </div>
					<div class="layui-form-item" id="pic_display">
						<label class="layui-form-label">已传图片</label>
						<div id="picDiv" class="layui-input-block">
							<input type="hidden" id="shop_pic" name="shop_pic" value="${shop.shop_pic }">
							<img class="input-custom-width" src="${path}/shopPic/${shop.shop_pic }" id="picImg"/>
							<div style="min-height: 10px"></div>
						</div>
					</div>
					
					<div class="layui-form-item" style="margin-top: 50px;">
						<div class="layui-input-block">
							<button type="button" class="layui-btn" id="shop_save">保存</button>
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
		var address = $("#address").val();
		if(""==address){
			layer.msg('请填写详细地址',{time:1000});
			return;
		}
		layer.open({
			type:2,
			title:'选择位置',
			closeBtn:1,
			area:['80%','80%'],
			content:['${path}/shop/selectAddress.do','no'],
		})
	});
	
	layui.upload({
        elem:'#upload',
        title:'点击上传',
        url : '${path}/upload/upload.do?path=shopPic',
        before: function(){
            index = layer.msg('图片上传中', {
                icon: 16
                ,shade: 0.01
            });
        },
        success : function(rs) {
            layer.close(index);
            if (rs.code == "success") {
                layer.msg('图片上传成功', {
                    icon: 1,
                    time: 2000 //2秒关闭（默认3秒）
                }, function(){
                	$("#shop_pic").val(rs.name);
                	$("#picImg").attr('src','${path}/shopPic/'+rs.name);
                });
               
            } else {
                layer.msg('图片上传失败' + rs.msg + ',请检查图片或重试', {
                    icon: 2,
                    time: 2000 //2秒关闭（默认3秒）
                }, function(){});
            }
        }
    });
	
	
	jq("#shop_save").on('click',function(){
		var shopname = jq("#shop_name").val();
		var phone = jq("#phone").val();
		var shop_phone = jq("#shop_phone").val();
		var address = jq("#address").val();
		var shop_coordinate = jq("#shop_coordinate").val();
		if(shopname==null || shopname=="" || shopname==undefined){
			 layer.msg('请输入商店名称',{time:1000});
			 return;
		}
		if(shop_phone==null || shop_phone==""){
			 layer.msg('请输入商店电话',{time:1000});
			 return;
		}
		if(!isTelephone(shop_phone)){
			 layer.msg('商店电话不合法',{time:1000});
			 return;
		}
		if(phone==null || phone==""){
			 layer.msg('请输入负责人手机',{time:1000});
			 return;
		}
		if(!isTelephone(phone)){
			 layer.msg('负责人电话不合法',{time:1000});
			 return;
		}
		if(address==null || address=="" || address==undefined){
			layer.msg('请填写详细地址');
			return;
		}
		var re =/^[a-z\d\u4E00-\u9FA5]+$/i;
		if(!re.test(address)){
			layer.msg('详细地址不可包含特殊字符');
			return;
		}
		if(shop_coordinate==null || shop_coordinate=="" || shop_coordinate==undefined){
			layer.msg('商家坐标不可空，请重新加载');
			return;
		}
		var shop_pic = $("#shop_pic").val();
		if(shop_pic==null || shop_pic=="" || shop_pic==undefined){
			layer.msg('请上传商店图片',{time:1000});
			return;
		}
		
		jq.ajax({
			url : '${path}/shop/editSave.do',
			type : 'post',
			data:{'address':address,'coordinate':shop_coordinate,'shop_name':shopname,
				'shop_phone':shop_phone,'phone':phone,'shop_id':'${shop.shop_id}','shop_pic':shop_pic},
			dataType : 'json',
			success : function(rs) {
				rs = eval("(" + rs + ")");
				if("200"==rs.code){
					layer.msg("修改商店成功！",{time:1000}, function() {
						self.location.reload();
					});
				}
			}
		})
	});
})

function closeLayer(){
	layer.closeAll();
}

</script>
</body>
</html>
