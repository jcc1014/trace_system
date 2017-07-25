<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../common/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>详情</title>
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
			<div>名称：${distributionInfo.require_name}</div>
			<div>时间：${distributionInfo.createtime}</div>
			<div>种类：${distributionInfo.kind}</div>
			<div>品级：${distributionInfo.grade}</div>
			<div>数量：${distributionInfo.require_num}</div>
			<div>实际数量：${distributionInfo.require_num}</div>
			<div>价格：${distributionInfo.price }</div>
			<div>总价：${distributionInfo.sum_price }</div>
		</div>
		<form action="" method="post" id="form">
			<table class="table table-striped table-bordered table-condensed">
				<thead>
					<tr>
						<th>编码</th>
						<th>数量</th>
						<th>配送人</th>
						<th>车辆</th>
						<th>二维码</th>
						<th>蔬菜编码</th>
					</tr>
				</thead>
				<tbody id="tbody">
					<c:if test="${fn:length(list)==0 }">
						<tr><td colspan="6">暂无数据</td></tr>
					</c:if>
					<c:forEach var="item" items="${list}" varStatus="index">
						<tr>
							<td><%-- ${item.id } --%>${index.index+1 }</td>
							<td>${item.distribution_num }</td>
							<td>${item.distribution_user }</td>
							<td>${item.distribution_car }</td>
							<td>
								<a href="javascript:;" onclick="qrcode('${item.distribution_qrcode }')">
									<img alt="二维码" style="width:2rem;height: 2rem" src="${path}/images/qrcode-mini.png">
								</a>
							</td>
							<td>${item.trace_id }</td>
						</tr>
					</c:forEach>
				</tbody>
	  		</table>
		</form>
		<div class="panel-footer" style="margin-top: 20px;">
			<button type="button" class="btn btn-default" onclick="back();">返回</button>
		</div>
	</div>
	<div style="width: 100%;display: none;background: #16A085;" id="img">
		<img alt="二维码" src="" style="width: 100%;height: 100%;">
	</div>
<script type="text/javascript">
function back(){
	window.location.href = '${path}/distribution/today_shDetail.do';
}

function closeModal(){
	layer.closeAll();
}
function qrcode(id){
	$.ajax({
		type:'post',
		url:'${path}/distribution/getQrcode.do',
		data:{'id':id},
		dataType:'json',
		success:function(rs){
			if(""!=rs){
				rs = $.parseJSON(rs);
				$("#img img").attr("src","${path}/distribution/"+rs.qrcode_path);
				layer.open({
					type:1,
					title:'二维码',
					closeBtn:1,
					area: ['90%','60%'],
					shadeClose: true,
					content: $('#img')
				})
			}else{
				layer.msg('暂时无法查看二维码！',{time:1000});
			}
		}
	})
}
</script>
</body>
</html>
