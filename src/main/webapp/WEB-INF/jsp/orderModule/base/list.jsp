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
    	html{height: 100%;}
    	body{height: 100%;}
    	.layui-tab{height: 100%};
    	.layui-tab-content{height: 475px;}
    </style>
  </head>
 <body>
<div class="layui-tab layui-tab-brief main-tab-container" style="margin-top: 20px;">
  	<ul class="layui-tab-title main-tab-title">
      <div class="main-tab-item">基础信息</div>
    </ul>
    <div class="layui-tab-content">
      <div class="layui-tab-item layui-show">
      <!-- 搜索 -->
      <form class="layui-form layui-form-pane search-form" method="post" action="${path}/baseInfo/list.do" id="form">
        <div class="layui-form-item">
          <label class="layui-form-label">名称</label>
          <div class="layui-input-inline">
            <input type="text" style="display: inline-block;" name="name" id="name" value="${name}" placeholder="请输入名称搜索" autocomplete="off" class="layui-input">
          </div>
          <label class="layui-form-label">类型</label>
          <div class="layui-input-inline">
            <select name="type" id="type">
            	<option value=""></option>
            	<option value="1">生产基地</option>
            	<option value="2">超市</option>
            	<option value="3">食堂</option>
            	<option value="4">孟鑫</option>
            </select>
          </div>
          <button class="layui-btn" id="search" type="submit">搜索</button>
          <button class="layui-btn" type="button" id="add">新增</button>
        </div>
      </form>
      <form class="layui-form">
        <table class="list-table">
          <thead>
            <tr>
              <td align="center">名称</td>
              <td align="center">地址</td>
              <td align="center">类型</td>
              <td align="center">代码</td>
              <td align="center">负责人</td>
              <td align="center">手机</td>
              <!-- <td align="center">操作</td> -->
            </tr> 
          </thead>
          <tbody>
          	<c:forEach var="item" items="${baseInfoList}" varStatus="index">
          		<tr id="${item.id}" align="center">
          			<td align="center">${item.name}</td>
          			<td align="center">${item.address}</td>
          			<td align="center">
          				<c:if test="${item.type eq '1' }">生产基地</c:if>
          				<c:if test="${item.type eq '2' }">超市</c:if>
          				<c:if test="${item.type eq '3' }">食堂</c:if>
          				<c:if test="${item.type eq '4' }">孟鑫</c:if>
          			</td>
          			<td align="center">${item.code}</td>
          			<td align="center">
          				<c:forEach var="user" items="${userList }">
          					<c:if test="${item.fzr eq user.userid}">${user.username }</c:if>
          				</c:forEach>
          			</td>
          			<td align="center">${item.phone}</td>
          			 <%-- <td style="text-align: center;">
	          				 <a class="layui-btn layui-btn-small layui-btn-warm detail_btn" title="详细信息" 
	          				href="${path}/base/watch.do?id=${item.id}">
	          					<i class="layui-icon">&#xe63c;</i>
	          				</a>
			         <a class="layui-btn layui-btn-small layui-btn-danger del_btn"
			             data-id="${item.id}" data-name="${item.name}" title="删除"><i class="layui-icon"></i></a> 
		            </td> --%>
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
    		var name = jq(this).data('name');
    		var id = jq(this).data('id');
    		layer.confirm('确定删除【'+name+'】?', function(index){
      			loading = layer.load(2, {
        			shade: [0.2,'#000'] //0.2透明度的白色背景
      			});
      			jq.post('${path}/baseInfo/delete.do',{'id':id},function(data){
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
        	location.href = '${path}/baseInfo/list.do?page='+e.curr;
      }
    }
  });
})

$("#add").click(function(){
	window.location.href = "${path}/baseInfo/add.do";
})
</script>
</body>
</html>
