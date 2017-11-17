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
      <div class="main-tab-item">二维码列表</div>
    </ul>
    <div class="layui-tab-content">
      <div class="layui-tab-item layui-show">
      <!-- 搜索 -->
      <form class="layui-form layui-form-pane search-form" method="post" action="${path}/distribution/psList.do" id="form">
        <div class="layui-form-item">
          <label class="layui-form-label">日期</label>
          <div class="layui-input-inline">
            <input class="layui-input" name="createtime" id="createtime" placeholder="日期" >
          </div>
          <label class="layui-form-label">蔬菜编码</label>
          <div class="layui-input-inline">
            <input class="layui-input" name="trace_id" id="trace_id" placeholder="蔬菜编码" >
          </div>
          <label class="layui-form-label">配送码</label>
          <div class="layui-input-inline">
            <input class="layui-input" name="psbh" id="psbh" placeholder="配送码" >
          </div>
          <button class="layui-btn" id="search" type="submit">搜索</button>
         <!--  <button class="layui-btn" type="button" id="add">新增</button> -->
        </div>
      </form>
      <form class="layui-form">
        <table class="list-table">
          <thead>
            <tr>
              <td align="center">日期</td>
              <td align="center">需求方</td>
              <td align="center">名称</td>
              <td align="center">数量</td>
              <td align="center">配送码</td>
              <td align="center">蔬菜编码</td>
              <td align="center">二维码</td>
            </tr> 
          </thead>
          <tbody>
          	<c:forEach var="item" items="${list}" varStatus="index">
          		<tr id="${item.id}" align="center">
          			<td align="center">${item.createtime}</td>
          			<td align="center">${item.distributionInfo.require_name}</td>
          			<td align="center">
          			${item.distributionInfo.kind}${item.distributionInfo.grade}级${item.distributionInfo.spyb}
          			</td>
          			<td align="center">${item.distribution_num}</td>
          			<td align="center">${item.psbh}</td>
          			<td align="center">${item.trace_id}</td>
          			<td align="center" width="60">
          				<a href="javascript:void(0);" onclick="qrcode('${item.distribution_qrcode}')">
          				<img alt="打印二维码" width="18" height="18" src="${path}/images/qrcode-mini.png">
          				</a>
          			</td>
          		</tr>
          	</c:forEach>
          </tbody>
          <thead>
            <tr>
              <th colspan="7"><div id="page"></div></th>
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
        	location.href = '${path}/distribution/psList.do?page='+e.curr;
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
  
  document.getElementById('createtime').onclick = function(){
    start.elem = this;
    laydate(start);
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
		  content: '${path}/distribution/print.do?id='+id
		});
}
</script>
</body>
</html>
