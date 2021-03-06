<%@ page language="java" contentType="text/html; chitemset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta chitemset="utf-8">
    <title>${mall}</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link href="${path}/css/ui.css" rel="stylesheet" />
	<link href="${path}/css/style.css" rel="stylesheet" />
    <script type="text/javascript" src="${path}/js/jquery.min.js"></script>
	<script type="text/javascript" src="${path}/layer/layer.js"></script>
    <style>
        .address_sub1 {height:44px; mitemgin:14px 10px;background-image: -webkit-gradient(lineitem, left top, left bottom, color-stop(0, #f44336), color-stop(1, #ed394a)); border-radius:4px; text-align:center; font-size:16px; line-height:44px; color:#fff;}
    	.default{text-align: right;}
    	li{margin-top: 0.5rem;border-top: 1px solid #eee;}
    </style>
</head>
<body>

<div class="header">
	<div class="header-background"></div>
	<div class="toolbar statusbar-padding">
		<div class="header-title">
			<div class="title">订单管理</div>
		</div>
	</div>
</div>

<div style="height:44px"></div>

<div>
	<ul>
        <c:forEach items="${list}" var="item">
		<li class="order" data-id="${item.order.id}">
            <div class="aui-add-cell">
            	<span class="aui-add-fix">订单号：${item.order.order_number}</span>
            </div>
            <div class="aui-add-cell">
            	<span class="aui-add-fix">下单时间：${item.order.create_time}</span>
            </div>
            <%--<div class="aui-add-cell">
            	<span class="aui-add-fix">下单时间：${item.order.ordertime}</span>
            </div>
            <div class="aui-add-cell">
            	<span class="aui-add-fix">商品名称：${item.goods.goods_name}</span>
            	<span>数量：${item.order.number}</span>
            </div>
            <div class="aui-add-cell">
            	<span class="aui-add-fix">单价：${item.order.price}</span>
            	<span>总价:${item.order.amount }</span>
            </div>--%>
			<div class="aui-add-cell">
				<span class="aui-add-fix">订单内容：${item.content}</span>
			</div>
			<div class="aui-add-cell">
				<span class="aui-add-fix">总价：${item.order.price}</span>
			</div>
            <div class="aui-add-cell">
            	<span class="aui-add-fix">收货人：${item.address.name}</span>
            	<span>手机:${item.address.phone }</span>
            </div>
            <div class="b-line aui-add-title">派送地址：${item.address.sheng} ${item.address.shi} ${item.address.qu} ${item.address.address_detail}</div>
			<div class="aui-add-cell">
					<div class="aui-add-fix default watch" data-id="${item.order.id}" style="color:#ff5200">查看</div>
				<c:if test="${item.order.current_status eq '2'&& date eq 'today'}">
					<div class="aui-add-fix default" data-id="${item.address_id}" style="color:#ff5200" onclick="jiesuan(this)">结算</div>
	            </c:if>
				<c:if test="${item.order.current_status eq '3'&& date eq 'today'}">
					<div class="aui-add-fix default" data-id="${item.address_id}" style="color:#ff5200" onclick="send()">派送</div>
	            </c:if>
				<c:if test="${item.order.current_status eq '5' || date eq 'history'}">
					<div class="aui-add-fix default" data-id="${item.address_id}" style="color:#ff5200" onclick="watch()">查看</div>
	            </c:if>
				<%-- <c:if test="${item.order..currentStatus eq '3'}">
					<div class="aui-add-fix" data-id="${item.address_id}" style="color: #9e9e9e" onclick="">已派送</div>
				</c:if> --%>
            </div>
		</li>
		<div class="devider"></div>
        </c:forEach>
	</ul>
</div>
<footer>
	<a href="${path}/order/orderManageList.do?date=today"> <i class="icon icon-f1"></i>
		今日订单
	</a>
	<a href="${path}/order/orderManageList.do?date=history"> <i class="icon icon-f2"></i>
		历史订单
	</a>
	<a href="javascript:void(0);"> <i class="icon icon-f3"></i>
		统计
	</a>
	<a href="javascript:void(0);"> <i class="icon icon-f4"></i>
		设置
	</a>
</footer>
<script>
	$(function () {
	    var date = '${date}';
	    if (date === 'today') {
	        $("footer").find("a").eq(0).addClass("pick");
        } else {
            $("footer").find("a").eq(1).addClass("pick");
        }
		$(".watch").click(function(){
		   var id = $(this).data("id") || $(this).attr("data-id");
		   window.location.href = "${path}/order/order_detail.do?id=" + id;
		});
    });
    function send(){
    	layer.confirm('确定派送吗？',{title:'派送',btn:['确定','取消']},function(){
    		layer.msg('派送。。。',{time:1000});
    	},function(){
    		layer.closeAll();
    	})
    }
    function jiesuan(obj){
    	var _this = $(obj);
    	var id = _this.data("id");
    	window.location.href = "${path}/order/account.do";
    }
</script>
</body>
</html>