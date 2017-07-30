<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../common/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>采购主管</title>
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
			<h3 class="panel-title">今日总供应单</h3>
		</div>
		<div class="panel-body">
		</div>
		<form action="" method="post" id="form">
			<table class="table table-striped table-bordered table-condensed">
				<thead>
					<tr>
						<th>名称</th><th>来源</th><th>操作</th>
					</tr>
				</thead>
				<tbody id="tbody">
					<c:if test="${null==totalInfoList || fn:length(totalInfoList)==0 }">
						<tr><td colspan="3">暂无数据</td></tr>
					</c:if>
					<c:if test="${null!=totalInfoList  }">
					<c:forEach var="item" items="${totalInfoList}">
						<tr>
							<td>${item.name }</td>
							<td>${item.source_name}</td>
							<td>
							<a href="javascript:;" onclick="watch('${item.id}');">采购</a>
							<%-- <c:if test="${item.status eq '0' }">
							</c:if>
							<c:if test="${item.status eq '1' }">
								已提交
							</c:if> --%>
						</td>
						</tr>
					</c:forEach>
					</c:if>
				</tbody>
	  		</table>
		</form>
		<div class="panel-footer" style="margin-top: 20px;">
			<c:if test="${fn:length(totalInfoList)>0} ">
				<!-- <button type="button" class="btn btn-primary" onclick="submit();">提交</button> -->
			</c:if>
			<button type="button" class="btn btn-default" onclick="window.history.go(-1);">返回</button>
		</div>
	</div>
<script type="text/javascript">
function watch(id){
	window.location.href = "${path}/purchaseInfo/todayPurchaseInfoDetail.do?id="+id;
}
</script>
</body>
</html>
