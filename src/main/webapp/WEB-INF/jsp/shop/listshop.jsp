<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<!DOCTYPE HTML>
<html>
  <head>
    <meta charset="UTF-8">
    <title>${sysname }</title>
    <link rel="stylesheet" href="${path}/layui/css/layui.css">
    <link rel="stylesheet" href="${path}/res/global.css">
    <link rel="stylesheet" href="${path}/res/bootstrap.min.css">
    <link rel="stylesheet" href="${path}/res/city-picker.css">
    <script type="text/javascript" src="${path}/layui/layui.js"></script>
    <script type="text/javascript" src="${path}/js/commonUtil.js"></script>
    <script type="text/javascript" src="${path}/js/jquery.min.js"></script>
  </head>
 <body>
<div class="layui-tab layui-tab-brief main-tab-container" style="margin-top: 20px;">
  	<ul class="layui-tab-title main-tab-title">
      <div class="main-tab-item">商家信息</div>
    </ul>
    <div class="layui-tab-content">
      <div class="layui-tab-item layui-show">
      <!-- 搜索 -->
      <form class="layui-form layui-form-pane search-form" action="${path}/shop/listshop.do">
        <div class="layui-form-item">
          <label class="layui-form-label">商家名称</label>
          <div class="layui-input-inline">
            <input type="text" style="display: inline-block;" name="shopname" id="shopname" value="${shopname}" placeholder="请输入商家名称搜索" autocomplete="off" class="layui-input">
          </div>
          <button class="layui-btn" id="search">搜索</button>
          <!-- <button class="layui-btn" type="button" id="add">新增</button> -->
        </div>
      </form>
      <form class="layui-form">
        <table class="list-table">
          <thead>
            <tr>
              <td align="center">序号</td>
              <td align="center">商家名称</td>
              <td align="center">商家地址</td>
              <td align="center">商家坐标</td>
              <td align="center">创建时间</td>
              <td align="center">操作</td>
            </tr> 
          </thead>
          <tbody>
          	<c:forEach var="shop" items="${shoplist}" varStatus="index">
          		<tr id="${shop.shop_id}" align="center">
          			<td align="center">${index.index+1}</td>
          			<td align="center">${shop.shop_name}</td>
          			<td align="center">${shop.address}</td>
          			<td align="center">${shop.coordinate}</td>
          			<td align="center">${shop.createtime}</td>
          			<td style="text-align: center;">
			          <a class="layui-btn layui-btn-small layui-btn-danger del_btn"
			             data-id="${shop.shop_id}" data-name="${shop.shop_name}" title="删除"><i class="layui-icon"></i></a> 
		            </td> 
          		</tr>
          	</c:forEach>
          </tbody>
          <thead>
            <tr>
              <th colspan="6"><div id="page"></div></th>
            </tr> 
          </thead>
        </table>
      </form>
      </div>
    </div>
</div>
<script type="text/javascript">
var num = parseInt('${num}');
var curr = parseInt('${curr}');
layui.use(
		[ 'element', 'form','laypage', 'upload', 'layedit', 'laydate' ],function() {
		var element = layui.element(), 
		form = layui.form(), 
		laypage = layui.laypage,
		layedit = layui.layedit, 
		laydate = layui.laydate, 
		jq = layui.jquery;
		
		jq("#search").on('click',function(){
	 		jq("#search-form").submit();
  		})
		
		/* jq("#add").on('click',function(){
			url = '${path}/shop/addshop.do';
	  		jq('.admin-iframe', window.parent.document).attr('src',url);
  		}) */
  		
  		 //ajax删除
  		jq('.del_btn').click(function(){
    		var name = jq(this).data('name');
    		var id = jq(this).data('id');
    		layer.confirm('确定删除【'+name+'】?', function(index){
      			loading = layer.load(2, {
        			shade: [0.2,'#000'] //0.2透明度的白色背景
      			});
      			jq.post('${path}/shop/deleteShop.do',{'id':id},function(data){
    	  			data = jq.parseJSON(data);
          			layer.close(loading);
          			layer.msg("删除成功！", {icon: 1, time: 1000}, function(){
            			location.reload();//do something
          			});
      			});
    		});
  		});
  		
  		laypage({
    		cont: 'page',
    		skip: true,
    		pages: num,//总页数
    		groups: 5, //连续显示分页数
    		curr: curr,
    		jump: function(e, first){ //触发分页后的回调
      		if(!first){ //一定要加此判断，否则初始时会无限刷新
        		loading = layer.load(2, {
          		shade: [0.2,'#000'] //0.2透明度的白色背景
        	});
        	location.href = '${path}/shop/listshop.do?shopname='+jq('#shopname').val()+'&page='+e.curr;
      }
    }
  });
})
</script>
</body>
</html>
