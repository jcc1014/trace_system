<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../common/common.jsp" %>
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
	<style type="text/css">
	.layui-disabled, .layui-disabled:hover {
		color: #000!important;
	}
</style>    
  </head>
 <body>
 <div class="layui-tab layui-tab-brief main-tab-container" style="margin-top: 20px;">
  	<ul class="layui-tab-title main-tab-title">
      <div class="main-tab-item">检验信息</div>
    </ul>
    
    <div class="layui-tab-content" style="margin-top: 40px;margin-left: 100px;">
			<form class="layui-form">
				<div class="layui-tab-item layui-show">
					<input type="hidden" id="test_id" value="${test.test_id }">
					<div class="layui-form-item">
						<label class="layui-form-label">样品编号</label>
						<div class="layui-input-inline input-custom-width">
							<input type="text" id="test_bh" 
								class="layui-input" value="${test.test_bh }" readonly="readonly">
						</div>
						<label class="layui-form-label">样品种类</label>
						<div class="layui-input-inline input-custom-width">
							<input type="text" id="test_kind" value="${test.test_kind }"
								class="layui-input" readonly="readonly">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">样品品级</label>
						<div class="layui-input-inline input-custom-width">
							<input type="text" id="test_grade" value="${test.test_grade }"
								class="layui-input" readonly="readonly">
						</div>
						<label class="layui-form-label">检验人</label>
						<div class="layui-input-inline input-custom-width">
							<input type="text" id="test_user" value="${sessionScope.user.username }" name="test_user"
								class="layui-input" readonly="readonly">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">检验结果</label>
						<div class="layui-input-inline input-custom-width">
							 <select id="test_result" name="test_result" class="layui-input" disabled="disabled">
								<option value="">--选择--</option>
								<option value="1" <c:if test="${test.test_result eq '1'}">selected="selected"</c:if> >合格</option>
								<option value="2" <c:if test="${test.test_result eq '2'}">selected="selected"</c:if>>不合格</option>
							</select>
						</div>
						<label class="layui-form-label">检验机器</label>
						<div class="layui-input-inline input-custom-width">
							<input type="text" id="test_machine" name="test_machine" value="${test.test_machine }"
								class="layui-input" readonly="readonly">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">结果影响</label>
						<div class="layui-input-inline input-custom-width">
							<textarea  name="test_influence" style="resize:none;" readonly="readonly" class="layui-textarea">${test.test_influence }</textarea>
						</div>
					</div>
					<div class="layui-form-item" id="pic_display">
						<label class="layui-form-label">已传视频</label>
						<div id="picDiv" class="layui-input-block" >
							<video src="${path}/testVideo/${test.test_video}" 
							style="width: 300px;height: 300px;" controls="controls"></video>
						</div>
					</div>

					<div class="layui-form-item" style="margin-top: 50px;">
						<div class="layui-input-block">
							<button type="button" class="layui-btn layui-btn-primary" onclick="back();">返回</button>
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
	
})

function closeLayer(){
	layer.closeAll();
}

function back(){
	window.location.href = "${path}/sampling/hadTestList.do";
}

</script>
</body>
</html>
