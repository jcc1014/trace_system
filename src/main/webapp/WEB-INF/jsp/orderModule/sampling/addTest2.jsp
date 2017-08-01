<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../common/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>检验</title>
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="apple-mobile-web-app-status-bar-style" content="black"> 
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="format-detection" content="telephone=no">
	<link href="${path}/css/bootstrap.css" rel="stylesheet" media="screen">
	<link rel="stylesheet" href="${path}/layui/css/layui.css">
	<script src="${path}/js/jquery-2.1.1.min.js" type="text/javascript"></script>
	<script src="${path}/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="${path}/layer/layer.js" type="text/javascript"></script>
	<script type="text/javascript" src="${path}/layui/layui.js"></script>
	<style type="text/css">
		body{background-color: #eee;}
		thead tr th{text-align: center;}
		tbody tr td{text-align: center;}
		table {border-bottom: 1px solid #eee; }
	</style>
</head>
<body>
	<div id="add">
		<form action="${path}/sampling/addSamplingSave.do" method="post" id="form">
			<input type="hidden" id="test_id" value="${test.test_id }">
			<div class="form-group">
				<label for="test_bh">样品编号</label> 
				<input type="text" id="test_bh" 
					class="form-control" value="${test.test_bh }" readonly="readonly">
			</div>
			<div class="form-group">
				<label for="test_kind">样品种类</label> 
				<input type="text" id="test_kind" value="${test.test_kind }"
								class="form-control" readonly="readonly">
			</div>
			<div class="form-group">
				<label for="test_grade">样品品级</label> 
				<input type="text" id="test_grade" value="${test.test_grade }"
								class="form-control" readonly="readonly">
			</div>
			<div class="form-group">
				<label for="test_user">检验人</label> 
				<input type="text" id="test_user" value="${sessionScope.user.username }" name="test_user"
								class="form-control" readonly="readonly">
			</div>
			<div class="form-group">
				<label for="test_result">是否合格</label> 
				<select id="test_result" name="test_result" class="form-control">
								<option value="">--选择--</option>
								<option value="1">合格</option>
								<option value="2">不合格</option>
				</select>
			</div>
			<div class="form-group">
				<label for="test_machine">检验机器</label> 
				<input type="text" id="test_machine" name="test_machine"
								class="form-control">
			</div>
			<div class="form-group">
				<label for="test_machine">结果影响</label> 
				<textarea id="test_influence" name="test_influence" style="resize:none;" 
				placeholder="请输入检验结果" class="form-control" style="height:100px;"></textarea>
			</div>
			<div class="form-group" style="text-align: center;">
				<button type="button" class="btn btn-success"
					id="test_save">保存</button>
				<button type="button" class="btn btn-default" onclick="window.history.go(-1);">返回</button>
			</div>
		</form>
	</div>
	<script type="text/javascript">
	layui.use(
			[ 'element', 'form', 'upload', 'layedit', 'laydate' ],function() {
			var element = layui.element(), 
			jq = layui.jquery;
			
		jq("#test_save").on('click',function(){
			jq("#test_save").hide();
			var test_result = jq("#test_result").val();
			var test_machine = jq("#test_machine").val();
			var test_influence = jq("#test_influence").val();
			var test_video = jq("#test_video").val();
			if(test_result==null || test_result=="" || test_result==undefined){
				 layer.msg('请输入检验结果',{time:1000});
				 return;
			}
			if(test_machine==null || test_machine=="" || test_machine==undefined){
				 layer.msg('请输入检验机器',{time:1000});
				 return;
			}
			jq.ajax({
				url : '${path}/sampling/testSave.do',
				type : 'post',
				data:{'test_id':$("#test_id").val(),'test_result':test_result,'test_machine':test_machine,
					'test_influence':test_influence},
				dataType : 'json',
				success : function(rs) {
					rs = eval("(" + rs + ")");
					if("200"==rs.code){
						layer.msg("保存成功",{time:1000}, function() {
							window.location.href = "${path}/sampling/todayTest.do";
						});
					}else{
						layer.msg("保存失败",{time:1000}, function() {
							window.location.href = "${path}/sampling/todayTest.do";
						});
					}
				}
			})
		});
	})

function close(){
	layer.closeAll();
}
</script>
</body>
</html>
