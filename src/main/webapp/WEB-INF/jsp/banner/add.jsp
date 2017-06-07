<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${sysname}</title>
<link rel="stylesheet" href="${path}/layui/css/layui.css">
<link rel="stylesheet" href="${path}/res/global.css">
<script type="text/javascript" src="${path}/js/jquery.min.js"></script>
<script type="text/javascript" src="${path}/layui/layui.js"></script>
<script type="text/javascript" src="${path}/js/commonUtil.js"></script>
<style type="text/css">
.layui-upload-button{position: relative;}
</style>
</head>
<body>
<div class="layui-tab layui-tab-brief main-tab-container" style="margin-top: 20px;">
    <ul class="layui-tab-title main-tab-title">
      <div class="main-tab-item">用户信息</div>
    </ul>
    <div class="layui-tab-content" style="margin-top: 40px;margin-left: 200px;">
			<form class="layui-form" id="form">
				<div class="layui-tab-item layui-show">
					<input type="hidden" name="id" value="">
					<div class="layui-form-item">
						<label class="layui-form-label">标题:</label>
						<div class="layui-input-inline input-custom-width">
							<input type="text" id="banner_title" name="banner_title"
								 autocomplete="off" placeholder="请输入标题"
								class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">跳转地址:</label>
						<div class="layui-input-inline input-custom-width">
							<input type="text" id="banner_url" name="banner_url" autocomplete="off"
								placeholder="请输入跳转地址" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">上传图片:</label>
						<div class="layui-input-inline input-custom-width">
							<input type="file" name="upload" id="upload" lay-type="file" lay-ext="png|jpg|jpeg" >
							<input type="text" class="hide" id="banner_path" name="banner_path"/>
							<span>(请上传750*320的图片)</span>
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">已传图片:</label>
						<div class="layui-input-inline input-custom-width">
							<img id="pic" src="${path}/banner/banner.png" width="375" height="160">
						</div>
					</div>
					
					<div class="layui-form-item" style="margin-top: 50px;">
						<div class="layui-input-block">
							<button type="button" class="layui-btn" id="save">保存</button>
							<button type="button" class="layui-btn layui-btn-primary" id="back">返回</button>
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

	jq("#save").on('click', function() {
		var banner_title = jq("#banner_title").val();
		if ("" == banner_title) {
			layer.msg("请填写标题！",{time:1000});
			return;
		}
		/* var banner_url = jq("#banner_url").val();
		if ("" == banner_url) {
			layer.msg("请填写url！");
			return;
		} */
		var banner_path = jq("#banner_path").val();
		if ("" == banner_path ) {
			layer.msg("请上传图片！",{time:1000});
			return;
		}
		jq.ajax({
			url : '${path}/banner/addSave.do',
			type : 'post',
			data:jq("form").serialize(),
			dataType : 'json',
			success : function(rs) {
				rs = eval("(" + rs + ")");
				layer.msg(rs.msg,{time:1000}, function() {
					self.location.reload();
				});
			}
		})
	})
	jq("#back").on('click', function() {
		var url = "${path}/banner/list.do";
		window.location.href = url;
	})
	
	layui.use('upload', function() {
		var index;
		layui.upload({
			elem:'#upload',
			title:'上传',
			url : '${path}/upload/upload.do?path=banner',
			before: function(input){
				index = layer.msg('图片上传中', {
					  icon: 16
					  ,shade: 0.01
					});
			},
			success : function(rs) {
				layer.close(index);
				layer.msg('上传成功', {
					  icon: 1,
					  time: 1000 //2秒关闭（如果不配置，默认是3秒）
					}, function(){
					  	
					});
				jq("#banner_path").val(rs.name);
				jq("#pic").attr("src",rs.name);
			}
			
		});

	});

})		
$(function(){
	getImageWidthAndHeight("upload",function(obj){
		alert(obj.width+":"+obj.height);
	})
})

//获取input图片宽高和大小
function getImageWidthAndHeight(id, callback) {
  var _URL = window.URL || window.webkitURL;
  $("#" + id).change(function (e) {
    var file, img;
    if ((file = this.files[0])) {
      img = new Image();
      img.onload = function () {
        callback && callback({"width": this.width, "height": this.height, "filesize": file.size});
      };
      img.src = _URL.createObjectURL(file);
    }
  });
}
</script>
</body>
</html>