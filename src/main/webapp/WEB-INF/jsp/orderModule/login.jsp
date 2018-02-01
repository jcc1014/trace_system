<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
   <title>信息管理系统</title>
   <link rel="stylesheet" href="${cg}/fonts/iconfont.css"/>
   <link rel="stylesheet" href="${cg}/css/font.css"/>
   <link rel="stylesheet" href="${cg}/css/mui.css"/>
   <link rel="stylesheet" href="${cg}/css/weui.min.css"/>
   <link rel="stylesheet" href="${cg}/css/jquery-weui.min.css"/>
   <link rel="stylesheet" href="${cg}/css/animate.css"/>
   <link rel="stylesheet" href="${cg}/css/pages/login.css"/>
   <style type="text/css">
   	.header{border-top: 0rem solid #0498a1;}
   	
   </style>
   <script>(function (doc, win) {
     var docEl = doc.documentElement,
       resizeEvt = 'orientationchange' in window ? 'orientationchange' : 'resize',
       recalc = function () {
         var clientWidth = docEl.clientWidth;
         if (!clientWidth) return;
         docEl.style.fontSize = 20 * (clientWidth / 320) + 'px';
       };

     if (!doc.addEventListener) return;
     win.addEventListener(resizeEvt, recalc, false);
     doc.addEventListener('DOMContentLoaded', recalc, false);
   })(document, window);</script>
</head>
<body>
    <div class="header">
        <img src="${cg}/images/login_logo_w.png">

        <h2></h2>
    </div>
    <div class="login-wrap">
        <div class="login-box">
            <form>
                <div class="input-wrap">
                    <input type="text" id="username" value="${username}" placeholder="请输入登录用户名">
                </div>
                <div class="input-wrap">
                    <input type="password" id="password" value="${password}" placeholder="请输入登录密码">
                </div>
                <!-- <div class="input-wrap">
                    <input type="text" name="yanzm" placeholder="验证码">

                    <img src="images/vcode.jpg" class="validate-code">
                </div> -->
            </form>
        </div>
        <!-- <div class="btns">
            <a href="javascript:;" class="current">采购商</a>
            <a href="javascript:;">供应商</a>
        </div> -->
        <a href="javascript:;" onclick="login();" style="margin-top: 2rem;"
        class="weui_btn login-btn weui_btn_primary">登录</a>
    </div>
    <div class="footer">
        Copyright&nbsp;&copy;&nbsp;济南福德科技有限公司&nbsp;版权所有
    </div>
<script type="text/javascript">
function login(){
	var username = $("#username").val();
	if(""==username){
		layer.msg('请填写用户名！',{time:1000});
		return;
	}
	var password = $("#password").val();
	if(""==password){
		layer.msg('请填写密码！',{time:1000});
		return;
	}
	$.ajax({
		url:'${path}/baseInfo/loginCheck.do',
		type:'post',
		data:{'username':username,'password':password},
		dataType:'json',
		success:function(rs){
			if(null!=rs&&""!=rs){
				rs = $.parseJSON(rs);
				if("200"==rs.code){
					layer.msg(rs.msg,{time:1000},function(){
						window.location.href = '${path}/baseInfo/index.do';
					});
				}else{
					layer.msg(rs.msg,{time:1000});
				}
			}
		}
	})
}
	

function showMain(id) {
	$(".login-main").hide();
	$("#"+id).show();
}
</script>    
</body>
</html>