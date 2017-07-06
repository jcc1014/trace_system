<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../common/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>生产基地</title>
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
					<label >名称</label> <input
						type="text" class="form-control" value="${baseInfo.name }" readonly="readonly">
				</div>
				<div class="form-group">
					<label >类别</label> 
					<c:if test="${baseInfo.type eq '2' }">
						<input type="text" class="form-control" value="超市" readonly="readonly">
					</c:if>
					<c:if test="${baseInfo.type eq '3' }">
						<input type="text" class="form-control" value="食堂" readonly="readonly">
					</c:if>
					<c:if test="${baseInfo.type eq '4' }">
						<input type="text" class="form-control" value="孟鑫" readonly="readonly">
					</c:if>
					<c:if test="${baseInfo.type eq '5' }">
						<input type="text" class="form-control" value="其他" readonly="readonly">
					</c:if>
				</div>
				<div class="form-group">
					<label >编号</label> <input
						type="text" class="form-control" value="${baseInfo.code }" readonly="readonly">
				</div>
				<div class="form-group">
					<label >地址</label> <input
						type="text" class="form-control" value="${baseInfo.address }" readonly="readonly">
				</div>
				<div class="form-group">
					<label >负责人</label> <input
						type="text" class="form-control" value="${sessionScope.user.username }" readonly="readonly">
				</div>
				<div class="form-group">
					<label >手机号</label> <input
						type="text" class="form-control" value="${baseInfo.phone }" readonly="readonly">
				</div>
				<button type="button" class="btn btn-primary" onclick="window.location.href='${path}/baseInfo/index.do'">返回</button>
			</form>
		</div>
	</div>
<script type="text/javascript">

</script>
</body>
</html>
