<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../common/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>收货</title>
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="apple-mobile-web-app-status-bar-style" content="black"> 
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="format-detection" content="telephone=no">
	<link href="${path}/css/bootstrap.css" rel="stylesheet" media="screen">
	<link href="${path}/css/mui.min.css" rel="stylesheet" media="screen">
	<script src="${path}/js/mui.min.js" type="text/javascript"></script>
	<script src="${path}/js/jquery.js" type="text/javascript"></script>
	<script src="${path}/js/jq-signature.js" type="text/javascript"></script>
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
			<h3 class="panel-title">待收货单</h3>
		</div>
		<div class="panel-body">
		</div>
		<form action="" method="post" id="form">
			<table class="table table-striped table-bordered table-condensed">
				<thead>
					<tr>
						<th>时间</th>
						<th>名称</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody id="tbody">
					<c:if test="${fn:length(list)==0 }">
						<tr><td colspan="3">暂无数据</td></tr>
					</c:if>
					<c:forEach var="item" items="${list}">
						<tr>
							<td>${item.createtime }</td>
							<td>${item.require_name }</td>
							<td>
							<a href="javascript:;" onclick="watch('${item.distribution_id}');">查看</a>
							<%-- <a href="javascript:;" onclick="confirm('${item.distribution_id}');">确认</a> --%>
							</td>
						</tr>
					</c:forEach>
				</tbody>
	  		</table>
		</form>
		<div class="panel-footer" style="margin-top: 20px;">
			<c:if test="${fn:length(list)>0 && sign eq '1'}">
			<button type="button" class="btn btn-primary" onclick="confirm();">签名</button>
			</c:if>
			<button type="button" class="btn btn-primary" onclick="confirm();">签名</button>
			<button type="button" class="btn btn-default" onclick="back();">返回</button>
		</div>
	</div>
<script type="text/javascript">
	function back(){
		window.location.href = '${path}/baseInfo/index.do';
	}
	function watch(id){
		window.location.href = '${path}/distribution/today_shDetail.do?id='+id;
	}

	function confirm(name,time){
		//弹出签名页面
		//上传名称和时间
		layer.open({
			type:2,
			title:'确认',
			closeBtn:1,
			area: ['90%','70%'],
			shadeClose: true,
			content: '${path}/distribution/sign.do'
		})
	}

	function save(){
		//保存签名
		
	}
	
	function closeModal(){
		layer.closeAll();
	}
</script>
</body>
</html>
