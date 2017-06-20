<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
    <title>${sysname }</title>
    <link rel="stylesheet" href="${path}/layui/css/layui.css">
    <link rel="stylesheet" href="${path}/res/global.css">
    <script type="text/javascript" src="${path}/layui/layui.js"></script>
</head>
<body>
<div class="layui-tab layui-tab-brief main-tab-container" style="margin-top: 20px;">
    <ul class="layui-tab-title main-tab-title">
      <div class="main-tab-item">订单列表</div>
    </ul>
    <div class="layui-tab-content">
      <div class="layui-tab-item layui-show">
      <!-- 搜索 -->
      <form class="layui-form layui-form-pane search-form" action="${path}/banner/list.do">
        <div class="layui-form-item">
        </div>
      </form>
      <form class="layui-form">
        <table class="list-table">
          <thead>
            <tr align="center">
              <th>会员名称</th>
              <th>购买商品</th>
              <th>数量</th>
              <th>单价</th>
              <th>预付</th>
              <th>实结</th>
              <th>差额</th>
              <th>折扣</th>
              <th>购买时间</th>
            </tr> 
          </thead>
          <tbody>
          	<c:forEach var="item" items="${orderList}" varStatus="index">
          		<tr id="${item.order_id}" align="center">
          			<td>${item.member_id}</td>
          			<td>${item.goods_id}</td>
          			<td>${item.number}</td>
          			<td>${item.price }</td>
          			<td>${item.amount }</td> 
          			<td>${item.real_amount }</td> 
          			<td>${item.sub_amount }</td> 
          			<td>${item.rebate }</td> 
          			<td>${item.createtime }</td> 
          		</tr>
          	</c:forEach>
          </tbody>
          <thead>
            <tr>
               <!-- <th><button class="layui-btn layui-btn-small" lay-submit lay-filter="delete">删除</button></th> -->
              <th colspan="9"><div id="page"></div></th>
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
layui.use(['element', 'laypage', 'layer', 'form'], function(){
  var element = layui.element()
  ,jq = layui.jquery
  ,form = layui.form()
  ,laypage = layui.laypage;

  
  jq("#search").on('click',function(){
	 jq("#search-form").submit();
  })
  
  laypage({
    cont: 'page'
    ,skip: true
    ,pages: num //总页数
    ,groups: 5 //连续显示分页数
    ,curr: curr
    ,jump: function(e, first){ //触发分页后的回调
      if(!first){ //一定要加此判断，否则初始时会无限刷新
        loading = layer.load(2, {
          shade: [0.2,'#000'] //0.2透明度的白色背景
        });
        location.href = '${path}/order/list.do?page='+e.curr;
      }
    }
  });
})

</script>

</body>
</html>