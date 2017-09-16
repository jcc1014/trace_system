<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../common/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>新增配送</title>
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


.form-control[disabled], .form-control[readonly], fieldset[disabled] .form-control
	{
	cursor: not-allowed;
	background-color: #fff;
	opacity: 1;
}
</style>
</head>
<body>

	<div class="panel panel-default" style="height: 100%;border-bottom:0px #fff;">
		<div class="panel-heading">
			<h3 class="panel-title">新增配送</h3>
		</div>
		<div class="panel-body">
			<form method="post" action="${path}/distribution/addDetailSave.do" id="form">
				<div class="form-group">
					<label >种类</label> 
					<input type="hidden" name="distribution_id" value="${distribution.distribution_id }" >
					<input type="text" class="form-control" name="kind" id="kind"
					value="${distribution.kind }" readonly="readonly">
				</div>
				<div class="form-group">
					<label >品级</label> <input
						type="text" class="form-control" name="grade" id="grade"
						value="${distribution.grade }" readonly="readonly">
				</div>
				<div class="form-group">
					<label >三品一标</label> <input
						type="text" class="form-control" name="spyb" id="spyb"
						value="${distribution.spyb }" readonly="readonly">
				</div>
				<div class="form-group">
					<label >未配送</label> <input
						type="text" class="form-control" name="wps" id="wps"
						value="${distribution.wps }" readonly="readonly">
				</div>
				<div class="form-group">
					<label >价格</label> 
					<input type="text" class="form-control" id="price"
					name="price" value="${distribution.price }" readonly="readonly">
				</div>
				<div class="form-group">
					<label >配送人</label> 
					<input type="text" class="form-control" 
					name="distribution_user" value="${sessionScope.user.realname}" readonly="readonly">
				</div>
				<div class="form-group">
					<label >手机</label> 
					<input type="text" class="form-control" 
					name="phone" value="${sessionScope.user.phone}" readonly="readonly">
				</div>
				<div class="form-group">
					<label >蔬菜编码</label> 
					<!-- <input
						type="text" class="form-control" name="trace_id" id="trace_id"
						onblur="checkTrace();"> -->
					<select  class="form-control" name="trace_id" id="trace_id"
						onblur="checkTrace();">
						<option value="">请选择</option>
						<c:if test="${null != identifierList }">
							<c:forEach var="item" items="${identifierList}">
								<option value="${item.identifier}">${item.identifier }</option>
							</c:forEach>
						</c:if>
					</select>
					<span id="trace_num"></span>
				</div>
				<div class="form-group">
					<label >配送数量</label> 
					<input type="number" class="form-control" id="distribution_num"
					name="distribution_num" onblur="checkNum();"> 
				</div>
				<div class="form-group">
					<label >配送车辆</label> 
					<input type="text" class="form-control" 
					name="distribution_car" id="distribution_car">
				</div>
				<button type="button" class="btn btn-primary" onclick="submit();">提交</button>
				<button type="button" class="btn btn-default" onclick="window.location.href='${path}/distribution/todayDistribution.do'">返回</button>
			</form>
		</div>
	</div>
<script type="text/javascript">
function submit(){
	var distribution_car = $("#distribution_car").val();
	if(""==distribution_car||null==distribution_car){
		layer.msg('请填写运输车辆！',{time:1000});
		return;
	}
	var trace_id = $("#trace_id").val();
	if(""==trace_id||null==trace_id){
		layer.msg('请填写蔬菜编码！',{time:1000});
		return;
	}
	var distribution_num = $("#distribution_num").val();
	if(""==distribution_num||null==distribution_num||isNaN(distribution_num)){
		layer.msg('配送数量格式不正确！',{time:1000});
		return;
	}
	if(parseFloat(distribution_num)>parseFloat('${sessionScope.remain}')){
		layer.msg('配送数量不能多于可配送量！',{time:1000});
		$("#distribution_num").val("").focus();
		return;
	}
	$("#form").submit();
}

function checkTrace(){
	var trace_id = $("#trace_id").val();
	if(""==trace_id){
		layer.msg('编号不能为空！',{time:1000},function(){
			$("#trace_id").focus();
		})
	}
	$.ajax({
		type:'post',
		url:'${path}/distribution/checkTrace.do',
		dataType:'json',
		data:{'id':trace_id},
		success:function(rs){
			if(""!=rs){
				rs = $.parseJSON(rs);
				if("200"==rs.code){
					if(rs.purchase_kind!=$("#kind").val()||
							rs.purchase_grade != $("#grade").val()){
						
						layer.msg('所填编号的蔬菜名称和品级</br>与将要配送的蔬菜不一致',{time:2000},function(){
							return;
						})
					}else{
						layer.msg('所填编号还有'+rs.remain+'可以配送，</br>配送数量请小于或者等于这个数！',{time:1000},function(){
							$("#trace_num").html('所填编号还有'+rs.remain+'可以配送，</br>配送数量请小于或者等于这个数！');
							return;
						})
					}
				} else {
					layer.msg('校验编号出错，请检查编号！',{time:1000},function(){
						$("#trace_id").val("").focus();
					})
				}
			}
		}
	})
}

function checkNum(){
	var trace_id = $("#trace_id").val();
	if(""==trace_id){
		layer.msg('请先填写蔬菜编码！',{time:1000});
		$("#trace_id").focus()
		return;
	}
	var distribution_num = $("#distribution_num").val();
	if(""!=distribution_num&&!isNaN(distribution_num)){
		if(parseFloat(distribution_num)>parseFloat('${sessionScope.remain}')){
			layer.msg('配送数量不能多于可配送量！',{time:1000});
			$("#distribution_num").val("").focus();
			return;
		}
	}else{
		layer.msg('配送数量格式不正确！',{time:1000});
		$("#distribution_num").val("").focus();
		return;
	}
}
</script>
</body>
</html>
