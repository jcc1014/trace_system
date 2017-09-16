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
    <script type="text/javascript" src="${path}/layui/layui.js"></script>
    <script type="text/javascript" src="${path}/js/commonUtil.js"></script>
</head>
<body>
<div class="layui-tab layui-tab-brief main-tab-container" style="margin-top: 20px;">
    <ul class="layui-tab-title main-tab-title">
      <div class="main-tab-item">用户信息</div>
    </ul>
    <div class="layui-tab-content" style="margin-top: 40px;margin-left: 200px;">
			<form class="layui-form">
				<div class="layui-tab-item layui-show">
					<input type="hidden" name="id" value="">
					<div class="layui-form-item">
						<label class="layui-form-label">用户名</label>
						<div class="layui-input-inline input-custom-width">
							<input type="text" id="username" name="username"
								 autocomplete="off" placeholder="请输入用户名"
								class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">姓名</label>
						<div class="layui-input-inline input-custom-width">
							<input type="text" id="realname" name="realname"
								 autocomplete="off" placeholder="请输入姓名"
								class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">选择类型</label>
						<div class="layui-input-inline input-custom-width">
							<select name="usertype" id="usertype">
								<option value="">请选择</option>
								<option value="1">采购员</option>
								<option value="2">检验员</option>
								<option value="8">取样员</option>
								<option value="9">配送员</option>
							</select>
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">手机号</label>
						<div class="layui-input-inline input-custom-width">
							<input type="text" id="phone" name="phone" autocomplete="off"
								placeholder="手机号" class="layui-input">
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
		var username = jq("#username").val();
		if ("" == username) {
			layer.msg("请填写用户名！");
			return;
		}
		var realname = jq("#realname").val();
		if ("" == realname) {
			layer.msg("请填写真实姓名！");
			return;
		}
		var usertype = jq("#usertype").val();
		if ("" == usertype) {
			layer.msg("请选择类型！");
			return;
		}
		var phone = jq("#phone").val();
		if ("" != phone ) {
			if(!isTelephone(phone)){
				layer.msg("手机号不合法！");
				return;
			}
		}
		jq.ajax({
			url : '${path}/user/addSave.do',
			type : 'post',
			data:{'username':username,'usertype':usertype,'phone':phone,'realname':realname},
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
		var url = "${path}/user/list.do";
		//jq('.admin-iframe', window.parent.document).attr('src',url);
		window.location.href = url;
	})

})			

$("#username").blur(function(){
	var username = $("#username").val();
	$.ajax({
		url : '${path}/shop/checkUser.do',
		type : 'post',
		data:{'username':username},
		dataType : 'json',
		success : function(rs) {
			rs = eval("(" + rs + ")");
			if("200"==rs.code){
				layer.msg("用户名可用！",{time:1000});
			}
			else{
				layer.msg("用户名已被占用，请更换！",{time:1000},function(){
					$("#username").val("").focus();
				});
			}
		}
	})
})
$("#realname").blur(function(){
	var realname = $("#realname").val();
	$.ajax({
		url : '${path}/user/checkName.do',
		type : 'post',
		data:{'realname':realname},
		dataType : 'json',
		success : function(rs) {
			rs = eval("(" + rs + ")");
			if("200"==rs.code){
				//layer.msg("用户名可用！",{time:1000});
			}
			else{
				layer.msg("姓名已被占用，请更换！",{time:1000},function(){
					$("#realname").val("").focus();
				});
			}
		}
	})
})
</script>
</body>
</html>