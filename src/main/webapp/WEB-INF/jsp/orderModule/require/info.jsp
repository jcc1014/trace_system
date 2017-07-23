<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../common/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>基地</title>
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="apple-mobile-web-app-status-bar-style" content="black"> 
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="format-detection" content="telephone=no">
	<link href="${path}/css/bootstrap.css" rel="stylesheet" media="screen">
	<script src="${path}/js/jquery-2.1.1.min.js" type="text/javascript"></script>
	<script src="${path}/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="${path}/layer/layer.js" type="text/javascript"></script>
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
			<h3 class="panel-title">基地信息</h3>
		</div>
		<div class="panel-body">
			<form>
				<div class="form-group">
					<label >基地名称</label> <input
						type="text" class="form-control" value="${baseInfo.name }" readonly="readonly">
				</div>
				<div class="form-group">
					<label >基地编号</label> <input
						type="text" class="form-control" value="${baseInfo.code }" readonly="readonly">
				</div>
				<div class="form-group">
					<label >基地地址</label> <input
						type="text" class="form-control" value="${baseInfo.address }" readonly="readonly">
				</div>
				<div class="form-group">
					<label >基地负责人</label> <input
						type="text" class="form-control" value="${sessionScope.user.username }" readonly="readonly">
				</div>
				<div class="form-group">
					<label >手机号</label> <input
						type="text" class="form-control" value="${baseInfo.phone }" readonly="readonly">
				</div>
				<div class="form-group">
					<label >基地视频</label> <button type="button" onclick="watchVideo('${baseInfo.video}')" class="btn btn-info btn-mini">点击观看</button>
				</div>
				<button type="button" class="btn btn-primary" onclick="window.location.href='${path}/baseInfo/index.do'">返回</button>
			</form>
		</div>
	</div>
<script type="text/javascript">
function watchVideo(path){
	if(''==path){
		layer.msg('暂无视频！',{time:1000});
		return;
	}
	layer.open({
		  type: 2,
		  title: "查看视频",
		  area: ['90%', '350px'],
		  shade: 0,
		  closeBtn: 1,
		  shadeClose: true,
		  content: '${path}/video/watchVideo.do?path='+path
		});
}
</script>
</body>
</html>
