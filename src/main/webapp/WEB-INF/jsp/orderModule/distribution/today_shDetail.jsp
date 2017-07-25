<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../common/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>收货管理</title>
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
			<h3 class="panel-title">收货详细单</h3>
		</div>
		<div class="panel-body">
			<div><h4>收货单详情</h4></div>
			<div>名称：${baseInfo.name}</div>
			<div>时间：${time}</div>
			<div>地址：${baseInfo.address}</div>
			<div>负责人：${sessionScope.user.username}</div>
			<div>手机：${baseInfo.phone}</div>
			<div>状态：${signname }</div>
		</div>
		<form action="" method="post" id="form">
			<table class="table table-striped table-bordered table-condensed">
				<thead>
					<tr>
						<th>名称</th>
						<th>种类</th>
						<th>品级</th>
						<th>价格</th>
						<th>数量</th>
						<th>总价</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody id="tbody">
					<c:if test="${fn:length(distributionInfoList)==0 }">
						<tr><td colspan="7">暂无数据</td></tr>
					</c:if>
					<c:forEach var="item" items="${distributionInfoList}">
						<tr>
							<td>${item.require_name }</td>
							<td>${item.kind }</td>
							<td>${item.grade }</td>
							<td>${item.price }</td>
							<td>${item.yps }</td>
							<td>${item.sum_price }</td>
							<td>
							<c:if test="${signname eq '未签名确认' }">
							<a href="javascript:;" onclick="modify('${item.distribution_id}');">修改</a>
							</c:if>
							<c:if test="${signname eq '已签名确认' }">
							<a href="javascript:;" onclick="detail('${item.distribution_id}');">查看</a>
							</c:if>
						</td>
						</tr>
					</c:forEach>
				</tbody>
	  		</table>
		</form>
		<div class="panel-footer" style="margin-top: 20px;">
			<c:if test="${signname eq '未签名确认' }">
			<button type="button" class="btn btn-primary" onclick="confirm('${baseInfo.id}','${time}');">签名</button>
			</c:if>
			<c:if test="${signname eq '已签名确认' }">
			<button type="button" class="btn btn-info" onclick="watch();">查看签名</button>
			</c:if>
			<button type="button" class="btn btn-default" onclick="back();">返回</button>
		</div>
	</div>
	<div style="width: 100%;display: none;background: #16A085;" id="img">
		<img alt="签名信息" src="${signnameUrl}" style="width: 100%;height: 100%;">
	</div>
<script type="text/javascript">
function back(){
	window.location.href = '${path}/distribution/today_sh.do';
}
function modify(id){
	//window.location.href = '${path}/distribution/detail.do?id='+id;
}
function confirm(id,time){
	//弹出签名页面
	//上传名称和时间
	layer.open({
		type:2,
		title:'确认',
		closeBtn:1,
		area: ['90%','70%'],
		shadeClose: true,
		content: '${path}/distribution/sign.do?baseid='+id+"&time="+time
	})
}

function detail(id){
	window.location.href = "${path}/distribution/distributionDetailList.do?id="+id;
}

function watch(){
	layer.open({
		type:1,
		title:'查看签名',
		closeBtn:1,
		area: ['90%','45%'],
		shadeClose: true,
		content: $('#img')
	})
}

function closeModal(){
	layer.closeAll();
	window.location.href = "${path}/distribution/today_sh.do";
}
</script>
</body>
</html>
