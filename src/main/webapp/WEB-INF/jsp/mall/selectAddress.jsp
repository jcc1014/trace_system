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
<link href="${path}/css/bass.css" rel="stylesheet" />
<link href="${path}/css/style.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="${path}/css/ui.css">
<!-- 引入js资源 -->
<script type="text/javascript" src="${path}/js/jquery.min.js"></script>
<script>jQuery.noConflict()</script>
<script type="text/javascript" src="${path}/layer/layer.js"></script>
<script type="text/javascript" src="${path}/js/zepto.min.js"></script>
<script type="text/javascript" src="${path}/js/zepto.kslider.js"></script>
<style type="text/css">
.border{border-top: 1px solid #ee394a;}
</style>
</head>
<body>
	<div>
		<ul>
			<c:forEach var="item" items="${addressList}">
				<li id="${item.address_id}" class="border">
					<div class="aui-add-cell">
						<span class="aui-add-fix">收货人：${item.name}</span>
						<span>手机：${item.phone}</span>
					</div>
					<div class="b-line aui-add-title">
					地址：${item.sheng}${item.shi}${item.qu}${item.address_detail}
					<c:if test="${item.status eq '1' }">
						（默认）
					</c:if>
					</div>
					<!-- <div class="devider"></div> -->
				</li>
			</c:forEach>
		</ul>
	</div>
<script type="text/javascript">
$(document).on("click",".border",function(){
	var _this = $(this);
	var address_id = _this.attr("id");
	window.parent.location.href = "${path}/mall/selectShop.do?address_id="+address_id;
})
</script>
</body>
</html>