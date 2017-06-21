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
    <script type="text/javascript" src="${path}/layui/layui.js"></script>
    <script type="text/javascript" src="${path}/js/commonUtil.js"></script>
    <script type="text/javascript" src="${path}/js/jquery.min.js"></script>
  </head>
 <body>
<div class="layui-tab layui-tab-brief main-tab-container" style="margin-top: 20px;">
  	<ul class="layui-tab-title main-tab-title">
      <div class="main-tab-item">进货信息</div>
    </ul>
    <div class="layui-tab-content">
      <div class="layui-tab-item layui-show">
      <form class="layui-form layui-form-pane search-form" action="${path}/shopgoods/list.do">
        <div class="layui-form-item">
          <label class="layui-form-label">商品类型</label>
          <div class="layui-input-inline">
            <input type="text" style="display: inline-block;" name="goods_name" id="goods_name" value="${shopname}" placeholder="请输入进货类别搜索" autocomplete="off" class="layui-input">
          </div>
          <button class="layui-btn" id="search">搜索</button>
        </div>
      </form>
      <form class="layui-form">
        <table class="list-table">
          <thead>
            <tr>
              <td align="center">序号</td>
              <td align="center">商家名称</td>
              <td align="center">商品种类</td>
              <td align="center">进货数量</td>
              <td align="center">创建时间</td>
              <td align="center">操作</td>
            </tr> 
          </thead>
          <tbody>
          	<c:forEach var="shopgoods" items="${shopgoodslist}" varStatus="index">
          		<tr id="${shopgoods.shop_goods_id}" align="center">
          			<td align="center">${index.index+1}</td>
          			<td align="center">${shopgoods.shop_name}</td>
          			<td align="center">${shopgoods.goods_name}</td>
          			<td align="center">${shopgoods.goods_num} kg</td>
          			<td align="center">${shopgoods.createtime}</td>
          			<td align="center">
          			<c:forEach var="shopid" items="${shopidList}" varStatus="index">
          				<c:if test="${shopgoods.shop_id eq shopid}">
			          		<a class="layui-btn layui-btn-small layui-btn-danger del_btn"
			             		data-id="${shopgoods.shop_goods_id}" title="删除"><i class="layui-icon"></i></a> 	
          				</c:if>
          			</c:forEach>
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
  		
  		//ajax删除
  		jq('.del_btn').click(function(){
    		var id = jq(this).data('id');
    		layer.confirm('确定删除?', function(index){
      			loading = layer.load(2, {
        			shade: [0.2,'#000'] //0.2透明度的白色背景
      			});
      			jq.post('${path}/shopgoods/delete.do',{'id':id},function(data){
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
        	location.href = '${path}/shopgoods/list.do?goods_name='+jq('#goods_name').val()+'&page='+e.curr;
      }
    }
  });
})
</script>
</body>
</html>
