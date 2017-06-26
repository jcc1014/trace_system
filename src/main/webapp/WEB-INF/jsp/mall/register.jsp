<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>${mall}</title>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" type="text/css" href="${path}/css/ui.css">
	<!-- <link href="favicon.ico" type="image/x-icon" rel="icon">
    <link href="iTunesArtwork@2x.png" sizes="114x114" rel="apple-touch-icon-precomposed"> -->
</head>

<body>
<div class="header">
	<div class="" style="background:none"></div>
	<div class="toolbar statusbar-padding">
		<button class="bar-button back-button" style="left:-10px" onclick="history.go(-1);" dwz-event-on-click="click"><i class="icon icon-back-s"></i></button>
		<div class="header-title">
			<div class="title"></div>
		</div>
	</div>
</div>

<div class="aui-login-ba" style="position:relative; overflow:hidden">

	<span class="aui-login-logo"><!-- <img src="images/ui-logo/aui-logo.png"> --></span>

	<canvas id="waves" class="waves" style="position:absolute; bottom:-60px; left:-210px;"></canvas>

</div>

<div class="aui-logon-con">
	<div class="b-line">
		<input type="text" id="phone" placeholder="手机号">
	</div>
	<!-- <div class="b-line">
		<input type="text" id="yzm" placeholder="验证码"><button style="float: right;margin-top: 10px;">获取</button>
	</div> -->
	<div class="b-line">
		<input type="password" id="password" placeholder="密  码">
	</div>
	<div class="b-line">
		<input type="password" id="confirm_password" placeholder="确认密码">
	</div>
	<div class="aui-login-l">
		<a href="javaScript:void(0);" onclick="register();">注册</a>
	</div>
	<div class="aui-login-wen">
		<div class="aui-login-wen-a"><a href="${path}/mall/login.do">去登录</a> </div>
		<!--<div><a href="#">忘记密码?</a> </div>-->
	</div>
	<!--<div class="aui-login-san">-->
		<!--<div class="aui-login-qq"><a href="#"></a></div>-->
		<!--<div class="aui-login-wb"><a href="#"></a></div>-->
		<!--<div class="aui-login-wx"><a href="#"></a></div>-->
	<!--</div>-->
</div>
<script type="text/javascript" src="${path}/js/jquery.min.js"></script>
<script>jQuery.noConflict()</script>
<script type="text/javascript" src="${path}/layer/layer.js"></script>
<script src="${path}/js/css3/49f8daee.vendors.js"></script>
<script src="${path}/js/css3/26f2fc0d.index.js"></script>
<script type="text/javascript" src="${path}/js/commonUtil.js"></script>
<script type="text/javascript">
function register(){
	var phone = $("#phone").val();
	if(!isTelephone(phone)){
		  layer.msg("手机号不合法！",{time:1000},function(){
			  $("#phone").focus().val("");
		  });
			  return;
	 }
	var password = $("#password").val();
	var confirm_password = $("#confirm_password").val();
	if(""==password){
		layer.msg("请输入密码！",{time:1000},function(){
			  $("#password").focus().val("");
		  });
			  return;
	}
	if(4>password.length){
		layer.msg("密码长度太短！",{time:1000},function(){
			  $("#password").focus().val("");
		  });
			  return;
	}
	if(""==confirm_password){
		layer.msg("请确认密码！",{time:1000},function(){
			  $("#confirm_password").focus().val("");
		  });
			  return;
	}
	if(password!=confirm_password){
		layer.msg("两次密码不一致！",{time:1000},function(){
			  $("#confirm_password").focus().val("");
		  });
			  return;
	}
	$.ajax({
		type:'post',
		url:'${path}/mall/checkPhone.do',
		data:{'phone':phone},
		dataType:'text',
		success:function(data){
			if(data=="\"1\""){
				layer.msg("手机号已经被注册！",{time:1000});
				return;
			}else{
				try {
					$.ajax({
						url:'${path}/mall/addSave.do',
						type:'post',
						dataType:'json',
						data:{'phone':phone,'password':password},
						success:function(rs){
							if(""!=rs){
								layer.msg('注册成功！',{time:1000},function(){
									window.location.href = '${path}/mall/user.do';
								})
							}
						},
						error:function(){
							layer.msg("error");
						}
					})
				} catch (e) {
					console.log(e);
				}
				
			}
		}
	})
	
	
}
</script>
</body>
</html>