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
			<h3 class="panel-title">历史供应单<!-- （距离供应单锁定还有：<span>30</span>分钟） -->
			</h3>
		</div>
		<table class="table table-striped table-bordered">
			<thead>
				<tr>
					<th>日期</th><th>名称</th><th>操作</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${fn:length(totalInfoList)==0 }">
					<tr><td colspan="3">暂无数据</td></tr>
				</c:if>
				<c:forEach var="item" items="${totalInfoList}">
					<tr>
						<td>${item.createtime }</td>
						<td>${item.name }</td>
						<td>
							<a href="javascript:;" onclick="watch('${item.id}');"><span class="glyphicon glyphicon-search" aria-hidden="true"></span></a>
						</td>
					</tr>
				</c:forEach>
			</tbody>
  		</table>
			<!-- <nav aria-label="Page navigation">
			  <ul class="pagination">
			    <li >
			      <a href="#" aria-label="Previous" id="prev">
			        <span aria-hidden="true">&laquo;</span>
			      </a>
			    </li>
			    <li ><a href="#" id="curr"></a></li>
			    <li>
			      <a href="#" aria-label="Next" id="next">
			        <span aria-hidden="true">&raquo;</span>
			      </a>
			    </li>
			  </ul>
			</nav> -->
		<div class="panel-footer" style="margin-top: 20px;">
			<button type="button" class="btn btn-default" onclick="window.location.href = '${path}/baseInfo/index.do';">返回主页</button>
		</div>
	</div>

<script type="text/javascript">
function watch(id){
	window.location.href = "${path}/produce/history_detail.do?id="+id;
}


</script>
</body>
</html>
