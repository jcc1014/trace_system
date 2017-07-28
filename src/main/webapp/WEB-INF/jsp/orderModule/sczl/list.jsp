<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../common/common.jsp" %>
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
    <style type="text/css">
	html {height: 100%;}
	body {height: 100%;}
	.layui-tab {height: 100%};
	.layui-tab-content {height: 475px;}
	.word_break {
		word-break: break-all; /*支持IE，chrome，FF不支持*/
		word-wrap: break-word; /*支持IE，chrome，FF*/
	}
</style>
  </head>
 <body>
<div class="layui-tab layui-tab-brief main-tab-container" style="margin-top: 20px;">
  	<ul class="layui-tab-title main-tab-title">
      <div class="main-tab-item">蔬菜分类查询</div>
    </ul>
    <div class="layui-tab-content">
      <div class="layui-tab-item layui-show">
      <!-- 搜索 -->
      <form class="layui-form layui-form-pane search-form" method="post" action="${path}/sczl/list.do" id="form">
        <div class="layui-form-item">
          <label class="layui-form-label">种类</label>
          <div class="layui-input-inline" style="width: 150px;">
            <select name="kind">
            	<option value=""></option>
            	<c:forEach var="item" items="${goodsList}">
	            	<option value="${item.goods_name }">${item.goods_name }</option>
            	</c:forEach>
            </select>
          </div>
          <label class="layui-form-label">类型</label>
          <div class="layui-input-inline" style="width: 150px;">
            <select name="grade" id="grade">
            	<option value=""></option>
            	<option value="1">1</option>
            	<option value="2">2</option>
            	<option value="3">3</option>
            </select>
          </div>
          <label class="layui-form-label">三品一标</label>
          <div class="layui-input-inline">
            <select name="spyb" id="spyb">
            	<option value=""></option>
            	<c:forEach var="item" items="${dictList}">
	            	<option value="${item.dict_name }">${item.dict_name }</option>
            	</c:forEach>
            </select>
          </div>
          <button class="layui-btn" id="search" type="submit">搜索</button>
          <button class="layui-btn" type="button" id="add" >新增</button>
        </div>
      </form>
      <form class="layui-form">
        <table class="list-table">
          <thead>
            <tr>
              <td align="center" width="17%">种类</td>
              <td align="center" width="10%">等级</td>
              <td align="center" width="18%">三品一标</td>
              <td align="center" width="40%">描述</td>
              <td align="center" width="15%">操作</td>
            </tr> 
          </thead>
          <tbody>
          	<c:forEach var="item" items="${sczlList}" varStatus="index">
          		<tr id="${item.id}" align="center">
          			<td align="center">${item.kind}</td>
          			<td align="center">${item.grade}</td>
          			<td align="center">${item.spyb}</td>
          			<td align="left" class="word_break">${item.content}</td>
          			<td style="text-align: center;">
				         <a class="layui-btn layui-btn-small layui-btn-danger "
							onclick="modify('${item.id}');" title="修改"> 修改
						</a>
				         <a class="layui-btn layui-btn-small layui-btn-danger del_btn"
							 data-id="${item.id}" title="删除"> 删除
						</a>
					</td>
          		</tr>
          	</c:forEach>
          </tbody>
          <thead>
            <tr>
              <th colspan="5"><div id="page"></div></th>
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
    		layer.confirm('确定删除吗?', function(index){
      			loading = layer.load(2, {
        			shade: [0.2,'#000'] //0.2透明度的白色背景
      			});
      			jq.post('${path}/sczl/delete.do',{'id':id},function(data){
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
        	location.href = '${path}/sczl/list.do?page='+e.curr;
      }
    }
  });
})

$("#add").click(function(){
	window.location.href = "${path}/sczl/add.do";
})
function modify(id){
	window.location.href = "${path}/sczl/modify.do?id="+id;
}
</script>
</body>
</html>
