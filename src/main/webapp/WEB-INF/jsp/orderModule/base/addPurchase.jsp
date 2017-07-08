<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../common/common.jsp" %>
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
      <div class="main-tab-item">增加采购员</div>
    </ul>
    <div class="layui-tab-content" style="margin-top: 40px;margin-left: 200px;">
			<form class="layui-form">
				<div class="layui-tab-item layui-show">
					<input type="hidden" id="baseid" value="${baseInfo.id }">
					<div class="layui-form-item">
						<label class="layui-form-label">基地名称</label>
						<div class="layui-input-inline input-custom-width">
							<input type="text" readonly="readonly"
								 value="${baseInfo.name }"
								class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">选择类型</label>
						<div class="layui-input-inline input-custom-width">
							<select name="usertype" id="usertype">
								<option value="1" selected="selected">采购员</option>
							</select>
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">姓名</label>
						<div class="layui-input-inline input-custom-width">
							<input type="text" id="username" name="username"
								 autocomplete="off" placeholder="请输入姓名"
								class="layui-input">
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
			layer.msg("请填写姓名！");
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
			data:{'username':username,'usertype':usertype,'phone':phone,'baseid':jq("#baseid").val()},
			dataType : 'json',
			success : function(rs) {
				rs = eval("(" + rs + ")");
				if("200"==rs.code){
					layer.msg('增加采购员成功，初始密码000000！',{time:1000}, function() {
						window.location.href = "${path}/baseInfo/list.do";
					});
				}else{
					layer.msg('增加采购员失败，请联系管理员！',{time:1000}, function() {
						window.location.href = "${path}/baseInfo/list.do";
					});
				}
			}
		})
	})
	jq("#back").on('click', function() {
		var url = "${path}/baseInfo/list.do";
		//jq('.admin-iframe', window.parent.document).attr('src',url);
		window.location.href = url;
	})
	
	jq("#username").blur(function(){
	var username = jq("#username").val();
	jq.ajax({
		url : '${path}/shop/checkUser.do',
		type : 'post',
		data:{'username':username},
		dataType : 'json',
		success : function(rs) {
			rs = eval("(" + rs + ")");
			if("200"==rs.code){
				layer.msg("采购员名称可用！",{time:1000});
			}
			else{
				layer.msg("采购员名称已被占用！",{time:1000},function(){
					jq("#username").val("").focus();
				});
			}
		}
	})
})

})	

</script>
</body>
</html>