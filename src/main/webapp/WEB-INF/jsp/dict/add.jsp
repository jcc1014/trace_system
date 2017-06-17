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
      <div class="main-tab-item">种类信息</div>
    </ul>
    <div class="layui-tab-content" style="margin-top: 40px;margin-left: 200px;">
			<form class="layui-form" id="form">
				<div class="layui-tab-item layui-show">
					<input type="hidden" name="id" value="">
					<div class="layui-form-item">
						<label class="layui-form-label">名称:</label>
						<div class="layui-input-inline input-custom-width">
							<input type="text" id="dict_name" name="dict_name"
								 autocomplete="off" placeholder="请输入名称"
								class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">类别:</label>
						<div class="layui-input-inline input-custom-width">
							<select name="dict_type" id="dict_type">
								<option value="">--请选择--</option>
								<c:forEach var="item" items="${typeList}">
									<option value="${item.dict_id}">${item.dict_name}</option>
								</c:forEach>
							</select>
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
		var dict_name = jq("#dict_name").val();
		if ("" == dict_name) {
			layer.msg("请填写名称！",{time:1000});
			return;
		}
		var parentid = jq("#dict_type option:selected").val();
		var dict_type = jq("#dict_type option:selected").html();
		if ("" == parentid ) {
			layer.msg("请选择种类！",{time:1000});
			return;
		}
		jq.ajax({
			url : '${path}/dict/addSave.do',
			type : 'post',
			data:{'dict_name':dict_name,'parentid':parentid,'dict_type':dict_type},
			dataType : 'json',
			success : function(rs) {
				rs = eval("(" + rs + ")");
				layer.msg("保存"+rs.msg,{time:1000}, function() {
					self.location.reload();
				});
			}
		})
	})
	jq("#back").on('click', function() {
		var url = "${path}/dict/list.do";
		window.location.href = url;
	})
})		
</script>
</body>
</html>