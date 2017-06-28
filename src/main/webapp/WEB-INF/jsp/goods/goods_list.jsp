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
      <div class="main-tab-item">商品列表</div>
    </ul>
    <div class="layui-tab-content">
      <div class="layui-tab-item layui-show">
      <!-- 搜索 -->
      <form class="layui-form layui-form-pane search-form" action="${path}/goods/list.do">
        <div class="layui-form-item">
          <label class="layui-form-label">商品名称</label>
          <div class="layui-input-inline">
            <input type="text" style="display: inline-block;" name="goods_name" id="goods_name" value="${condition.obj.goods_name}" placeholder="请输入商品名称搜索" autocomplete="off" class="layui-input">
          </div>
          <label class="layui-form-label">商品类型</label>
          <div class="layui-input-inline">
            <select id="goods_type" name="goods_type">
            	<option value="">--选择--</option>
            	<c:forEach items="${types}" var="type">
            		<c:if test="${condition.obj.goods_type eq type.dict_id}">
            			<option value="${type.dict_id}" selected="selected">${type.dict_name}</option>
            		</c:if>
            		<c:if test="${condition.obj.goods_type ne type.dict_id}">
            			<option value="${type.dict_id}">${type.dict_name}</option>
            		</c:if>
            	</c:forEach>
            </select>
          </div>
          <button class="layui-btn" id="search">搜索</button>
          <button class="layui-btn" type="button" id="add">新增</button>
        </div>
      </form>
      <form class="layui-form">
        <table class="list-table">
          <thead>
            <tr align="center">
              <th>序号</th>
              <th>名称</th>
              <th>类型</th>
              <th>商品描述</th>
              <th>最新价格（单位：元）</th>
              <th>历史价格（单位：元）</th>
              <th>创建时间</th>
              <th>操作</th>
            </tr> 
          </thead>
          <tbody>
          	<c:forEach var="goods" items="${list}" varStatus="status">
          		<tr id="${goods.goods_id}" align="center">
          			<td align="center">${status.index+1}</td>
          			<td>${goods.goods_name}</td>
          			<td>
          				<c:forEach items="${types}" var="type">
          					<c:if test="${type.dict_id eq goods.goods_type}">
          						${type.dict_name}
          					</c:if>
          				</c:forEach>
          			</td>
          			<td>${goods.goods_description}</td>
          			<td>${goods.new_price}</td>
          			<td>${goods.old_price}</td>
          			<td>${goods.create_time}</td>
          			<td>
          				<a class="layui-btn layui-btn-small layui-btn-warm detail_btn" data-id="${goods.goods_id}" data-name="${goods.goods_name}" title="详细信息">
          					<i class="layui-icon">&#xe63c;</i>
          				</a>
          				<a class="layui-btn layui-btn-small layui-btn-danger del_btn" data-id="${goods.goods_id}" data-name="${goods.goods_name}" title="删除">
          					<i class="layui-icon"></i>
          				</a>
          			</td>
          		</tr>
          	</c:forEach>
          </tbody>
          <thead>
            <tr>
               <!-- <th><button class="layui-btn layui-btn-small" lay-submit lay-filter="delete">删除</button></th> -->
              <th colspan="8"><div id="page"></div></th>
            </tr> 
          </thead>
        </table>
      </form>
      </div>
    </div>
</div>
<script type="text/javascript">
var num = parseInt('${condition.totalPages}');
var curr = parseInt('${condition.page}');
layui.use(['element', 'laypage', 'layer', 'form'], function(){
  var element = layui.element()
  ,jq = layui.jquery
  ,form = layui.form()
  ,laypage = layui.laypage;

  

  //ajax删除
  jq('.del_btn').click(function(){
	var name = jq(this).data('name');
    var id = jq(this).data('id');
    layer.confirm('确定删除【'+name+'】?', function(index){
      loading = layer.load(2, {
        shade: [0.2,'#000'] //0.2透明度的白色背景
      });
      jq.post('${path}/goods/delete.do',{'id':id},function(data){
    	  data = jq.parseJSON(data);
          layer.close(loading);
          layer.msg("删除" + data.msg, {icon: 1, time: 1000}, function(){
            location.reload();//do something
          });
      });
    });
    
  });
  
  jq("#search").on('click',function(){
	  jq("#search-form").submit();
  })
  jq("#add").on('click',function(){
	  url = '${path}/goods/edit.do';
	  jq('.admin-iframe', window.parent.document).attr('src',url);
  })
  jq(".detail_btn").on('click',function(){
      var goods_id = jq(this).data('id') || jq(this).attr('data-id');
	  url = '${path}/goods/edit.do?goods_id=' + goods_id;
	  jq('.admin-iframe', window.parent.document).attr('src',url);
  });

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
        location.href = '${path}/goods/list.do?goods_name='
        		+jq('#goods_name').val()+'&goods_type='+jq("#goods_type").val()+'&page='+e.curr;
      }
    }
  });
})

</script>

</body>
</html>