<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../common/common.jsp" %>
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
      <div class="main-tab-item">检验列表</div>
    </ul>
    <div class="layui-tab-content">
      <div class="layui-tab-item layui-show">
      <!-- 搜索 -->
      <form class="layui-form layui-form-pane search-form" >
        <div class="layui-form-item">
          <!-- <label class="layui-form-label">姓名</label>
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
          </div> 
          <button class="layui-btn" id="search">搜索</button> -->
        </div>
      </form>
      <form class="layui-form">
        <table class="list-table">
          <thead>
            <tr align="center">
              <th>编号</th>
              <th>种类</th>
              <th>品级</th>
              <th>数量</th>
              <th>取样员</th>
              <th>农户</th>
              <th>时间</th>
              <th>操作</th>
            </tr> 
          </thead>
          <tbody>
          	<c:if test="${fn:length(list)==0 }">
          		<tr>
          			<td colspan="8">暂无检验数据</td>
          		</tr>
          	</c:if>
          	<c:forEach var="item" items="${list}" varStatus="index">
          		<tr id="${item.test.test_id}" align="center">
          			<td align="center">${item.test.test_bh}</td>
          			<td>${item.test.test_kind}</td>
          			<td>
          				${item.test.test_grade }
          			</td>
          			<td>${item.test.test_num}</td>
          			<td>${item.test.test_name}</td>
          			<td>${item.farmer.farmer_name}</td>
          			<td>${item.test.test_time}</td>
          			<td style="text-align: center;">
			            <a class="layui-btn layui-btn-small layui-btn-danger del_btn"
			               title="检验" href = "javascript:;" onclick="test('${item.test.test_id}')">检验</a> 
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
        location.href = '${path}/sampling/testList.do?page='+e.curr;
      }
    }
  });
})

function test(id){
	window.location.href = '${path}/sampling/testSamplings.do?test_id='+id;
}

</script>

</body>
</html>