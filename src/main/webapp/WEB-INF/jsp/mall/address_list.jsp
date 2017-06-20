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
    <style>
        .address_sub1 {height:44px; margin:14px 10px;background-image: -webkit-gradient(linear, left top, left bottom, color-stop(0, #f44336), color-stop(1, #ed394a)); border-radius:4px; text-align:center; font-size:16px; line-height:44px; color:#fff;}
    </style>
</head>
<body>

<div class="header">
	<div class="header-background"></div>
	<div class="toolbar statusbar-padding">
		<button class="bar-button back-button" onclick="history.go(-1);" dwz-event-on-click="click"><i class="icon icon-back"></i></button>
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
                <div class="aui-add-fix" style="color:#ff5200">默认地址</div>
                <div>
                    <span data-id="${ar.address_id}" onlick="edit()">编辑</span>
                    <span data-id="${ar.address_id}" onlick="deleteAddress()">删除</span>
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

    function edit() {
        var address_id = $(this).data("id") || $(this).attr("data-id");
        window.location.href = "${path}/mall/address_edit.do?address_id=" + address_id;
    }

    function deleteAddress(){
        var address_id = $(this).data("id") || $(this).attr("data-id");
        $.ajax({
            url: '${path}/mall/address_delete.do',
            type: 'get',
            data: {address_id: address_id},
            dataType: 'json',
            success: function (res) {
                console.log(res);
            }
        });
    }
</script>
</body>
</html>