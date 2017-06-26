<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>${mall}</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link href="${path}/css/ui.css" rel="stylesheet" />
    <script type="text/javascript" src="${path}/js/jquery.min.js"></script>
	<script type="text/javascript" src="${path}/layer/layer.js"></script>
    <style>
        .address_sub1 {height:44px; margin:14px 10px;background-image: -webkit-gradient(linear, left top, left bottom, color-stop(0, #f44336), color-stop(1, #ed394a)); border-radius:4px; text-align:center; font-size:16px; line-height:44px; color:#fff;}
    </style>
</head>
<body>

<div class="header">
	<div class="header-background"></div>
	<div class="toolbar statusbar-padding">
		<button class="bar-button back-button" onclick="window.location.href='${path}/mall/user.do';" dwz-event-on-click="click"><i class="icon icon-back"></i></button>
		<!--<a class="bar-button" data-href="home.html?dwz_callback=home_render" target="navTab" rel="home"><i class="icon icon-back"></i></a>-->
		<div class="header-title">
			<div class="title">管理收货地址</div>
		</div>
	</div>
</div>

<div style="height:44px"></div>

<div>
	<ul>
        <c:forEach items="${list}" var="ar">
		<li>
            <div class="aui-add-cell"><span class="aui-add-fix">${ar.name}</span><span>${ar.phone}</span></div>
            <div class="b-line aui-add-title">${ar.sheng} ${ar.shi} ${ar.qu} ${ar.address_detail}</div>
			<div class="aui-add-cell">
				<c:if test="${ar.status eq 1}">
					<div class="aui-add-fix default" data-id="${ar.address_id}" style="color:#ff5200">默认地址</div>
	            </c:if>
				<c:if test="${ar.status ne 1}">
					<div class="aui-add-fix" data-id="${ar.address_id}" style="color: #9e9e9e" onclick="chooseDefault(this)">默认地址</div>
				</c:if>
                <div>
                    <span onclick="edit('${ar.address_id}')">编辑</span>
                    <span onclick="deleteAddress('${ar.address_id}')">删除</span>
                </div>
            </div>
		</li>
		<div class="devider"></div>
        </c:forEach>
	</ul>
    <div class="address_sub1"  onclick="add()" >添加</div>
</div>
<script>
    function add() {
        window.location.href = "${path}/mall/address_edit.do";
    }

    function edit(address_id) {
        window.location.href = "${path}/mall/address_edit.do?address_id=" + address_id;
    }

    function deleteAddress(address_id) {
        layer.confirm("确定删除？", function () {
            $.ajax({
                url: '${path}/mall/address_delete.do',
                type: 'get',
                data: {address_id: address_id},
                dataType: 'json',
                success: function (res) {
                    if (res.code == 200) {
                        layer.msg("删除" + res.msg, {time:1500}, function () {
                            window.location.reload();
                        });
                    } else {
                        layer.msg("删除" + res.msg, {time:1500});
                    }
                }
            });
        });
    }
    
    function chooseDefault(ths) {
        var new_id = $(ths).data("id") || $(ths).attr("data-id");
        var old_id = $(".default").data("id") || $(ths).attr("data-id");
        $.ajax({
	        url: '${path}/mall/address_default_update.do',
	        type: 'get',
	        data: {new_id: new_id, old_id: old_id},
            dataType: 'json',
            success: function (res) {
                if (res.code == 200) {
                    $(".default").css("color", "#9e9e9e").removeClass("default").attr("onclick", "chooseDefault(this)");
                    $(ths).css("color", "#ff5200").addClass("default").attr("onclick", "");
                } else {
                    layer.msg("设置失败", {time:1500});
                }
            }
        });
    }
</script>
</body>
</html>