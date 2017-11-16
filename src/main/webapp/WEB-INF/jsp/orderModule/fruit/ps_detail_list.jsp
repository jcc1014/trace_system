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
			<h3 class="panel-title">${date}配送</h3>
		</div>
		<div class="panel-body">
		</div>
		<form action="" method="post" id="form">
			<table class="table table-striped table-bordered table-condensed">
				<thead>
					<tr>
						<th>名称</th><th>配送号</th><th>数量</th><th>编号</th><th>状态</th>
					</tr>
				</thead>
				<tbody id="tbody">
					<c:if test="${null==list || fn:length(list)==0 }">
						<tr><td colspan="5">暂无数据</td></tr>
					</c:if>
					<c:if test="${null!=list  }">
					<c:forEach var="item" items="${list}">
						<tr>
							<td>${requireFruit.kind}${requireFruit.grade}级</td>
							<td>${item.pch}</td>
							<td>${item.num}</td>
							<td>${item.code}</td>
							<td>
							<c:if test="${item.status eq '1' }">
								未收货
							</c:if>
							<c:if test="${item.status eq '2' }">
								已收货
							</c:if>
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
			<!-- <button type="button" class="btn btn-primary" onclick="detail();">详单</button> -->
			<button type="button" class="btn btn-default" onclick="window.history.go(-1);">返回</button>
		</div>
	</div>
<script type="text/javascript">
function add(){
	//window.location.href = "${path}/meat/add.do";
	layer.open({
		type:2,
		closeBtn:1,
		area: ['90%','90%'],
		shadeClose: true,
		content: ['${path}/fruit/ps.do']
	})
}
function ps(id){
	//window.location.href = "${path}/meat/add.do";
	layer.open({
		type:2,
		closeBtn:1,
		area: ['90%','90%'],
		shadeClose: true,
		content: ['${path}/fruit/ps.do?id='+id]
	})
}
function closeModal(){
	layer.closeAll();
	self.location.reload();
}
function del(id){
	$.ajax({
		url:'${path}/fruit/delete',
		type:'post',
		dataType:'json',
		data:{'id':id},
		success:function(rs){
			if(""!=rs){
				rs = $.parseJSON(rs);
				lay.msg('删除成功！',{title:'提示'},function(){
					location.href = '${path}/fruit/list.do';
				})
			}
		}
	})
}
function detail(id){
	window.location.href = "${path}/fruit/psDetailList.do?id="+id;
}

</script>
</body>
</html>
