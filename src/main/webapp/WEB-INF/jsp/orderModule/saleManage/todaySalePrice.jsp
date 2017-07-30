<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../common/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>销售定价</title>
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
		tbody tr td{text-align: center; }
		table {border-bottom: 1px solid #eee; }
		input {width: 4rem;}
	</style>

</head>
<body>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title">今日定价单<!-- （距离供应单锁定还有：<span>30</span>分钟） --></h3>
		</div>
		<div class="panel-body">
		</div>
		<form action="" method="post" id="form">
			<table class="table table-striped table-bordered table-condensed">
				<thead>
					<tr>
						<th>种类</th>
						<th>品级</th>
						<th>三品一标</th>
						<th>价格</th>
						<th>食堂</th>
						<th>超市</th>
						<th>零售</th>
						<th>其他</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody id="tbody">
					<c:if test="${fn:length(salePriceList)==0 }">
						<tr><td colspan="9">暂无数据</td></tr>
					</c:if>
					<c:forEach var="item" items="${salePriceList}">
						<tr>
							<td>${item.kind }</td>
							<td>${item.grade }</td>
							<td>${item.spyb }</td>
							<td>${item.price }</td>
							<td>
								<c:if test="${item.status eq '0' }">
									<input type="number" class="canteen_price" />
								</c:if>
								<c:if test="${item.status ne '0' }">
									${item.canteen_price }
								</c:if>
							</td>
							<td>
								<c:if test="${item.status eq '0' }">
									<input type="number" class="market_price" />
								</c:if>
								<c:if test="${item.status ne '0' }">
									${item.market_price }
								</c:if>
							</td>
							<td>
								<c:if test="${item.status eq '0' }">
									<input type="number" class="retail_price" />
								</c:if>
								<c:if test="${item.status ne '0' }">
									${item.retail_price }
								</c:if>
							</td>
							<td>
								<c:if test="${item.status eq '0' }">
									<input type="number" class="other_price" />
								</c:if>
								<c:if test="${item.status ne '0' }">
									${item.other_price }
								</c:if>
							</td>
							<td>
							<c:if test="${item.status eq '0' }">
							<a href="javascript:;" data-id='${item.id}' onclick="savePrice(this);">保存</a>
							</c:if>
							<c:if test="${item.status eq '1' }">
								完成
							</c:if>
						</td>
						</tr>
					</c:forEach>
				</tbody>
	  		</table>
		</form>
		<div class="panel-footer" style="margin-top: 20px;">
			<button type="button" class="btn btn-default" onclick="back();">返回</button>
		</div>
	</div>
<script type="text/javascript">
$(function(){
	if(''!='${msg}'){
		layer.msg('${msg}',{time:1000});
	}
})
function back(){
	window.location.href = '${path}/baseInfo/index.do';
}
function savePrice(obj){
	_this = $(obj);
	var id = _this.data("id");
	var canteen_price = _this.parent().parent().find(".canteen_price").val();
	if("0.0"==canteen_price||""==canteen_price||null==canteen_price||isNaN(canteen_price)){
		layer.msg('食堂价格格式不正确，请检查！',{time:1000},function(){
			return;
		});
	}
	var market_price = _this.parent().parent().find(".market_price").val();
	if("0.0"==market_price||""==market_price||null==market_price||isNaN(market_price)){
		layer.msg('超市价格格式不正确，请检查！',{time:1000},function(){
			return;
		});
	}
	var retail_price = _this.parent().parent().find(".retail_price").val();
	if("0.0"==retail_price||""==retail_price||null==retail_price||isNaN(retail_price)){
		layer.msg('零售价格格式不正确，请检查！',{time:1000},function(){
			return;
		});
	}
	var other_price = _this.parent().parent().find(".other_price").val();
	if("0.0"==other_price||""==other_price||null==other_price||isNaN(other_price)){
		layer.msg('其他价格格式不正确，请检查！',{time:1000},function(){
			return;
		});
	}
	$.ajax({
		url:'${path}/salePrice/savePrice.do',
		type:'post',
		data:{'id':id,'canteen_price':canteen_price,'market_price':market_price,
			'retail_price':retail_price,'other_price':other_price,'status':'1'},
		dataType:'json',
		success:function(rs){
			if(""!=rs){
				rs = $.parseJSON(rs);
				if("200"==rs.code){
					layer.msg('保存成功！',{time:1000},function(){
						self.location.reload();
					})
				}
				else{
					layer.msg('保存失败！',{time:1000},function(){
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
