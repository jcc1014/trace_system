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
      <div class="main-tab-item">追溯信息</div>
    </ul>
    <div class="layui-tab-content">
      <div class="layui-tab-item layui-show">
      <!-- 搜索 -->
      <form class="layui-form layui-form-pane search-form" action="${path}/transportList/list.do">
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
              <th>序号</th>
              <th>农户</th>
              <th>种类</th>
              <th>品级</th>
              <th>采购量</th>
              <th>采购员</th>
              <th>取样员</th>
              <th>检验员</th>
              <th>时间</th>
              <th>识别码</th>
              <th>二维码</th>
              <th>操作</th>
            </tr> 
          </thead>
          <tbody>
          	<c:if test="${fn:length(list)==0 }">
          		<tr>
          			<td colspan="10">暂无检验数据</td>
          		</tr>
          	</c:if>
          	<c:forEach var="item" items="${list}" varStatus="index">
          		<tr id="${item.test.test_id}" align="center">
          			<td align="center">${index.index+1}</td>
          			<td>${item.farmer_name}</td>
          			<td>${item.purchase_kind}</td>
          			<td>
          				${item.purchase_grade }
          			</td>
          			<td>${item.purchase_num}</td>
          			<td>${item.purchase_user}</td>
          			<td>${item.test_name}</td>
          			<td>${item.test_user}</td>
          			<td>${fn:substring(item.purchase_time,0,10)}</td>
          			<td>${item.identifier}</td>
          			<td align="center" width="60">
          				<c:if test="${item.qrcode != null && item.qrcode ne ''}">
          				<a href="javascript:void(0);" onclick="qrcode('${item.trace_id}')">
          					<img alt="打印二维码" width="18" height="18" src="${path}/images/qrcode-mini.png">
          				</a>
          				</c:if>
          				<c:if test="${item.trace_status ne '6' }">
          					暂无
          				</c:if>
          			</td>
          			<td style="text-align: center;">
          				<c:if test="${item.trace_status ne '6' }">
				            <a class="layui-btn layui-btn-small layui-btn-danger del_btn"
				               title="运输" href = "javascript:;" onclick="transport('${item.trace_id}')">运输</a> 
          				</c:if>
          				<c:if test="${item.trace_status eq '6' }">
				           	 已运输 
          				</c:if>
		            </td> 
          		</tr>
          	</c:forEach>
          </tbody>
          <!-- <thead>
            <tr>
               <th><button class="layui-btn layui-btn-small" lay-submit lay-filter="delete">删除</button></th>
              <th colspan="10"><div id="page"></div></th>
            </tr> 
          </thead> -->
        </table>
      </form>
      </div>
    </div>
</div>
<script type="text/javascript">
/* var num = parseInt('${num}');
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
}) */
layui.use(['element', 'laypage', 'layer', 'form'], function(){
	  var element = layui.element()
	  ,jq = layui.jquery
	  ,form = layui.form()
	  ,laypage = layui.laypage;
});
function transport(id){
	window.location.href = '${path}/transport/addTransport.do?trace_id='+id;
}
function qrcode(id){
	layer.open({
		  type: 2,
		  title: "打印",
		  area: ['250px', '260px'],
		  shade: 0.8,
		  closeBtn: 1,
		  shadeClose: true,
		  content: '${path}/trace/print.do?trace_id='+id
		});
}
</script>

</body>
</html>