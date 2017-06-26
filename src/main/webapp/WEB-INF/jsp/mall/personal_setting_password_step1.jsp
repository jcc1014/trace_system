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
	<link href="${path}/css/ui.css" rel="stylesheet" />
	<!-- 引入js资源 -->
	<script type="text/javascript" src="${path}/js/jquery.min.js"></script>
	<script>jQuery.noConflict()</script>
	<script type="text/javascript" src="${path}/layer/layer.js"></script>
	<script type="text/javascript" src="${path}/js/zepto.min.js"></script>
	<script type="text/javascript" src="${path}/js/zepto.kslider.js"></script>
	<script type="text/javascript" src="${path}/js/add/js/jquery.gcjs.js"></script>
	<script type="text/javascript" src="${path}/js/commonUtil.js"></script>
	<style type="text/css">
		.confirmOrder img {
			width: 4.0rem;
			height: 4.0rem;
			float: left;
			margin-right: .5rem;
		}
		body {margin:0px; background:#efefef; font-family:'微软雅黑'; -moz-appearance:none;}
		a {text-decoration:none;}
		input{-webkit-appearance: none;border:none; background:none;
		
		}
		.address_list .ico i { font-size:24px;margin-top:15px;margin-left:10px;z-index:2;position: relative;}
		.address_list .info .inner .user span {color:#444; font-size:16px;}
		
		.address_main {height:auto;width:98%; border-bottom:1px solid #f0f0f0; border-top:1px solid #f0f0f0; margin:14px auto; background:#fff;}
		.address_main .line {padding:0px 3%; height:44px; width:100%; line-height:44px; border-bottom:1px solid #f0f0f0;}
		.address_main .line input {float:left; height:44px; width:100%; padding:0px; margin:0px; border:0px; outline:none; font-size:16px; color:#666;padding-left:5px;}
		.U-guodu-box div{ color:#fff; line-height:20px; font-size:12px; margin:0px auto; height:100%; padding-top:10%; padding-bottom:10%;}
		.address_sub1 {height:44px; width:98%; margin:14px auto; background-image: -webkit-gradient(linear, left top, left bottom, color-stop(0, #f44336), color-stop(1, #ed394a)); border-radius:4px; text-align:center; font-size:16px; line-height:44px; color:#fff;}
		.fa-angle-left{
			background-image: url('data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAMgAAADICAYAAACtWK6eAAAC/ElEQVR4nO3dwXETaxCFUYdACA7BITgEQlAIN5SXAc4AMiAEO4MXAs5ALCQKlWt6GnCLoUbnVHmvu/g2Kqv/uzsAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADoJTkkedj6c8A/5xzHMck3kcCFJB/PcRxFAheSPJyDOIoELqzEIRJu2y/EcRnJh60/L/w1vxHHj79nkXAT/iAOkXAb3hGHSNi3gTiOSZ623gHjxAGFJB+S/C8OeOMcx7M44I2hOL5svQPGDcXx4hsrdkccUBAHFMQBBXHAiiRfxQELknwSBywQBxQG4niNXwuyR+KAgjigIA4oiAMK4oBCfp4EFQdcEgcUBuI4JnncegeMG4rjsPUOGCcOKIgDCuKAgjigkNPVQ3HAW5k5CXrYegeMG4ojW++AcUNxPG29A8aJAwrigII4oCAOKCS5FwcsiAdsYJk4oDAUx0tcPWRvxAEFcUBBHFAQBxTEASvijQ5YJg4oDMTxmuR+6x0wbigOJ0HZH3FAQRxQEAcUxAGFnIgD3ooHbGDZQBzHeMCGPRqK47D1DhgnDiiIAwrigII4YIVAoCESaIgEGiKBhkigMRTJ49Y74GoGIvkW/6zInokEGkn+EwmsSPIkElghEmiIBBoigcZQJPdb74CrGYjkOY5Xs2cigUaSLyKBQk6vTL2IBAoigYZIoCESaIgEGkORfNp6B1yNSKAhEmgkecjprRCRwBKRQEMk0BAJNEQCjaFIsvUOuJqhSA5b74CrEQk0kjy+MxCRsG9xUR7WiQQaIoGGSKAxFMnj1jvgagYiceKUfRMJNHIiEqjERXlYJxJoiAQaIoGGSKAxEInrjeybSKAhElgRx7JhnUigIRJoiAQaIoHGUCSft94BVzMUiROn7JdIoJHkPo5lQy0uysO6gUhefLPFrr0jEnFwG/4gEnFwW34jkldxcJN+IZLX+NUht2wlEnHA3d3iAz7igEv5eeJUHLDkHIk4AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA/q7vQU54sonL+l8AAAAASUVORK5CYII=');
			width:20px;
			height:25px;
			background-size:25px;
			display:inline-block;
			position:absolute;
			top:12px;
		}
	</style>
</head>
<body>
<div class="page_topbar ">
	<a href="javascript:;" class="back" onclick="history.back()"><i class="fa fa-angle-left"></i></a>
	<div style="text-align:center; padding-top:10px">修改密码</div>
</div>

<div id="containers">
	<div class="address_main">
		<div class="line"><input placeholder="请输入原密码" id="old_password"/></div>
	</div>
</div>
<div class="address_sub1" onclick="check();">下一步</div>
<br>
<script type="text/javascript">
    function check() {
        var old_password = $("#old_password").val();
        if (old_password == null || old_password.trim() == "") {
            layer.msg("请输入原密码");
            return;
        }
        $.ajax({
            url: '${path}/mall/personal_setting_password_check.do',
            type: 'post',
            data: {oldPassword: old_password},
            success: function (res) {
                res = JSON.parse(res);
                if (res.code == 200) {
                    window.location.href = "${path}/mall/personal_setting_password_step2.do?key=" + res.data;
                } else {
                    layer.msg("校验" + res.msg, {time:1500});
                }
            }
        });
    }
</script>
</body>
</html>