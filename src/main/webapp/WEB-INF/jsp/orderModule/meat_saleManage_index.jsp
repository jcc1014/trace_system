<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
   <title>协同采购平台</title>
   <link rel="stylesheet" href="${cg}/fonts/iconfont.css"/>
   <link rel="stylesheet" href="${cg}/css/font.css"/>
   <link rel="stylesheet" href="${cg}/css/mui.css"/>
   <link rel="stylesheet" href="${cg}/css/weui.min.css"/>
   <link rel="stylesheet" href="${cg}/css/jquery-weui.min.css"/>
   <link rel="stylesheet" href="${cg}/css/animate.css"/>
   <link rel="stylesheet" href="${cg}/css/pages/app.css"/>
   <style type="text/css">
   		.app-wrap{min-height:82px !important;}
   		h4{border-top: 1px solid #d9d9d9;}
   </style>
   <script>
        (function (doc, win) {
          var docEl = doc.documentElement,
            resizeEvt = 'orientationchange' in window ? 'orientationchange' : 'resize',
            recalc = function () {
              var clientWidth = docEl.clientWidth;
              if (!clientWidth) return;
              docEl.style.fontSize = 20 * (clientWidth / 320) + 'px';
            };

          if (!doc.addEventListener) return;
          win.addEventListener(resizeEvt, recalc, false);
          doc.addEventListener('DOMContentLoaded', recalc, false);
        })(document, window);
    </script>
</head>
<body>
    <header>
        <div class="titlebar reverse" style="background-color: #0498a1;">
           
           <h1>协同采购平台</h1>
       </div>
   </header>
   <article style="padding-bottom: 54px;padding-top:44px;">
       <div class="list-wrap">
           <h4>肉食管理</h4>
           <ul class="app-list">
               <li>
                   <div class="app-wrap">
                       <a href="${path}/meat/list.do">
                           <img src="${path}/images/orderModule/meat.png" class="iconfont"/>
                           <span>肉类采购</span>
                       </a>
                   </div>
               </li>
               <li>
                   <div class="app-wrap">
                       <a href="${path}/salePrice/todaySalePrice.do">
                           <img src="${path}/images/orderModule/dingjia.png" class="iconfont"/>
                           <span>肉类售价</span>
                       </a>
                   </div>
               </li>
               <li>
                   <div class="app-wrap">
                       <a href="${path}/meat/psList.do">
                           <img src="${path}/images/orderModule/peisong.png" class="iconfont"/>
                           <span>肉食配送</span>
                       </a>
                   </div>
                   
               </li>
           </ul>
       </div>
       <div class="list-wrap">
           <h4>系统管理</h4>
           <ul class="app-list">
               <li>
                   <div class="app-wrap">
                       <a href="${path}/produce/setup.do">
                           <img src="${path}/images/orderModule/setup.png" class="iconfont"/>
                           <span>系统设置</span>
                       </a>
                   </div>
               </li>
               <%-- <li>
                   <div class="app-wrap">
                       <a href="${path}/baseInfo/logout.do">
                           <img src="${path}/images/orderModule/mine.png" class="iconfont"/>
                           <span>个人中心</span>
                       </a>
                   </div>
               </li> --%>
               <li>
                   <div class="app-wrap">
                       <a href="${path}/baseInfo/logout.do">
                           <img src="${path}/images/orderModule/exit.png" class="iconfont"/>
                           <span>退出</span>
                       </a>
                   </div>
               </li>
           </ul>
       </div>
   </article>
</body>
</html>
