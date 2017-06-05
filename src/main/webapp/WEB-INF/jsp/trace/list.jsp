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
              <th>蔬菜种类</th>
              <th>采购员</th>
              <th>检测员</th>
              <th>抽检员</th>
              <th>目的地</th>
              <!-- <th>状态</th> -->
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
          			<td>${trace.purchase_type}</td>
          			<td>${trace.purchase_name}</td>
          			<td>${trace.test_name}</td>
          			<td>${trace.sampling_name}</td>
          			<td>${trace.transport_destination}</td>
          			<%-- <td>${trace.trace_status}</td> --%>
          			<td>${trace.createtime }</td>
          			<td align="center" width="60"><a href="javascript:void(0);" onclick="qrcode('${trace.trace_id}')"><img alt="打印二维码" width="18" height="18" src="${path}/images/qrcode-mini.png"></a></td>
          			<td><a href="javascript:void(0);" onclick="sampling('${trace.sampling_id}')">抽检</a></td>
          			<%-- <td>
          			<c:if test="${trace.qrcode !=null && trace.qrcode ne ''}">
          				<img src="${path}/images/qrcode.png" id="${trace.qrcode}" />
          			</c:if>
          			<c:if test="${trace.qrcode ==null || trace.qrcode eq ''}">
          				暂未生成
          			</c:if>
          			</td>
          			<td style="text-align: center;">
          				<c:if test="${trace.trace_status ne '6'}">
			                <a href="./feedback_edit.html" class="layui-btn layui-btn-small" title="编辑"><i class="layui-icon"></i></a>
          				</c:if>
          				<c:if test="${trace.trace_status eq '6'}">
			              	  已结束
          				</c:if>
		                <!-- <a class="layui-btn layui-btn-small layui-btn-danger del_btn" feedback-id="9" title="删除" feedback-name="95的小鲜肉啊"><i class="layui-icon"></i></a> -->
		            </td> --%>
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

  //留言预览
  jq('.list-title').click(function(){
    loading = layer.load(2, {
      shade: [0.2,'#000'] //0.2透明度的白色背景
    });
    var id = jq(this).attr('feedback-id');

        layer.close(loading);
        layer.open({
          type: 1,
          area: ['500px'],
          title: '留言内容',
          content: '<div style="padding:15px 20px;">'+'95的小鲜肉啊95的小鲜肉啊95的小鲜肉啊95的小鲜肉啊95的小鲜肉啊95的小鲜肉啊95的小鲜肉啊95的小鲜肉啊95的小鲜肉啊'+'</div>' //注意，如果str是object，那么需要字符拼接。
        });
  });
 
  //留言回复
  jq('.reply_btn').click(function(){
  	var id = jq(this).attr('feedback-id');
    layer.open({
      type: 2,
      icon: 2,
      maxmin: true,
      area: ['800px','500px'],
      title: '回复内容',
      content: ['' ,'no']
    });
  });
  

  //ajax删除
  jq('.del_btn').click(function(){
    var name = jq(this).attr('feedback-name');
    var id = jq(this).attr('feedback-id');
    layer.confirm('确定删除【'+name+'】?', function(index){
      loading = layer.load(2, {
        shade: [0.2,'#000'] //0.2透明度的白色背景
      });
      jq.post('',{'id':id},function(data){

          layer.close(loading);
          layer.msg(data.msg, {icon: 1, time: 1000}, function(){
            location.reload();//do something
          });

      });
    });
    
  });
  
  //全选
  form.on('checkbox(checkAll)', function(data){
    if(data.elem.checked){
      jq("input[type='checkbox']").prop('checked',true);
    }else{
      jq("input[type='checkbox']").prop('checked',false);
    }
    form.render('checkbox');
  });  

  form.on('checkbox(checkOne)', function(data){
    var is_check = true;
    if(data.elem.checked){
      jq("input[lay-filter='checkOne']").each(function(){
        if(!jq(this).prop('checked')){ is_check = false; }
      });
      if(is_check){
        jq("input[lay-filter='checkAll']").prop('checked',true);
      }
    }else{
      jq("input[lay-filter='checkAll']").prop('checked',false);
    } 
    form.render('checkbox');
  });

  //监听提交
  form.on('submit(delete)', function(data){
    //判断是否有选项
    var is_check = false;
    jq("input[lay-filter='checkOne']").each(function(){
      if(jq(this).prop('checked')){ is_check = true; }
    });
    if(!is_check){
      layer.msg('请选择数据', {icon: 2,anim: 6,time: 1000});
      return false;
    }
    //确认删除
    layer.confirm('确定批量删除?', function(index){
      loading = layer.load(2, {
        shade: [0.2,'#000'] //0.2透明度的白色背景
      });
      var param = data.field;
      jq.post('',param,function(data){
        if(data.code == 200){
          layer.close(loading);
          layer.msg(data.msg, {icon: 1, time: 1000}, function(){
            location.reload();//do something
          });
        }else{
          layer.close(loading);
          layer.msg(data.msg, {icon: 2,anim: 6, time: 1000});
        }
      });
    });
    return false;
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