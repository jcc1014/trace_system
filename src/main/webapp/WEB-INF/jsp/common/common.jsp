<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
String address = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
%>
<c:set var="path" value="<%=basePath %>"/>
<c:set var="address" value="<%=address %>"/>
<c:set var="ftpctx" value="<%=basePath %>"/>
<c:set var="sysname" value="生鲜追溯后台管理系统"/>
<c:set var="mall" value="特产商城"/>