<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../common/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>增加取样</title>
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
	<div id="add">
		<form action="${path}/sampling/addSamplingSave.do" method="post" id="form">
			<div class="form-group">
				<label for="test_kind">种类和品级</label> <select class="form-control"
					id="test_kind" name="test_kind">
					<option value="">请选择</option>
					<c:forEach items="${purchaseInfoList}" var="item">
						<option value="${item.kind};${item.grade}">${item.kind}${item.grade}级</option>
					</c:forEach>
				</select>
			</div>
			<div class="form-group">
				<label for="farmer_name">农户</label> <input type="text"
					class="form-control" id="farmer_name" name="farmer_name" placeholder="农户">
			</div>
			<div class="form-group">
				<label for="farmer_phone">手机</label> <input type="text"
					class="form-control" id="farmer_phone" name="farmer_phone" placeholder="手机">
			</div>
			<div class="form-group">
				<label for="farmer_hzs">合作社</label> <input type="text"
					class="form-control" id="farmer_hzs" name="farmer_hzs" placeholder="合作社">
			</div>
			<div class="form-group">
				<label for="test_bh">取样编号</label> <input type="text"
					class="form-control" id="test_bh" name="test_bh" placeholder="取样编号">
			</div>
			<div class="form-group">
				<label for="test_num">取样数量</label> <input type="text"
					class="form-control" id="test_num" name="test_num" placeholder="取样数量">
			</div>
			<!-- <div class="form-group">
				<label for="test_num">取样视频</label> 
				
			</div> -->
			<div class="form-group" style="text-align: center;">
				<button type="button" class="btn btn-success"
					onclick="save();">保存</button>
				<button type="button" class="btn btn-default" onclick="back();">返回</button>
			</div>
		</form>
	</div>
	<script type="text/javascript">

function submit(){
	$.ajax({
		type:'post',
		url:'${path}/require/submitXqd.do',
		data:{'id':'${totalInfo.id}'},
		dataType:'json',
		success:function(rs){
			if(null!=rs&&""!=rs){
				rs = $.parseJSON(rs);
				if(rs.code=="200"){
					layer.msg('提交成功！',{time:1000},function(){
						self.location.reload();
					})
				}
				
			}
		}
	})
}


function save(){
	var test_kind = $("#test_kind").val();
	if(""==test_kind){
		layer.msg('请选择种类！',{time:1000});
		return;
	}
	var farmer_name = $("#farmer_name").val();
	if(""==farmer_name){
		layer.msg('请填写农户！',{time:1000});
		return;
	}
	var farmer_phone = $("#farmer_phone").val();
	if(""==farmer_phone){
		layer.msg('请填写手机！',{time:1000});
		return;
	}
	var farmer_hzs = $("#farmer_hzs").val();
	if(""==farmer_hzs){
		layer.msg('请填写合作社！',{time:1000});
		return;
	}
	var test_bh = $("#test_bh").val();
	if(""==test_bh){
		layer.msg('请填写取样编号！',{time:1000});
		return;
	}
	var test_num = $("#test_num").val();
	if(""==test_num||isNaN(test_num)){
		layer.msg('取样数量格式不正确！',{time:1000});
		return;
	}
	$("#form").submit();
}

function close(){
	layer.closeAll();
}
</script>
</body>
</html>
