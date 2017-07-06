<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../common/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>总供应单</title>
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
		td input{width: 10rem;}
	</style>
</head>
<body>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title">今日总供应单<!-- （距离供应单锁定还有：<span>30</span>分钟） --></h3>
		</div>
		<div class="panel-body">
			<%-- <div><h4>供应单信息</h4></div>
			<div>名称：${totalInfo.name}</div>
			<div>时间：${totalInfo.createtime}</div>
			<div>产地：${totalInfo.source_name}</div>
			<div>负责人：${sessionScope.user.username}</div>
			<div>手机：${sessionScope.baseInfo.phone}</div> --%>
		</div>
		<form action="${path}/purchaseInfo/createCgd.do" method="post" id="form">
			<table class="table table-striped table-bordered table-condensed">
				<thead>
					<tr>
						<th width="30%">种类</th>
						<th width="15%">品级</th>
						<th width="20%">供应量</th>
						<th width="15%">均价</th>
						<th width="20%">采购量</th>
					</tr>
				</thead>
				<tbody id="tbody">
					<c:if test="${fn:length(list)==0 }">
						<tr><td colspan="4">暂无数据</td></tr>
					</c:if>
					<c:forEach var="item" items="${list}">
						<tr>
							<td>${item.type }</td>
							<td>${item.grade }</td>
							<td>${item.supply_number}</td>
							<td>${item.price }</td>
							<td><input type="number" name="number"/></td>
						</tr>
					</c:forEach>
				</tbody>
	  		</table>
		</form>
		<div class="panel-footer" style="margin-top: 20px;">
			<c:if test="${fn:length(list)>0 }">
				<button type="button" class="btn btn-primary" onclick="submit();">生成采购单</button>
			</c:if>
			<button type="button" class="btn btn-default" onclick="window.history.go(-1);">返回</button>
		</div>
	</div>
<script type="text/javascript">
function submit(){
	var inputs = $("#tbody").find("input");
	var f = true;
	$.each(inputs,function(i,obj){
		_this = $(this);
		var number = _this.val();
		if(number==""||isNaN(number)){
			layer.msg('第'+(i+1)+'行实际供应量格式不正确！',{time:1000},function(){
				f = false;
				return;
			});
		}
	})
	if(f==true){
		$("#form").submit();
	}
}
</script>
</body>
</html>
