<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../common/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>蔬菜分类查询</title>
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
		thead tr th{text-align: center;}
		tbody tr td{text-align: center;}
		table {border-bottom: 1px solid #eee; }
	</style>
</head>
<body>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title">蔬菜分类查询
			</h3>
			<form action="${path}/sczl/query.do" method="post" style="margin-top: 2rem;">
			
			<div class="form-group">
			    <label for="kind">种类</label>
			    <select class="form-control" id="kind" name="kind">
			    	<option value=""></option>
					<c:forEach var="item" items="${goodsList}">
						<option value="${item.goods_name }"
							<c:if test="${item.goods_name eq sczl.kind }">selected="selected"</c:if>>${item.goods_name }</option>
					</c:forEach>
				</select>
			  </div>
			<div class="form-group">
			    <label for="grade">品级</label>
			    <select class="form-control" id="grade" name="grade">
			    	<option value="">请选择</option>
			    	<option value="1"
			    	<c:if test="${'1' eq sczl.grade }">selected="selected"</c:if>
			    	>1</option>
			    	<option value="2"
			    	<c:if test="${'2' eq sczl.grade }">selected="selected"</c:if>
			    	>2</option>
			    	<option value="3"
			    	<c:if test="${'3' eq sczl.grade }">selected="selected"</c:if>
			    	>3</option>
			    </select>
			  </div>
			<div class="form-group">
			    <label for="grade">三品一标</label>
			    <select class="form-control" id="spyb" name="spyb">
			    	<option value=""></option>
					<c:forEach var="item" items="${dictList}">
						<option value="${item.dict_name }"
							<c:if test="${item.dict_name eq sczl.spyb }">selected="selected"</c:if>>${item.dict_name }</option>
					</c:forEach>
				</select>
			  </div>
			<div class="form-group">
			    <button class="btn btn-primary" type="submit">查询</button>
			  </div>
			</form>
		</div>
		<div class="panel-body" style="white-space:normal;word-wrap: break-word;">
			<c:if test="${null!= content && '' ne content }">
				${content }
			</c:if>
			<c:if test="${null == content || '' eq content }">
				请选择类型进行查询
			</c:if>
		</div>
		<div class="panel-footer" style="margin-top: 20px;">
			<button type="button" class="btn btn-default" onclick="window.location.href = '${path}/baseInfo/index.do';">返回主页</button>
		</div>
	</div>

<script type="text/javascript">

</script>
</body>
</html>
