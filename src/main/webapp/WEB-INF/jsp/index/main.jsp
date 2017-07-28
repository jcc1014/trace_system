<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
    <title></title>
    <link rel="stylesheet" href="${path}/layui/css/layui.css">
    <link rel="stylesheet" href="${path}/res/global.css">
    <script type="text/javascript" src="${path}/layui/layui.js"></script>
</head>
<body>
<div class="layui-tab layui-tab-brief main-tab-container" style="margin-top: 20px;">
    <ul class="layui-tab-title main-tab-title">
      <div class="main-tab-item">首页</div>
    </ul>
    <div class="layui-tab-content">
        <blockquote class="layui-elem-quote">
            <p>欢迎进入生鲜追溯后台管理系统
            </p>
        </blockquote>
        <div><img alt="二维码列表" style="width: 150px;height: 150px;" src="${path}/images/qrcode-mini.png"></div>
    </div>
</div>
</body>
</html>