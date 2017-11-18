<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../common/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>采购员</title>
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
			<h3 class="panel-title">${totalInfo.createtime}缺货单</h3>
		</div>
		<div class="panel-body">
			<%-- <c:if test="${qhd eq '0' && sessionScope.user.usertype ne '1' }">
				<button type="button" class="btn btn-success" onclick="createQhd();">生成缺货单</button>
			</c:if> --%>
		</div>
		<table class="table table-striped table-bordered table-condensed">
			<thead>
				<tr>
					<th>种类</th><th>品级</th><th>三品一标</th><th>采购量</th><th>未采量</th><th>单位</th><th>操作</th>
				</tr>
			</thead>
			<tbody id="tbody">
				<c:if test="${fn:length(purchaseInfos)==0 }">
					<tr><td colspan="7">暂无数据</td></tr>
				</c:if>
				<c:forEach var="item" items="${purchaseInfos}">
					<tr>
						<td>${item.kind }</td>
						<td>${item.grade }</td>
						<td>${item.spyb }</td>
						<td>${item.number }</td>
						<td>${item.remain_number}</td>
						<td>${item.dw}</td>
						<td>
						<c:if test="${sessionScope.user.usertype eq '1' && item.remain_number != 0 }">
						<a href="javascript:;" onclick="purchase('${item.purchase_id}');">采购</a>
						</c:if> 
						<c:if test="${sessionScope.user.usertype ne '1' && item.remain_number != 0 }">
							暂无
						</c:if> 
						<c:if test="${item.remain_number == 0 }">
							<a href="javascript:;" onclick="detail('${item.purchase_id}');">查看</a>
						</c:if> 
					</td>
					</tr>
				</c:forEach>
			</tbody>
  		</table>
		<div class="panel-footer" style="margin-top: 20px;">
			<button type="button" class="btn btn-default" onclick="back();">返回</button>
			<button type="button" class="btn btn-success" onclick="watch();">查看采购详单</button>
		</div>
	</div>
<script type="text/javascript">
function watch(){
	window.location.href = '${path}/purchase/watchPurchaseDetail.do';
}
function detail(id){
	window.location.href = '${path}/purchase/watchPurchaseDetailById.do?id='+id;
}
function back(){
	window.location.href = '${path}/baseInfo/index.do';
}
function purchase(id){
	window.location.href = '${path}/purchase/addQhPurchase.do?purchase_id='+id;
}

</script>
</body>
</html>
