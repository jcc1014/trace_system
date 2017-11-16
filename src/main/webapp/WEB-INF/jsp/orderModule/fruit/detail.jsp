<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../common/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title></title>
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
			<h3 class="panel-title">详情</h3>
		</div>
		<div class="panel-body">
		</div>
		<form action="" method="post" id="form">
			<table class="table table-striped table-bordered table-condensed">
				<thead>
					<tr>
						<th>配送码</th><th>数量</th><th>批次号</th><th>姓名</th><th>车牌号</th><th>二维码</th>
					</tr>
				</thead>
				<tbody id="tbody">
					<c:if test="${null==list || fn:length(list)==0 }">
						<tr><td colspan="6">暂无数据</td></tr>
					</c:if>
					<c:if test="${null!=list  }">
					<c:forEach var="item" items="${list}">
						<tr>
							<td>${item.code}</td>
							<td>${item.num}</td>
							<td>${item.pch}</td>
							<td>${item.xm}</td>
							<td>${item.cph}</td>
							<td>
								<a href="javascript:;" onclick="qrcode('${item.qrcode }')">
									<img alt="二维码" style="width:2rem;height: 2rem" src="${path}/images/qrcode-mini.png">
								</a>
							</td>
						</tr>
					</c:forEach>
					</c:if>
				</tbody>
	  		</table>
		</form>
		<div class="panel-footer" style="margin-top: 20px;">
			<c:if test="${fn:length(list)>0} ">
				<!-- <button type="button" class="btn btn-primary" onclick="submit();">提交</button> -->
			</c:if>
			<!-- <button type="button" class="btn btn-primary" onclick="add();">新增</button> -->
			<button type="button" class="btn btn-default" onclick="window.history.go(-1);">返回</button>
		</div>
	</div>
<div style="width: 100%;display: none;background: #16A085;" id="img">
		<img alt="二维码" src="" style="width: 100%;height: 100%;">
</div>
<script type="text/javascript">
function closeModal(){
	layer.closeAll();
	self.location.reload();
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
				$("#img img").attr("src","${path}/qrcode/"+rs.qrcode_path);
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
