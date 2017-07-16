<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
    <title>生鲜追溯后台管理系统</title>
    <link rel="stylesheet" href="${path}/layui/css/layui.css">
    <link rel="stylesheet" href="${path}/res/global.css">
    <script type="text/javascript" src="${path}/layui/layui.js"></script>
    <style type="text/css">
    	.logo{
    		font-size: 18px;
    		color:#fff;
    		top:20px !important;
    		left: 0px !important;
    	}
    </style>
</head>
<body>
<div class="layui-layout layui-layout-admin">

    <div class="layui-header header">
      <div class="layui-main">
        <div class="logo">生鲜追溯后台管理系统</div>
        <ul class="layui-nav top-nav-container">
          <li class="layui-nav-item layui-this">
            <a href="${path}/main.do" target="main" data-id="index">首页</a>
          </li>
          <li class="layui-nav-item">
            <a href="javascript:void(0)">追溯管理</a>
          </li>
          <li class="layui-nav-item">
	        <a href="javascript:void(0)">用户管理</a>
	      </li>
	      <li class="layui-nav-item">
	        <a href="javascript:void(0)">商城管理</a>
	      </li>
	          
        </ul>
        <div class="top_admin_user">
        	<span>当前用户：${sessionScope.user.username }（管理员）&nbsp;&nbsp;&nbsp;|</span>
          <a class="logout_btn" href="javascript:void(0)">退出</a>
        </div>
      </div>
    </div>
    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <ul class="layui-nav layui-nav-tree left_menu_ul">
              <li class="layui-nav-item layui-nav-title">
                <a href="${path}/main.do" target="main" id="index">首页</a>
              </li>
              <%-- <li class="layui-nav-item first-item layui-this">
                <a href="${path}/main.do" target="main">
                  <i class="layui-icon">&#xe638;</i>
                  <cite>常用模块</cite>
                </a>
              </li> --%>
              <!-- <li class="layui-nav-item ">
                <a href="./form.html" target="main">
                  <i class="layui-icon">&#xe642;</i>
                  <cite>表单</cite>
                </a>
              </li> -->
            </ul>
            <ul class="layui-nav layui-nav-tree left_menu_ul content_put_manage hide">
              <li class="layui-nav-item layui-nav-title">
                <a>追溯管理</a>
              </li>
              <%-- <li class="layui-nav-item ">
                <a href="${path}/trace/list.do" target="main">
                  <i class="layui-icon">&#xe609;</i>
                  <cite>追溯列表</cite>
                </a>
              </li>
              <li class="layui-nav-item content_manage">
                <a href="${path}/trace/add.do" target="main">
                  <i class="layui-icon">&#xe60a;</i>
                  <cite>新增追溯</cite>
                </a>
              </li> --%>
              <%-- <li class="layui-nav-item">
                <a href="${path}/produce/add.do" target="main">
                  <i class="layui-icon">&#xe60a;</i>
                  <cite>新增基地生产信息</cite>
                </a>
              </li> --%>
              <li class="layui-nav-item first-item">
                <a href="${path}/baseInfo/list.do" target="main">
                  <i class="layui-icon">&#xe60a;</i>
                  <cite>基地/需求单位</cite>
                </a>
              </li>
              <li class="layui-nav-item">
                <a href="${path}/user/jd_user_list.do" target="main">
                  <i class="layui-icon">&#xe60a;</i>
                  <cite>基地管理员</cite>
                </a>
              </li>
              <li class="layui-nav-item">
                <a href="${path}/user/require_user_list.do" target="main">
                  <i class="layui-icon">&#xe60a;</i>
                  <cite>需求管理员</cite>
                </a>
              </li>
              <li class="layui-nav-item">
                <a href="${path}/transport/transportList.do" target="main">
                  <i class="layui-icon">&#xe60a;</i>
                  <cite>今日追溯</cite>
                </a>
              </li>
              <li class="layui-nav-item">
                <a href="${path}/trace/list.do" target="main">
                  <i class="layui-icon">&#xe60a;</i>
                  <cite>追溯列表</cite>
                </a>
              </li>
            </ul>
            <ul class="layui-nav layui-nav-tree left_menu_ul hide">
              <li class="layui-nav-item layui-nav-title">
                <a>用户管理</a>
              </li>
              <li class="layui-nav-item first-item">
                <a href="${path}/user/list.do" target="main">
                  <i class="layui-icon">&#xe613;</i>
                  <cite>用户列表</cite>
                </a>
              </li>
            </ul>
            <ul class="layui-nav layui-nav-tree left_menu_ul hide">
              <li class="layui-nav-item layui-nav-title">
                <a>商城管理</a>
              </li>
              <li class="layui-nav-item first-item">
                <a href="${path}/goods/list.do" target="main">
                  <i class="layui-icon">&#xe60a;</i>
                  <cite>商品列表</cite>
                </a>
              </li>
              <li class="layui-nav-item">
                <a href="${path}/order/list.do" target="main">
                  <i class="layui-icon">&#xe60a;</i>
                  <cite>订单列表</cite>
                </a>
              </li>
              <li class="layui-nav-item ">
                <a href="${path}/shop/listshop.do" target="main">
                  <i class="layui-icon">&#xe60a;</i>
                  <cite>商店列表</cite>
                </a>
              </li>
              <li class="layui-nav-item ">
                <a href="${path}/dict/listParent.do" target="main">
                  <i class="layui-icon">&#xe60a;</i>
                  <cite>种类列表</cite>
                </a>
              </li>
              <li class="layui-nav-item ">
                <a href="${path}/banner/list.do" target="main">
                  <i class="layui-icon">&#xe60a;</i>
                  <cite>首页轮播图</cite>
                </a>
              </li>
              <li class="layui-nav-item ">
                <a href="${path}/user/member_list.do" target="main">
                  <i class="layui-icon">&#xe60a;</i>
                  <cite>商城会员</cite>
                </a>
              </li>
            </ul>
				<!--  <ul class="layui-nav layui-nav-tree left_menu_ul setting_ul hide">
              <li class="layui-nav-item layui-nav-title">
                <a>相关设置</a>
              </li>
              <li class="layui-nav-item first-item ">
                <a href="" target="main">
                  <i class="layui-icon">&#xe620;</i>
                  <cite>个人信息</cite>
                </a>
              </li>
            </ul> -->
        </div>
    </div>

    <div class="layui-body iframe-container">
        <div class="iframe-mask" id="iframe-mask"></div>
        <iframe class="admin-iframe" id="admin-iframe" name="main" src="${path}/main.do"></iframe>
    </div>
    
    <div class="layui-footer footer" style="height: 14px;line-height: 14px;">
      <div class="layui-main">
        <p>2017 © <a href="#">生鲜追溯后台管理系统</a></p>
      </div>
    </div>
</div>

<script type="text/javascript">
layui.use(['layer', 'element','jquery','tree'], function(){
  var layer = layui.layer
  ,element = layui.element() //导航的hover效果、二级菜单等功能，需要依赖element模块
  ,jq = layui.jquery

  //头部菜单切换
  jq('.top-nav-container .layui-nav-item').click(function(){
    var menu_index = jq(this).index('.top-nav-container .layui-nav-item');
    jq('.top-nav-container .layui-nav-item').removeClass('layui-this');
    jq(this).addClass('layui-this');
    jq('.left_menu_ul').addClass('hide');
    jq('.left_menu_ul:eq('+menu_index+')').removeClass('hide');
    jq('.left_menu_ul .layui-nav-item').removeClass('layui-this');
    jq('.left_menu_ul:eq('+menu_index+')').find('.first-item').addClass('layui-this');
    var url = jq('.left_menu_ul:eq('+menu_index+')').find('.first-item a').attr('href');
    var id = jq('.left_menu_ul:eq('+menu_index+')').find('.first-item a').data('id');
	jq('.admin-iframe').attr('src',url);
	if(typeof(id)!="undefined"&&"index"!=id){
		jq("#iframe-mask").show();
	    //出现遮罩层
	    //遮罩层消失
	    jq("#admin-iframe").load(function(){   
	      jq("#iframe-mask").fadeOut(100);
	    });
	}
  });
  //左边菜单点击
  jq('.left_menu_ul .layui-nav-item').click(function(){
	if(jq(this).hasClass("layui-nav-title")){return;}
    jq('.left_menu_ul .layui-nav-item').removeClass('layui-this');
    jq(this).addClass('layui-this');
    var id = jq(this).find("a").attr("id");
    if("undefined"!=id&&"index"!=id){
	    //出现遮罩层
	    jq("#iframe-mask").show();
	    //遮罩层消失
	    jq("#admin-iframe").load(function(){   
	      jq("#iframe-mask").fadeOut(100);
	    });
    }
  });
   
  //点击回到内容页面
  jq('.content_manage_title').click(function(){
  	jq('.left_menu_ul .layui-nav-item').removeClass('layui-this');
  	jq(this).parent().addClass('hide');
  	jq('.content_put_manage').find('.first-item').addClass('layui-this');
  	var url = jq('.content_put_manage').find('.first-item a').attr('href');
  	var id = jq('.content_put_manage').find('.first-item a').attr('id');
	jq('.admin-iframe').attr('src',url);
  	jq('.content_put_manage').removeClass('hide');

  });
  //更新缓存
  jq('.update_cache').click(function(){
    loading = layer.load(2, {
      shade: [0.2,'#000'] //0.2透明度的白色背景
    });
    jq.getJSON('',function(data){
      if(data.code == 200){
        layer.close(loading);
        layer.msg(data.msg, {icon: 1, time: 1000}, function(){
          location.reload();//do something
        });
      }else{
        layer.close(loading);
        layer.msg(data.msg, {icon: 2, anim: 6, time: 1000});
      }
    });
  });

  //退出登陆
  jq('.logout_btn').click(function(){
    loading = layer.load(2, {
      shade: [0.2,'#000'] //0.2透明度的白色背景
    });
    jq.getJSON('${path}/logout.do',function(data){
    	data = eval("(" + data + ")");
      if(data.code == 200){
        layer.close(loading);
        layer.msg(data.msg, {icon: 1, time: 1000}, function(){
          //location.reload();//do something
          window.location.href = "${path}/login.do";
        });
      }else{
        layer.close(loading);
        layer.msg(data.msg, {icon: 2, anim: 6, time: 1000});
      }
    });
  });

	
});


</script> 
</body>
</html>