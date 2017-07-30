<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../common/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>追溯信息</title>
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="apple-mobile-web-app-status-bar-style" content="black"> 
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="format-detection" content="telephone=no">
	<link href="${path}/css/bootstrap.css" rel="stylesheet" media="screen">
	<script src="${path}/js/jquery-2.1.1.min.js" type="text/javascript"></script>
	<script src="${path}/js/bootstrap.min.js" type="text/javascript"></script>
	<style type="text/css">
body {
	background-color: #eee;
}

.form-control[disabled], .form-control[readonly], fieldset[disabled] .form-control
	{
	cursor: not-allowed;
	background-color: #fff;
	opacity: 1;
}
</style>
</head>
<body>

	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title">基本信息</h3>
		</div>
		<div class="panel-body">
			<form>
				<div class="form-group">
					<label >销售单位</label> <input
						type="text" class="form-control" value="${distributionInfo.require_name }" readonly="readonly">
				</div>
				<div class="form-group">
					<label >采购数量</label> <input
						type="text" class="form-control" value="${distributionInfo.require_num }" readonly="readonly">
				</div>
				<c:if test="${null != baseInfo }">
				<div class="form-group">
					<label >产地</label> <input
						type="text" class="form-control" value="${baseInfo.name }" readonly="readonly">
				</div>
				<div class="form-group">
					<label >地址</label> <input
						type="text" class="form-control" value="${baseInfo.address }" readonly="readonly">
				</div>
				<div class="form-group">
					<label >手机</label> <input
						type="text" class="form-control" value="${baseInfo.phone }" readonly="readonly">
				</div>
				<div class="form-group">
					<label >类型</label> <input
						type="text" class="form-control" 
						<c:if test="${baseInfo.type eq 'A' }">value="市场"</c:if>
						<c:if test="${baseInfo.type eq '1' }">value="生产基地"</c:if>
						<c:if test="${baseInfo.type eq '5' }">value="供应基地"</c:if>
						 readonly="readonly">
				</div>
				<c:if test="${baseInfo.video ne '' && baseInfo.video != null }">
				<div class="form-group">
					<label >基地视频</label> 
					<video src="${path }/video/${baseInfo.video}" controls="controls" height="300" width="100%">
					</video>
				</div>
				</c:if>
				</c:if>
				<div class="form-group">
					<label >种类</label> <input
						type="text" class="form-control" value="${distributionInfo.kind }" readonly="readonly">
				</div>
				<div class="form-group">
					<label >品级</label> <input
						type="text" class="form-control" value="${distributionInfo.grade }" readonly="readonly">
				</div>
				<div class="form-group">
					<label >配送数量</label> <input
						type="text" class="form-control" value="${detail.distribution_num }" readonly="readonly">
				</div>
				<div class="form-group">
					<label >单价</label> <input
						type="text" class="form-control" value="${detail.price }" readonly="readonly">
				</div>
				<div class="form-group">
					<label >配送员</label> <input
						type="text" class="form-control" value="${detail.distribution_user }" readonly="readonly">
				</div>
				<div class="form-group">
					<label >配送车辆</label> <input
						type="text" class="form-control" value="${detail.distribution_car }" readonly="readonly">
				</div>
				<div class="form-group">
					<label >手机号</label> <input
						type="text" class="form-control" value="${detail.phone }" readonly="readonly">
				</div>
				<div class="form-group">
					<label >取样员</label> <input
						type="text" class="form-control" value="${trace.test_name }" readonly="readonly">
				</div>
				<c:if test="${trace.sampling_video ne '' && trace_sampling_video != null }">
				<div class="form-group">
					<label >取样视频</label> 
					<video src="${path }/testVideo/${trace_sampling_video}" controls="controls" height="300" width="100%">
					</video>
				</div>
				</c:if>
				<div class="form-group">
					<label >检验员</label> <input
						type="text" class="form-control" value="${trace.test_user }" readonly="readonly">
				</div>
				<div class="form-group">
					<label >检验结果</label> 
					<input type="text" class="form-control" value="合格" readonly="readonly">
				</div>
				<div class="form-group">
					<label >供应商</label> 
					<input type="text" class="form-control" value="${trace.farmer_name }" readonly="readonly">
				</div>
				<div class="form-group">
					<label >采购员</label> 
					<input type="text" class="form-control" value="${trace.purchase_user }" readonly="readonly">
				</div>
				<div class="form-group">
					<label >采购时间</label> 
					<input type="text" class="form-control" value="${trace.purchase_time }" readonly="readonly">
				</div>
				<div class="form-group">
					<label >运输员</label> 
					<input type="text" class="form-control" value="${trace.transport_user }" readonly="readonly">
				</div>
				<%-- <button type="button" class="btn btn-primary" onclick="window.location.href='${path}/baseInfo/index.do'">返回</button> --%>
			</form>
		</div>
	</div>
<script type="text/javascript">

</script>
</body>
</html>
