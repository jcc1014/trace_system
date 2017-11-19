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
			<h3 class="panel-title">缺货单列表<!-- （距离供应单锁定还有：<span>30</span>分钟） --></h3>
		</div>
		<div class="panel-body">
			<button type="button" class="btn btn-success" onclick="createQhd('${today}');">生成缺货单</button>
		</div>
			<table class="table table-striped table-bordered table-condensed">
				<thead>
					<tr>
						<th>时间</th><th>类型</th><th>操作</th>
					</tr>
				</thead>
				<tbody id="tbody">
					<c:if test="${fn:length(list)==0 }">
						<tr><td colspan="3">暂无数据</td></tr>
					</c:if>
					<c:forEach var="item" items="${list}">
						<tr>
							<td>${item.createtime }</td>
							<td>缺货单</td>
							<td>
							<a href="javascript:;" onclick="watch('${item.id}');">查看</a>
							<c:if test="${today eq '1' }">
								<a href="javascript:;" onclick="setCgsc('${item.id}');">设置采购市场</a>
							</c:if>
							</td>
						</tr>
					</c:forEach>
				</tbody>
	  		</table>
		<div class="panel-footer" style="margin-top: 20px;">
			<button type="button" class="btn btn-default" onclick="back();">返回</button>
			<!-- <button type="button" class="btn btn-success" onclick="watch();">查看采购详单</button> -->
		</div>
	</div>
<script type="text/javascript">
function watch(id){
	window.location.href = '${path}/purchaseInfo/getQhInfo.do?id='+id;
}
function setCgsc(id){
	window.location.href = '${path}/purchaseInfo/setQhsc.do?id='+id;
}
function back(){
	window.location.href = '${path}/baseInfo/index.do';
}
function createQhd(today){
	if('1'==today){
		layer.confirm('今日的缺货单已经生成确定重置吗？',{tilte:'提示',btn:['是','否']},function(){
			create();
		},function(){
			return;
		})
	}else{
		create();
	}
	
}

function create(){
	$.ajax({
		url:'${path}/purchaseInfo/createQhd.do',
		type:'POST',
		dataType:'json',
		success:function(rs){
			if(""!=rs){
				rs = $.parseJSON(rs);
				if("200"==rs.code){
					layer.msg('生成成功！',{time:1000},function(){
						self.location.reload();
					})
				}else{
					layer.msg('生成失败！',{time:1000},function(){
						self.location.reload();
					})
				}
			}
		}
	})
}
</script>
</body>
</html>
