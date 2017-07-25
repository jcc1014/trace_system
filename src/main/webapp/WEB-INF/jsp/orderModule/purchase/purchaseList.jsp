<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../common/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>采购单</title>
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
			<h3 class="panel-title">今日采购单<!-- （距离供应单锁定还有：<span>30</span>分钟） --></h3>
		</div>
		<div class="panel-body">
			<div><h4>采购单信息</h4></div>
			<div>名称：${totalInfo.name}</div>
			<div>时间：${totalInfo.createtime}</div>
			<div>产地：${totalInfo.source_name}</div>
			<div>类型：
				<c:if test="${totalInfo.source_type eq '1'}">生产基地</c:if>
				<c:if test="${totalInfo.source_type eq '5'}">供应基地</c:if>
			</div>
			<div>产地负责人：${u.username}</div>
		</div>
		<form action="" method="post" id="form">
			<table class="table table-striped table-bordered table-condensed">
				<thead>
					<tr>
						<th>种类</th><th>品级</th><th>采购量</th><th>未采量</th><th>操作</th>
					</tr>
				</thead>
				<tbody id="tbody">
					<c:if test="${fn:length(purchaseInfos)==0 }">
						<tr><td colspan="5">暂无数据</td></tr>
					</c:if>
					<c:forEach var="item" items="${purchaseInfos}">
						<tr>
							<td>${item.kind }</td>
							<td>${item.grade }</td>
							<td>${item.number }</td>
							<td>${item.remain_number}</td>
							<td>
							<c:if test="${item.remain_number > 0}">
							<a href="javascript:;" onclick="purchase('${item.purchase_id}','${item.test }');">采购</a>
							</c:if>
							<c:if test="${item.remain_number == 0 }">
								已完成
							</c:if>
						</td>
						</tr>
					</c:forEach>
				</tbody>
	  		</table>
		</form>
		<div class="panel-footer" style="margin-top: 20px;">
			<button type="button" class="btn btn-default" onclick="back();">返回</button>
			<button type="button" class="btn btn-success" onclick="watch();">查看采购详单</button>
		</div>
	</div>
<script type="text/javascript">
function watch(){
	window.location.href = '${path}/purchase/watchPurchaseDetail.do';
}
function back(){
	window.location.href = '${path}/baseInfo/index.do';
}
function purchase(id,test){
	if('1'==test){
		window.location.href = '${path}/purchase/addPurchase.do?purchase_id='+id;
	}else{
		layer.msg('请先进行取样检验才可采购！',{time:1000});
	}
}
</script>
</body>
</html>
