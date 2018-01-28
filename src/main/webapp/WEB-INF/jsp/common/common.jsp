<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
String address = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
String ht = basePath+"/jtzy/htpage";
String mall = basePath+"/jtzy/mallpage";
String cg = basePath+"/jtzy/cgpage";
%>
<c:set var="path" value="<%=basePath %>"/>
<c:set var="address" value="<%=address %>"/>
<c:set var="ftpctx" value="<%=basePath %>"/>
<c:set var="ht" value="<%=ht%>"/>
<c:set var="mall" value="<%=mall%>"/>
<c:set var="cg" value="<%=cg%>"/>
<c:set var="sysname" value="生鲜追溯后台管理系统"/>
<c:set var="ordername" value="订单后台管理系统"/>
<c:set var="mall" value="特产商城"/>
<script src="${path}/js/jquery-2.1.1.min.js" type="text/javascript"></script>
<script src="${path}/layer/layer.js" type="text/javascript"></script>