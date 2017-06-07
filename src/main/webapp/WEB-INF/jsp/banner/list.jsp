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
      <div class="main-tab-item">轮播图列表</div>
    </ul>
    <div class="layui-tab-content">
      <div class="layui-tab-item layui-show">
      <!-- 搜索 -->
      <form class="layui-form layui-form-pane search-form" action="${path}/user/list.do">
        <div class="layui-form-item">
          <%-- <label class="layui-form-label">姓名</label>
          <div class="layui-input-inline">
            <input type="text" style="display: inline-block;" name="username" id="username" value="${username}" placeholder="请输入姓名搜索" autocomplete="off" class="layui-input">
          </div>
          <label class="layui-form-label">类型</label>
          <div class="layui-input-inline">
            <select id="usertype" name="usertype">
            	<option value="">--选择--</option>
            	<option value="1" <c:if test="${usertype eq '1'}">checked="checked""</c:if> >采购员</option>
            	<option value="2" <c:if test="${usertype eq '2'}">checked="checked""</c:if>>检验员</option>
            </select>
          </div> --%>
          <button class="layui-btn" id="search">搜索</button>
          <button class="layui-btn" type="button" id="add">新增</button>
        </div>
      </form>
      <form class="layui-form">
        <table class="list-table">
          <thead>
            <tr align="center">
              <th>序号</th>
              <th>标题</th>
              <th>地址</th>
              <th>排序号</th>
              <th>图片</th>
              <th>操作</th>
            </tr> 
          </thead>
          <tbody>
          	<c:forEach var="item" items="${bannerList}" varStatus="index">
          		<tr id="${item.banner_id}" align="center">
          			<td align="center">${index.index+1}</td>
          			<td>${item.banner_title}</td>
          			<td>
          				<a href="${item.banner_url}" target="_blank">${item.banner_url}</a>
          			</td>
          			<td>${item.banner_index}</td>
          			<td style="vertical-align: middle;">
          				<img src="${path}/banner/${item.banner_path}" width="16" height="16"/>
          			</td>
          			<td style="text-align: center;">
			            <a class="layui-btn layui-btn-small layui-btn-danger del_btn"
			                data-id="${item.banner_id}" data-name="${item.banner_title}" title="删除"><i class="layui-icon"></i></a> 
		            </td> 
          		</tr>
          	</c:forEach>
          </tbody>
          <thead>
            <tr>
               <!-- <th><button class="layui-btn layui-btn-small" lay-submit lay-filter="delete">删除</button></th> -->
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
      jq.post('${path}/banner/deleteBanner.do',{'id':id},function(data){
    	  data = jq.parseJSON(data);
          layer.close(loading);
          layer.msg("删除成功！", {icon: 1, time: 1000}, function(){
            location.reload();//do something
          });

      });
    });
    
  });
  
  jq("#search").on('click',function(){
	 jq("#search-form").submit();
  })
  jq("#add").on('click',function(){
	url = '${path}/banner/add.do';
	  jq('.admin-iframe', window.parent.document).attr('src',url);
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
        location.href = '${path}/banner/list.do?page='+e.curr;
      }
    }
  });
})

</script>

</body>
</html>