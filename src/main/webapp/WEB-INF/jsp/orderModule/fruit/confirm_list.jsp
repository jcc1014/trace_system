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
			<h3 class="panel-title">${date}签收</h3>
		</div>
		<div class="panel-body">
		</div>
		<form action="" method="post" id="form">
			<table class="table table-striped table-bordered table-condensed">
				<thead>
					<tr>
						<th>种类</th><th>品级</th><th>厂家</th><th>数量</th>
					</tr>
				</thead>
				<tbody id="tbody">
					<c:if test="${null==list || fn:length(list)==0 }">
						<tr><td colspan="5">暂无数据</td></tr>
					</c:if>
					<c:if test="${null!=list  }">
					<c:forEach var="item" items="${list}">
						<tr>
							<td>${item.kind}</td>
							<td>${item.grade}</td>
							<td>${item.sccj}</td>
							<td>${item.num}</td>
						</tr>
					</c:forEach>
					</c:if>
				</tbody>
	  		</table>
		</form>
		<div class="panel-footer" style="margin-top: 20px;">
			<c:if test="${signname eq 'no' }">
			<button type="button" class="btn btn-primary" onclick="confirm('${baseInfo.id}','${time}');">签名</button>
			</c:if>
			<c:if test="${signname eq 'yes' }">
			<button type="button" class="btn btn-info" onclick="watch();">查看签名</button>
			<button type="button" class="btn btn-info" onclick="detail('${require_id}');">详情</button>
			</c:if>
			<button type="button" class="btn btn-default" onclick="window.history.go(-1);">返回</button>
		</div>
	</div>
<div style="width: 100%;display: none;background: #16A085;" id="img">
		<img alt="签名信息" src="${signnameUrl}" style="width: 100%;height: 100%;">
</div>
<script type="text/javascript">
function add(){
	//window.location.href = "${path}/meat/add.do";
	layer.open({
		type:2,
		closeBtn:1,
		area: ['90%','90%'],
		shadeClose: true,
		content: ['${path}/meat/add.do']
	})
}
function closeModal(){
	layer.closeAll();
	//window.location.href = "${path}/meat/list.do";
}
function reload(){
	self.location.reload();
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
		content: '${path}/meat/sign.do?baseid='+id+"&time="+time
	})
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

function detail(id){
	window.location.href = "${path}/meat/detail.do?id="+id;
}
</script>
</body>
</html>
