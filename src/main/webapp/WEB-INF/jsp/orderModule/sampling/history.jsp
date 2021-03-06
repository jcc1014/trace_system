<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../common/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>取样历史</title>
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
	<script src="${path}/mobiscroll/js/mobiscroll.core-2.5.2.js"
		type="text/javascript"></script>
	<script src="${path}/mobiscroll/js/mobiscroll.core-2.5.2-zh.js"
		type="text/javascript"></script>
	
	<link href="${path}/mobiscroll/css/mobiscroll.core-2.5.2.css" rel="stylesheet"
		type="text/css" />
	<link href="${path}/mobiscroll/css/mobiscroll.animation-2.5.2.css"
		rel="stylesheet" type="text/css" />
	<script src="${path}/mobiscroll/js/mobiscroll.datetime-2.5.1.js"
		type="text/javascript"></script>
	<script src="${path}/mobiscroll/js/mobiscroll.datetime-2.5.1-zh.js"
		type="text/javascript"></script>
	<!-- S 可根据自己喜好引入样式风格文件 -->
	<script src="${path}/mobiscroll/js/mobiscroll.android-ics-2.5.2.js"
		type="text/javascript"></script>
	<link href="${path}/mobiscroll/css/mobiscroll.android-ics-2.5.2.css"
		rel="stylesheet" type="text/css" />
<style type="text/css">
		body{background-color: #eee;}
		thead tr th{text-align: center;}
		tbody tr td{text-align: center;}
		table {border-bottom: 1px solid #eee; }
	</style>
</head>
<body>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title">历史取样单<!-- （距离供应单锁定还有：<span>30</span>分钟） -->
			</h3>
		</div>
		<div class="panel-body">
			<form action="${path}/sampling/history.do">
				<label for="appDate">选择日期</label>
				<input type="text" name="datetime" id="appDate" />
				<button type="submit" class="btn btn-primary">搜索</button>
			</form>
		</div>
		<table class="table table-striped table-bordered">
			<thead>
				<tr>
					<th>日期</th><th>编号</th><th>种类</th><th>品级</th><th>数量</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${fn:length(list)==0 }">
					<tr><td colspan="5">暂无数据</td></tr>
				</c:if>
				<c:forEach var="item" items="${list }">
					<tr>
						<td>${fn:substring(item.test.test_time,0,10) }</td>
						<td>${item.test.test_bh }</td>
						<td>${item.test.test_kind}</td>
						<td>${item.test.test_grade }</td>
						<td>${item.test.test_num }</td>
					</tr>
				</c:forEach>
			</tbody>
  		</table>
			<!-- <nav aria-label="Page navigation">
			  <ul class="pagination">
			    <li >
			      <a href="#" aria-label="Previous" id="prev">
			        <span aria-hidden="true">&laquo;</span>
			      </a>
			    </li>
			    <li ><a href="#" id="curr"></a></li>
			    <li>
			      <a href="#" aria-label="Next" id="next">
			        <span aria-hidden="true">&raquo;</span>
			      </a>
			    </li>
			  </ul>
			</nav> -->
		<div class="panel-footer" style="margin-top: 20px;">
			<button type="button" class="btn btn-default" onclick="window.location.href = '${path}/baseInfo/index.do';">返回主页</button>
		</div>
	</div>

<script type="text/javascript">
$(function() {
	var currYear = (new Date()).getFullYear();
	var opt = {};
	opt.date = {
		preset: 'date'
	};
	opt.datetime = {
		preset: 'datetime'
	};
	opt.time = {
		preset: 'time'
	};
	opt.default = {
		theme: 'android-ics light', //皮肤样式
		display: 'modal', //显示方式 
		mode: 'scroller', //日期选择模式
		lang: 'zh',
		startYear: currYear, //开始年份
		endYear: currYear //结束年份
	};   
	$("#appDate").val('').scroller('destroy').scroller($.extend(opt['date'], opt['default']));
});   


</script>
</body>
</html>
