<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../common/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>采购单详情</title>
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
			<h3 class="panel-title">今日采购单<!-- （距离供应单锁定还有：<span>30</span>分钟） --></h3>
		</div>
		<div class="panel-body">
			<div><h4>采购单信息</h4></div>
			<div>名称：${totalInfo.name}</div>
			<div>时间：${totalInfo.createtime}</div>
			<div>产地：${totalInfo.source_name}</div>
			<div>类型：
				<c:if test="${totalInfo.source_type eq '1'}">生产基地</c:if>
				<c:if test="${totalInfo.source_type eq '5'}">供应基地</c:if>
			</div>
			<div>产地负责人：${u.username}</div>
		</div>
		<form action="" method="post" id="form">
			<table class="table table-striped table-bordered table-condensed">
				<thead>
					<tr>
						<th>种类</th><th>品级</th><th>三品一标</th><th>供应价</th><th>供应量</th><th>采购量</th><th>操作</th>
					</tr>
				</thead>
				<tbody id="tbody">
					<c:if test="${fn:length(purchaseInfos)==0 }">
						<tr><td colspan="7">暂无数据</td></tr>
					</c:if>
					<c:forEach var="item" items="${purchaseInfos}">
						<tr>
							<td>${item.kind }</td>
							<td>${item.grade }</td>
							<td>${item.spyb }</td>
							<td>${item.price }</td>
							<td>${item.supply_number}</td>
							<td>${item.number }</td>
							<td>
							<c:if test="${totalInfo.status eq '0' }">
							<a href="javascript:;" onclick="edit('${item.purchase_id}','${item.supply_number}');"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span></a>
							</c:if>
							<c:if test="${totalInfo.status eq '1' }">
								已提交
							</c:if>
						</td>
						</tr>
					</c:forEach>
				</tbody>
	  		</table>
		</form>
		<div class="panel-footer" style="margin-top: 20px;">
			<c:if test="${fn:length(purchaseInfos)>0 && totalInfo.status eq '0' }">
				<button type="button" id="submit" class="btn btn-primary hide" onclick="submit();">提交</button>
			</c:if>
			<button type="button" class="btn btn-default" onclick="window.history.go(-1);">返回</button>
		</div>
	</div>
<div style="display:none;padding: 5%;" id="modal_edit">
<form>
  <div class="form-group">
    <label for="modal_number">供应量</label>
    <input type="hidden" id="modal_id" >
    <input type="number" class="form-control" id="modal_supply_number" readonly="readonly">
  </div>
  <div class="form-group">
    <label for="modal_number">采购量</label>
    <input type="number" class="form-control" id="modal_number" placeholder="采购量">
  </div>
  <div class="form-group" style="text-align: center;">
	  <button type="button" class="btn btn-success" onclick="modal_edit_save();">保存</button>
	  <button type="button" class="btn btn-default" onclick="layer.closeAll();">关闭</button>
  </div>
</form>
</div>
<script type="text/javascript">
$(function(){
	//设置一个定时器，五点之后开启
	setInterval("time();",1000);
})
function time(){
	var date = new Date();
    var seperator1 = "-";
    var seperator2 = ":";
    var month = date.getMonth() + 1;
    var strDate = date.getDate();
    if (month >= 1 && month <= 9) {
        month = "0" + month;
    }
    if (strDate >= 0 && strDate <= 9) {
        strDate = "0" + strDate;
    }
    var currentdate = date.getFullYear() + seperator1 + month + seperator1 + strDate
            + " " + date.getHours() + seperator2 + date.getMinutes()
            + seperator2 + date.getSeconds();
    var time = date.getHours() + seperator2 + date.getMinutes()
    + seperator2 + date.getSeconds();
    if(time=="17:00:00"||time>"17:00:00"){
    	$("#submit").show();
    }
}
//格式化时间
function formatTime(time){
	//小于10的数以ss格式显示
	if(10>parseInt(time)){
		time = "0"+time;
	}
	return time;
}
function submit(){
	$.ajax({
		url:'${path}/purchaseInfo/submit.do',
		type:'post',
		data:{'id':'${totalInfo.id}'},
		dataType:'JSON',
		success:function(rs){
			if(""!=rs){
				rs = $.parseJSON(rs);
				if("200"==rs.code){
					layer.msg('提交成功！',{time:1000},function(){
						self.location.reload();
					});
				}
			}
		}
	})
}

function edit(id,supply_number){
	$("#modal_id").val(id);
	$("#modal_supply_number").val(supply_number);
	layer.open({
		type:'1',
		title:'修改采购量',
		closeBtn:1,
		area: ['90%','45%'],
		shadeClose: true,
		content: $('#modal_edit')
	})
}

function modal_edit_save(){
	var number = $("#modal_number").val();
	var id = $("#modal_id").val();
	if(""==number||isNaN(parseFloat(number))){
		layer.msg('输入数量格式不正确！',{time:1000},function(){
			return;
		})
	}
	var supply_number = $("#modal_supply_number").val();
	if(supply_number<number){
		layer.alert('供应量应该大于采购量，请返回修改',{title:'提示'},function(index){
			
		})
	}else{
		$.ajax({
			url:'${path}/purchaseInfo/editSave.do',
			type:'post',
			data:{'id':id,'number':number},
			dataType:'JSON',
			success:function(rs){
				if(""!=rs){
					rs = $.parseJSON(rs);
					if("200"==rs.code){
						layer.msg('保存成功！',{time:1000},function(){
							self.location.reload();
						});
					}
				}else{
					layer.msg('保存失败！',{time:1000});
				}
			}
		})
	}
	
}
</script>
</body>
</html>
