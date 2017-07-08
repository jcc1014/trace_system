<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../common/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>供应单详情</title>
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
		body{background-color: #eee;}
		thead tr th{text-align: center;}
		tbody tr td{text-align: center;}
		table {border-bottom: 1px solid #eee; }
	</style>
</head>
<body>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title">供应单详情</h3>
		</div>
		<div class="panel-body">
			<div><h4>供应单信息</h4></div>
			<div>名称：${totalInfo.name}</div>
			<div>时间：${totalInfo.createtime}</div>
			<div>产地：${totalInfo.source_name}</div>
			<div>类型：
				<c:if test="${totalInfo.source_type eq '1'}">生产基地</c:if>
				<c:if test="${totalInfo.source_type eq '5'}">供应基地</c:if>
			</div>
			<div>负责人：${u.username}</div>
			<div>手机：${u.phone}</div>
		</div>
		<table class="table table-striped table-bordered table-condensed">
			<thead>
				<tr>
					<th>种类</th><th>品级</th><th>供应量</th><th>价格</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${fn:length(produceInfos)==0 }">
					<tr><td colspan="4">暂无数据</td></tr>
				</c:if>
				<c:forEach var="item" items="${produceInfos}">
					<tr>
						<td>${item.type }</td>
						<td>${item.grade }</td>
						<td>${item.supply_number }</td>
						<td>${item.price }</td>
					</tr>
				</c:forEach>
			</tbody>
  		</table>
		<div class="panel-footer" style="margin-top: 20px;">
			<button type="button" class="btn btn-default" onclick="window.history.go(-1);">返回</button>
		</div>
	</div>
<script type="text/javascript">
</script>
</body>
</html>
