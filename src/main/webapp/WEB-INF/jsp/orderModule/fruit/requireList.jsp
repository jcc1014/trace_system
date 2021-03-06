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
			<h3 class="panel-title">${date}今日需求</h3>
		</div>
		<div class="panel-body">
		<button type="button" class="btn btn-primary" onclick="add();">新增</button>
		</div>
		<form action="" method="post" id="form">
			<table class="table table-striped table-bordered table-condensed">
				<thead>
					<tr>
						<th>种类</th><th>品级</th><th>厂家</th><th>数量</th><th>操作</th>
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
							<td><a href="javascript:;" onclick="del('${item.id}');">删除</a></td>
						</tr>
					</c:forEach>
					</c:if>
				</tbody>
	  		</table>
		</form>
		<div class="panel-footer" style="margin-top: 20px;">
			<c:if test="${fn:length(list)>0} ">
			</c:if>
			<button type="button" class="btn btn-primary" onclick="submit();">提交</button> 
			<button type="button" class="btn btn-primary" onclick="add();">新增</button>
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
		content: ['${path}/fruit/require_add.do']
	})
}
function closeModal(){
	layer.closeAll();
	window.location.href = "${path}/fruit/requireList.do";
}
function del(id){
	$.ajax({
		url:'${path}/fruit/delete.do',
		type:'post',
		dataType:'json',
		data:{'id':id},
		success:function(rs){
			if(""!=rs){
				rs = $.parseJSON(rs);
				lay.msg('删除成功！',{time:1000},function(){
					location.href = '${path}/fruit/list.do';
				})
			}
		}
	})
}
function submit(){
	$.ajax({
		url:'${path}/fruit/submitRequire.do',
		type:'post',
		dataType:'json',
		success:function(rs){
			if(""!=rs){
				rs = $.parseJSON(rs);
				layer.msg('提交成功！',{time:1000},function(){
					location.href = '${path}/fruit/requireList.do';
				})
			}
		}
	})
}
</script>
</body>
</html>
