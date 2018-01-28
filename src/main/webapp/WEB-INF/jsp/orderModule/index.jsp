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
   <link rel="stylesheet" href="${cg}/css/pages/login.css"/>
   <style type="text/css">
   		.app-wrap{min-height:80px;}
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
            <div class="titlebar reverse">
                
                <h1>协同采购平台</h1>
            </div>
        </header>
        <article style="padding-bottom: 54px;padding-top:44px;">
            <div class="list-wrap">
                <h4>进货采购</h4>
                <ul class="app-list">
                    <li>
                        <div class="app-wrap">
                            <a href="xunjia.html">
                                <i class="iconfont">&#xe625;</i>
                                <span>询价比</span>
                            </a>
                        </div>
                        
                    </li>
                    <li>
                        <div class="app-wrap">
                            <a href="javascript:;">
                                <i class="iconfont">&#xe624;</i>
                                <span>招标管理</span>
                            </a>
                        </div>
                        
                    </li>
                    <li>
                        <div class="app-wrap">
                            <a href="javascript:;">
                                <i class="iconfont">&#xe645;</i>
                                <span>评标管理</span>
                            </a>
                        </div>
                        
                    </li>
                    <li>
                        <div class="app-wrap">
                            <a href="javascript:;">
                                <i class="iconfont">&#xe626;</i>
                                <span>合同管理</span>
                            </a>
                        </div>
                        
                    </li>
                    
                </ul>
            </div>

            <div class="list-wrap">
                <h4>采购寻源</h4>
                <ul class="app-list">
                    <li>
                        <div class="app-wrap">
                            <a href="javascript:;">
                                <i class="iconfont">&#xe64b;</i>
                                <span>订单管理</span>
                            </a>
                        </div>
                        
                    </li>
                    <li>
                        <div class="app-wrap">
                            <a href="order.html">
                                <i class="iconfont">&#xe644;</i>
                                <span>发货记录</span>
                            </a>
                        </div>
                        
                    </li>
                    <li>
                        <div class="app-wrap">
                            <a href="javascript:;">
                                <i class="iconfont">&#xe649;</i>
                                <span>收货看板</span>
                            </a>
                        </div>
                        
                    </li>
                    <li>
                        <div class="app-wrap">
                            <a href="javascript:;">
                                <i class="iconfont">&#xe647;</i>
                                <span>收货记录</span>
                            </a>
                        </div>
                        
                    </li>

                    <li>
                        <div class="app-wrap">
                            <a href="javascript:;">
                                <i class="iconfont">&#xe64d;</i>
                                <span>退货管理</span>
                            </a>
                        </div>
                        
                    </li>
                    <li>
                        <div class="app-wrap">
                            <a href="javascript:;">
                                <i class="iconfont">&#xe64a;</i>
                                <span>交货排程</span>
                            </a>
                        </div>
                        
                    </li>
                    <li>
                        <div class="app-wrap">
                            <a href="javascript:;">
                                <i class="iconfont">&#xe64c;</i>
                                <span>质检结果</span>
                            </a>
                        </div>
                        
                    </li>
                    
                </ul>
            </div>

            <div class="list-wrap">
                <h4>采购寻源</h4>
                <ul class="app-list">
                    <li>
                        <div class="app-wrap">
                            <a href="javascript:;">
                                <i class="iconfont">&#xe620;</i>
                                <span>全体供应商</span>
                            </a>
                        </div>
                        
                    </li>
                    <li>
                        <div class="app-wrap">
                            <a href="javascript:;">
                                <i class="iconfont">&#xe648;</i>
                                <span>工厂考察</span>
                            </a>
                        </div>
                        
                    </li>
                    <li>
                        <div class="app-wrap">
                            <a href="javascript:;">
                                <i class="iconfont">&#xe646;</i>
                                <span>供应商绩效</span>
                            </a>
                        </div>
                        
                    </li>
                </ul>
            </div>
        </article>
        <footer>
            <ul class="menubar animated fadeInUp delay3">
                <li class="tab" onclick="window.location='notice.html'">
                    <i class="iconfont">&#xe63c;</i>
                    <label class="tab-label">公告</label>
                    <span class="point"></span>
                 
                </li>
                <li class="tab" onclick="window.location='tasks.html'">
                    <i class="iconfont">&#xe63d;</i>
                    <label class="tab-label">任务</label>
                    <span class="point"></span>
                </li>
                <li class="tab active" onclick="window.location='index.html'">
                    <i class="iconfont">&#xe63f;</i>
                    <label class="tab-label">应用</label>
                    <span class="point"></span>
                </li>
                <li class="tab" onclick="window.location='self.html'">
                    <i class="iconfont">&#xe63e;</i>
                    <label class="tab-label">我</label>
                </li>
            </ul>
        </footer>
    </body>
</html>