<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../common/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>生产基地</title>
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
		
	</style>
</head>
<body>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title">修改密码</h3>
		</div>
		<div class="panel-body">
			<form>
				<div class="form-group">
					<label for="password">原密码</label> <input type="password"
						class="form-control" id="password" placeholder="原密码" onblur="check();">
				</div>
				<div class="form-group">
					<label for="new_password">新密码</label> <input
						type="password" class="form-control" id="new_password"
						placeholder="新密码">
				</div>
				<div class="form-group">
					<label for="confirm_password">确认密码</label> <input
						type="password" class="form-control" id="confirm_password"
						placeholder="确认密码">
				</div>
				<button type="button" onclick="modify();" class="btn btn-primary">修改</button>
				<button type="button" onclick="window.history.go(-1);" class="btn btn-default">返回</button>
			</form>
		</div>
	</div>
<script type="text/javascript">
function check(){
	var password = $("#password").val();
	if(""==password){
		layer.msg('原密码不能为空！',{time:1000});
		$("#password").focus();
		return;
	}
	$.ajax({
		type:'post',
		url:'${path}/produce/checkPassword.do',
		dataType:'json',
		data:{'password':password},
		success:function(rs){
			if(""!=rs){
				rs = $.parseJSON(rs);
				if(rs.code!="200"){
					layer.msg('原密码不正确!',{time:1000},function(){
						$("#password").val("").focus();
					})
				}
			}
		}
	})
}
function modify(){
	var password = $("#password").val();
	var new_password = $("#new_password").val();
	var confirm_password = $("#confirm_password").val();
	if(""==password){
		layer.msg('原密码不能为空！',{time:1000});
		return;
	}
	if(""==new_password){
		layer.msg('新密码不能为空！',{time:1000});
		return;
	}
	if(password==new_password){
		layer.msg('新密码不能与原密码相同！',{time:1000});
		return;
	}
	if(confirm_password!=new_password){
		layer.msg('新密码和确认密码不一致！',{time:1000});
		return;
	}
	$.ajax({
		type:'post',
		url:'${path}/produce/modifyPassword.do',
		dataType:'json',
		data:{'new_password':new_password},
		success:function(rs){
			if(""!=rs){
				rs = $.parseJSON(rs);
				if(rs.code=="200"){
					layer.msg('密码修改成功!',{time:1000},function(){
						window.location.href = '${path}/baseInfo/login.do';
					})
				}else{
					layer.msg('密码修改失败!',{time:1000})
				}
			}
		}
	})
	
}
</script>
</body>
</html>
