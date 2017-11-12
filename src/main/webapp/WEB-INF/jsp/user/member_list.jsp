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
      <div class="main-tab-item">会员列表</div>
    </ul>
    <div class="layui-tab-content">
      <div class="layui-tab-item layui-show">
      <!-- 搜索 -->
      <form class="layui-form layui-form-pane search-form" action="${path}/user/member_list.do">
        <div class="layui-form-item">
          <label class="layui-form-label">会员名</label>
          <div class="layui-input-inline">
            <input type="text" style="display: inline-block;" name="username" id="username" value="${username}" placeholder="请输入姓名搜索" autocomplete="off" class="layui-input">
          </div>
          <%-- <label class="layui-form-label">类型</label>
          <div class="layui-input-inline">
            <select id="usertype" name="usertype">
            	<option value="">--选择--</option>
            	<option value="1" <c:if test="${usertype eq '1'}">checked="checked""</c:if> >采购员</option>
            	<option value="2" <c:if test="${usertype eq '2'}">checked="checked""</c:if>>检验员</option>
            </select>
          </div> --%>
          <button class="layui-btn" id="search">搜索</button>
          <!-- <button class="layui-btn" type="button" id="add">新增</button> -->
        </div>
      </form>
      <form class="layui-form">
        <table class="list-table">
          <thead>
            <tr align="center">
              <th>序号</th>
              <th>姓名</th>
              <th>类型</th>
              <th>手机</th>
              <th>操作</th>
            </tr> 
          </thead>
          <tbody>
          	<c:forEach var="user" items="${userList}" varStatus="index">
          		<tr id="${user.userid}" align="center">
          			<td align="center">${index.index+1}</td>
          			<td>${user.username}</td>
          			<td>
          				商场会员
          			</td>
          			<td>${user.phone}</td>
          			<td style="text-align: center;">
          				<%-- <c:if test="${user.usertype ne '0' }">
			                <a class="layui-btn layui-btn-small layui-btn-danger del_btn"
			                data-id="${user.userid}" data-name="${user.username}" title="删除"><i class="layui-icon"></i></a> 
          				</c:if> --%>
          				暂无
		            </td> 
          		</tr>
          	</c:forEach>
          </tbody>
          <thead>
            <tr>
               <!-- <th><button class="layui-btn layui-btn-small" lay-submit lay-filter="delete">删除</button></th> -->
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
      jq.post('${path}/user/deleteUser.do',{'id':id},function(data){
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
	url = '${path}/user/add.do';
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
        location.href = '${path}/user/member_list.do?username='
        		+jq('#username').val()+'&page='+e.curr;
      }
    }
  });
})

</script>

</body>
</html>