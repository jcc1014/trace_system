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
    <link href="${path}/css/bass.css" rel="stylesheet" />
    <link href="${path}/css/style.css" rel="stylesheet" />
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
        .hide{display: none;}
        #edit:FOCUS{color: #fff;}
        body {margin:0px; background:#efefef; font-family:'微软雅黑'; -moz-appearance:none;}
        a {text-decoration:none;}
        input{-webkit-appearance: none;border:none; background:none;

        }
        .address_addnav {height:44px; width:94%; padding:0 3%; border-bottom:1px solid #f0f0f0; border-top:1px solid #f0f0f0; margin-top:14px; line-height:42px; color:#666; background:#fff;}
        .address_list {height:50px; padding:0 10px;  border-bottom:1px solid #f0f0f0; border-top:1px solid #f0f0f0; margin-top:14px; background:#fff;}
        .address_list .ico {height:50px; width:30px;   float:left; color:#999;margin-right:-30px; z-index:2}
        .address_list .ico i { font-size:24px;margin-top:15px;margin-left:10px;z-index:2;position: relative;}
        .address_list .info {height:50px; width:100%; float:left;position: relative;}
        .address_list .info .inner { margin-left:40px;margin-right:50px;}
        .address_list .info .inner .addr {height:20px; width:100%; color:#999; line-height:26px; font-size:14px; overflow:hidden;}
        .address_list .info .inner .user {height:30px; width:100%; color:#666; line-height:30px; font-size:16px; overflow:hidden;}
        .address_list .info .inner .user span {color:#444; font-size:16px;}
        .address_list .btn { width:45px; float:right;margin-left:-45px;z-index:2;position: relative;}
        .address_list .btn .edit,.address_list .btn .remove {height:50px; float:right; color:#999; font-size:18px;margin-top:5px;}
        .address_list .btn .edit { margin-right:10px;}

        .address_addnav {height:40px;  border-bottom:1px solid #f0f0f0; border-top:1px solid #f0f0f0; margin-top:14px; line-height:40px; color:#666; }
        .address_main {height:auto;width:98%; padding:0px 3%; border-bottom:1px solid #f0f0f0; border-top:1px solid #f0f0f0; margin:14px auto; background:#fff;}
        .address_main .line {height:44px; width:100%; border-bottom:1px solid #f0f0f0; line-height:44px;}

        .address_main .line input {float:left; height:44px; width:100%; padding:0px; margin:0px; border:0px; outline:none; font-size:16px; color:#666;padding-left:5px;}
        .address_main .line select  { border:none;height:25px;width:100%;color:#666;font-size:16px;}
        .address_sub1 {height:44px; margin:14px 10px;background-image: -webkit-gradient(linear, left top, left bottom, color-stop(0, #f44336), color-stop(1, #ed394a)); border-radius:4px; text-align:center; font-size:16px; line-height:44px; color:#fff;}
        .address_sub2 {height:44px; margin:14px 10px; background:#ddd; border-radius:4px; text-align:center; font-size:16px; line-height:44px; color:#666; border:1px solid #d4d4d4;}

        #BgDiv1{background-color:#000; position:absolute; z-index:9999;  display:none;left:0px; top:0px; width:100%; height:100%;opacity: 0.6; filter: alpha(opacity=60);}
        .DialogDiv{position:absolute;z-index:99999;}/*配送公告*/
        .U-user-login-btn{ display:block; border:none; background:url(images/bg_mb_btn1_1.png) repeat-x; font-size:1em; color:#efefef; line-height:49px; cursor:pointer; height:53px; font-weight:bold;
            border-radius:3px;
            -webkit-border-radius: 3px;
            -moz-border-radius: 3px;
            width:100%; box-shadow: 0 1px 4px #cbcacf, 0 0 40px #cbcacf ;}
        .U-user-login-btn:hover, .U-user-login-btn:active{ display:block; border:none; background:url(images/bg_mb_btn1_1_h.png) repeat-x; font-size:1em; color:#efefef; line-height:49px; cursor:pointer; height:53px; font-weight:bold;
            border-radius:3px;
            -webkit-border-radius: 3px;
            -moz-border-radius: 3px;
            width:100%; box-shadow: 0 1px 4px #cbcacf, 0 0 40px #cbcacf ;}
        .U-user-login-btn2{ display:block; border:none;background:url(images/bg_mb_btn1_1_h.png) repeat-x;   font-size:1em; color:#efefef; line-height:49px; cursor:pointer; font-weight:bold;
            border-radius:3px;
            -webkit-border-radius: 3px;
            -moz-border-radius: 3px;
            width:100%; box-shadow: 0 1px 4px #cbcacf, 0 0 40px #cbcacf ;height:53px;}
        .U-guodu-box { padding:5px 15px;  background:#3c3c3f; filter:alpha(opacity=90); -moz-opacity:0.9; -khtml-opacity: 0.9; opacity: 0.9;  min-heigh:200px; border-radius:10px;}
        .U-guodu-box div{ color:#fff; line-height:20px; font-size:12px; margin:0px auto; height:100%; padding-top:10%; padding-bottom:10%;}

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
        <div style="text-align:center; padding-top:10px">填写信息</div>
    </div>
	<div class="t-line"></div>

    <div id="containers">
	    <form id="data_form">
		    <div class="address_main">
			    <input type="hidden" name="address_id" value="${ar.address_id}">
			    <div class="line"><input id="name" name="name" placeholder="收件人" value="${ar.name}"></div>
			    <div class="line"><input id="phone" name="phone" placeholder="联系电话" value="${ar.phone}"></div>
			    <div class="line">
				    <!-- sel-provance -->
				    <select id="s_province" name="sheng"></select><br>
			    </div>
			    <div class="line">
				    <select id="s_city" name="shi"></select><br><!-- sel -->
			    </div>
			    <div class="line">
				    <!-- sel-area -->
				    <select id="s_county" name="qu"></select><br>
			    </div>
			    <script type="text/javascript" src="${path}/js/add/js/area.js"></script>
			    <script type="text/javascript">_init_area();</script>
			
			    <div class="line"><input id="address_detail" name="address_detail" placeholder="详细地址" value="${ar.address_detail}"></div>
		    </div>
	    </form>
	    <div class="address_sub1" onclick="save();">确认</div>
	    <%--<div class="address_sub2"  onclick="showLoader()">取消</div>--%>
    </div>
    <br>
    <script type="text/javascript">
	    $(function () {
		   var pre_sheng = '${ar.sheng}';
		   var pre_shi = '${ar.shi}';
		   var pre_qu = '${ar.qu}';
		   
		   hit($('#s_province'), pre_sheng);
		   hit($('#s_city'), pre_shi);
		   hit($('#s_county'), pre_qu);
        });
	    
	    function hit(node, val) {
            node.find('option').each(function () {
			   if ($(this).val() == val) {
			       $(this).attr("selected", "selected");
                   node.trigger("change");
			       return false;
			   }
            });
        }
	    
        function save() {
            var name = $('#name').val();
            if (!name) {
                layer.msg("请填写姓名");
                return;
            }
            var phone = $('#phone').val();
            if (!phone) {
                layer.msg("请填写手机号");
                return;
            } else {
                if(!isTelephone(phone)){
                    layer.msg("手机号不合法");
                    return;
                }
            }
            var sheng = $('#s_province').val();
            var shi = $('#s_city').val();
            var qu = $('#s_county').val();
            if (sheng == "省份" || shi == "地级市" || qu == "市、县级市") {
                layer.msg("请选择地区");
                return;
            }
            var detail = $('#address_detail').val();
            if (!detail) {
                layer.msg("请填写详细地址");
                return;
            }
            
            $.ajax({
                url: '${path}/mall/address_save.do',
                type: 'post',
                data: $("#data_form").serialize(),
                success: function (res) {
                    res = JSON.parse(res);
                    if (res.code == 200) {
                        layer.msg("保存" + res.msg, {time:1500}, function () {
	                        window.location.href = "${path}/mall/address_list.do";
                        });
                    } else {
                        layer.msg("保存" + res.msg, {time:1500});
                    }
                }
            });
        }
    </script>
</body>
</html>