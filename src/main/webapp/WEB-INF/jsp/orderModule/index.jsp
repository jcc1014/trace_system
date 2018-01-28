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
                <h4>基地管理</h4>
                <ul class="app-list">
                    <li>
                        <div class="app-wrap">
                            <a href="xunjia.html">
                                <img src="${path}/images/orderModule/gongying.png" class="iconfont"/>
                                <span>蔬菜供应</span>
                            </a>
                        </div>
                    </li>
                    <li>
                        <div class="app-wrap">
                            <a href="xunjia.html">
                                <img src="${path}/images/orderModule/jidi.png" class="iconfont"/>
                                <span>基地信息</span>
                            </a>
                        </div>
                    </li>
                </ul>
            </div>
            <div class="list-wrap">
                <h4>需求管理</h4>
                <ul class="app-list">
                    <li>
                        <div class="app-wrap">
                            <a href="xunjia.html">
                                <img src="${path}/images/orderModule/xuqiu.png" class="iconfont"/>
                                <span>蔬菜需求</span>
                            </a>
                        </div>
                    </li>
                    <li>
                       <div class="app-wrap">
                           <a href="xunjia.html">
                               <img src="${path}/images/orderModule/meat.png" class="iconfont"/>
                               <span>肉食需求</span>
                           </a>
                       </div>
                       
                    </li>
                    <li>
                        <div class="app-wrap">
                            <a href="xunjia.html">
                                <img src="${path}/images/orderModule/fruit.png" class="iconfont"/>
                                <span>水果需求</span>
                            </a>
                        </div>
                        
                    </li>
                    <li>
                        <div class="app-wrap">
                            <a href="xunjia.html">
                                <img src="${path}/images/orderModule/tiaoliao.png" class="iconfont"/>
                                <span>副食调料</span>
                            </a>
                        </div>
                    </li>
                    <li>
                        <div class="app-wrap">
                            <a href="xunjia.html">
                                <img src="${path}/images/orderModule/shouhuo.png" class="iconfont"/>
                                <span>到店收货</span>
                            </a>
                        </div>
                    </li>
                </ul>
            </div>
            <div class="list-wrap">
                <h4>采购管理</h4>
                <ul class="app-list">
                    <li>
                        <div class="app-wrap">
                            <a href="xunjia.html">
                                <img src="${path}/images/orderModule/quehuo.png" class="iconfont"/>
                                <span>缺货单</span>
                            </a>
                        </div>
                    </li>
                    <li>
                        <div class="app-wrap">
                            <a href="xunjia.html">
                                <img src="${path}/images/orderModule/fuyu.png" class="iconfont"/>
                                <span>富余单</span>
                            </a>
                        </div>
                    </li>
                </ul>
            </div>
            <div class="list-wrap">
                <h4>销售管理</h4>
                <ul class="app-list">
                    <li>
                        <div class="app-wrap">
                            <a href="xunjia.html">
                                <img src="${path}/images/orderModule/dingjia.png" class="iconfont"/>
                                <span>今日定价</span>
                            </a>
                        </div>
                    </li>
                </ul>
            </div>
            <div class="list-wrap">
                <h4>采购进货</h4>
                <ul class="app-list">
                    <li>
                        <div class="app-wrap">
                            <a href="xunjia.html">
                                <img src="${path}/images/orderModule/today.png" class="iconfont"/>
                                <span>蔬菜采购</span>
                            </a>
                        </div>
                    </li>
                    <li>
                        <div class="app-wrap">
                            <a href="xunjia.html">
                                <img src="${path}/images/orderModule/meat.png" class="iconfont"/>
                                <span>肉食采购</span>
                            </a>
                        </div>
                        
                    </li>
                    <li>
                        <div class="app-wrap">
                            <a href="xunjia.html">
                                <img src="${path}/images/orderModule/fruit.png" class="iconfont"/>
                                <span>水果采购</span>
                            </a>
                        </div>
                        
                    </li>
                    <li>
                        <div class="app-wrap">
                            <a href="xunjia.html">
                                <img src="${path}/images/orderModule/tiaoliao.png" class="iconfont"/>
                                <span>副食调料</span>
                            </a>
                        </div>
                    </li>
                    <li>
                        <div class="app-wrap">
                            <a href="xunjia.html">
                                <img src="${path}/images/orderModule/quehuo.png" class="iconfont"/>
                                <span>缺货采购</span>
                            </a>
                        </div>
                    </li>
                </ul>
            </div>

            <div class="list-wrap">
                <h4>取样检验</h4>
                <ul class="app-list">
                    <li>
                        <div class="app-wrap">
                            <a href="xunjia.html">
                                <img src="${path}/images/orderModule/quyang.png" class="iconfont"/>
                                <span>取样抽检</span>
                            </a>
                        </div>
                    </li>
                    <li>
                        <div class="app-wrap">
                            <a href="xunjia.html">
                                <img src="${path}/images/orderModule/jianyan.png" class="iconfont"/>
                                <span>全面检验</span>
                            </a>
                        </div>
                    </li>
                </ul>
            </div>
            <div class="list-wrap">
                <h4>分类配送</h4>
                <ul class="app-list">
                    <li>
                        <div class="app-wrap">
                            <a href="xunjia.html">
                                <img src="${path}/images/orderModule/peisong.png" class="iconfont"/>
                                <span>今日配送</span>
                            </a>
                        </div>
                    </li>
                    <li>
                        <div class="app-wrap">
                            <a href="xunjia.html">
                                <img src="${path}/images/orderModule/lishi.png" class="iconfont"/>
                                <span>配送列表</span>
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
        <!-- <footer>
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
        </footer> -->
    </body>
</html>