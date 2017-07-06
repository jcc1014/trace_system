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
      <div class="main-tab-item">追溯列表</div>
    </ul>
    <div class="layui-tab-content">
      <div class="layui-tab-item layui-show">
      <!-- 搜索 -->
      <form class="layui-form layui-form-pane search-form">
        <div class="layui-form-item">
          <label class="layui-form-label">农户</label>
          <div class="layui-input-inline">
            <input type="text" style="display: inline-block;" name="farmer_name" id="farmer_name" value="" lay-verify="" placeholder="请输入姓名搜索" autocomplete="off" class="layui-input">
          </div>
          <label class="layui-form-label">日期范围</label>
          <div class="layui-input-inline">
		      <input class="layui-input" name="createtime" id="starttime" placeholder="开始日" >
		  </div>
		  <div class="layui-input-inline">
		      <input class="layui-input"  placeholder="截止日" id="endtime">
		  </div>
          <button class="layui-btn" lay-submit="" lay-filter="">搜索</button>
        </div>
      </form>
      <form class="layui-form">
        <table class="list-table">
          <thead>
            <tr align="center">
              <!-- <th style="width:40px"><input type="checkbox" name="checkAll" lay-filter="checkAll" title=" "></th> -->
              <th>序号</th>
              <th>农户</th>
              <th>种类</th>
              <th>品级</th>
              <th>采购员</th>
              <th>取样员</th>
              <th>检测员</th>
              <th>目的地</th>
              <th>创建时间</th>
              <th>二维码</th>
              <th>操作</th>
            </tr> 
          </thead>
          <tbody>
          	<c:forEach var="trace" items="${list}" varStatus="index">
          		<tr id="${trace.trace_id}">
          			<td align="center">${index.index+1}</td>
          			<td>${trace.farmer_name}</td>
          			<td>${trace.purchase_kind}</td>
          			<td>${trace.purchase_grade}</td>
          			<td>${trace.purchase_user}</td>
          			<td>${trace.test_name}</td>
          			<td>${trace.test_user}</td>
          			<td>${trace.transport_destination}</td>
          			<%-- <td>${trace.trace_status}</td> --%>
          			<td>${trace.createtime }</td>
          			<td align="center" width="60"><a href="javascript:void(0);" onclick="qrcode('${trace.trace_id}')"><img alt="打印二维码" width="18" height="18" src="${path}/images/qrcode-mini.png"></a></td>
          			<td><a href="javascript:void(0);" onclick="sampling('${trace.sampling_id}')">抽检</a></td>
          		</tr>
          	</c:forEach>
          </tbody>
          <thead>
            <tr>
               <!-- <th><button class="layui-btn layui-btn-small" lay-submit lay-filter="delete">删除</button></th> -->
              <th colspan="11"><div id="page"></div></th>
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
        location.href = '${path}/trace/list.do?farmer_name='
        		+jq('#farmer_name').val()+'&starttime='+jq("#starttimr").val()+'&page='+e.curr
        		+'&endtime='+jq("#endtime");
      }
    }
  });
})

layui.use('laydate', function(){
  var laydate = layui.laydate;
  
  var start = {
    min: '2017-5-20 23:59:59'
    ,max: '2099-06-16 23:59:59'
    ,istoday: false
    ,choose: function(datas){
      end.min = datas; //开始日选好后，重置结束日的最小日期
      end.start = datas //将结束日的初始值设定为开始日
    }
  };
  
  var end = {
    min: '2017-5-20 23:59:59'
    ,max: '2099-06-16 23:59:59'
    ,istoday: false
    ,choose: function(datas){
      start.max = datas; //结束日选好后，重置开始日的最大日期
    }
  };
  
  document.getElementById('starttime').onclick = function(){
    start.elem = this;
    laydate(start);
  }
  document.getElementById('endtime').onclick = function(){
    end.elem = this
    laydate(end);
  }
  
});

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
function sampling(id){
	window.location.href = '${path}/trace/sampling.do?sampling_id='+id;
}
</script>

</body>
</html>