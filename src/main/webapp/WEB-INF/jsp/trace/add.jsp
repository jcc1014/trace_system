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
    <script type="text/javascript" src="${path}/js/commonUtil.js"></script>
    <style type="text/css">
    	.layui-upload-button{position: relative;}
    	.disable{border: 0 !important;}
    	.hide{display: none !important;}
    	.inline{display: inline-block !important;}
    	.layui-form{height: 490px;width: 330px; padding-top: 5px;border-bottom: 1px solid #e2e2e2;}
    	.layui-form-label{width: 80px;}
    	#farmer_video_span{margin-left: 5px;width: 50px;overflow: hidden; margin-top: 20px;line-height: 38px;}
    	#purchase_video_span{margin-left: 5px;width: 50px;overflow: hidden; margin-top: 20px;line-height: 38px;}
    </style>
</head>
<body>
<div class="layui-tab layui-tab-brief main-tab-container" style="margin-top: 20px;">
    <ul class="layui-tab-title main-tab-title">
      <div class="main-tab-item" data-id="" data-status = "">新增追溯</div>
    </ul>
   <!--  <div class="layui-tab layui-tab-brief"  style="margin-left: 20px;"> -->
	 <!--  <ul class="layui-tab-title">
	    <li class="layui-this">农户信息</li>
	    <li>采购信息</li>
	    <li>检验信息</li>
	    <li>抽检信息</li>
	    <li>运输信息</li>
	    <li>生成二维码</li>
	  </ul> -->
	  <div class="layui-tab-content" style="margin-top: 1%;">
	    <div class="layui-tab-item layui-show inline"  >
	    	<input type="text" class="hide" id="trace_id"/>
	    	<input type="text" class="hide" id="state"/>
	   	 	<div class="layui-form">
			  <div class="layui-form-item">
			    <label class="layui-form-label" style="width: 100%;text-align: center !important;">农户信息</label>
			  </div>
			  <div class="layui-form-item">
			    <label class="layui-form-label">姓名</label>
			    <div class="layui-input-inline">
			      <input type="text" id="farmer_name"  placeholder="请输入姓名"  class="layui-input ">
			    </div>
			  </div>
			  <div class="layui-form-item">
			    <label class="layui-form-label">手机号</label>
			    <div class="layui-input-inline">
			      <input type="text" id="farmer_phone" required  placeholder="请输入手机号" autocomplete="off" class="layui-input">
			    </div>
			  </div>
			  <div class="layui-form-item">
			    <label class="layui-form-label">所属合作社</label>
			    <div class="layui-input-inline">
			      <input type="text" id="farmer_hzs" required  placeholder="请输入合作社" autocomplete="off" class="layui-input">
			    </div>
			  </div>
			  <div class="layui-form-item">
			    <label class="layui-form-label">上传视频</label>
			    <div class="layui-input-inline" style="float: left;">
			      <input type="file" id="farmer_video_upload" name="farmer_video" lay-type="file" lay-ext="mp4|rmvb|avi|3GP|mov" class="layui-upload-file">
			      
			    </div>
			    <input type="text" class="hide" id="farmer_video_input"/>
			  </div>
			  <div class="layui-form-item">
			   	<label class="layui-form-label">已传视频</label>
			    <div class="layui-input-inline">
					<span id="farmer_video_span" ></span>
			    </div>
			  </div>
			</div>
	    </div>
	    <div class="layui-tab-item layui-show inline" >
	  	 	<div class="layui-form">
	  	 	  <div class="layui-form-item">
			    <label class="layui-form-label" style="width: 100%;text-align: center !important;">采购信息</label>
			  </div>
			  <div class="layui-form-item">
			    <label class="layui-form-label">采购人</label>
			    <div class="layui-input-inline">
			      <%-- <input type="text" id="purchase_name" placeholder="请输入采购人" value="${sessionScope.user.username }" required placeholder="请输入采购人"  class="layui-input"> --%>
			      <select name="purchase_name" id="purchase_name">
			      	<option value="">--请选择--</option>
			      	<c:forEach var="item" items="${purchaseList }">
			      		<option value="${item.username}">${item.username}</option>
			      	</c:forEach>
			      </select>
			    </div>
			  </div>
			  <div class="layui-form-item">
			    <label class="layui-form-label">蔬菜名称</label>
			    <div class="layui-input-inline">
			      <input type="text" id="purchase_type" required placeholder="请输入蔬菜名称" class="layui-input">
			    </div>
			  </div>
			  <div class="layui-form-item">
			    <label class="layui-form-label">采购数量</label>
			    <div class="layui-input-inline">
			      <input type="text" id="purchase_num"  placeholder="请输入采购数量"  class="layui-input">
			    </div>
			  </div>
			  <div class="layui-form-item">
			    <label class="layui-form-label">采购时间</label>
			    <div class="layui-input-inline">
			      <input type="text" id="purchase_time" readonly="readonly" placeholder="请选择采购时间" onclick="layui.laydate({elem: this, istime: true, format: 'YYYY-MM-DD hh:mm:ss'})"  placeholder="请输入采购时间"  class="layui-input">
			    </div>
			  </div>
			  <div class="layui-form-item">
			    <label class="layui-form-label">上传视频</label>
			    <div class="layui-input-inline">
			      <input type="file" name="purchase_video" id="purchase_video_upload" lay-type="file" lay-ext="mp4|rmvb|avi|3GP|mov" >
			    </div>
			    <input type="text" class="hide" id="purchase_video_input"/>
			  </div>
			  <div class="layui-form-item">
			   	<label class="layui-form-label">已传视频</label>
			    <div class="layui-input-inline">
					<span id="purchase_video_span" ></span>
			    </div>
			  </div>
			</div>
	    </div>
	    <div class="layui-tab-item layui-show inline" >
	  	 	<div class="layui-form">
	  	 	  <div class="layui-form-item">
			    <label class="layui-form-label" style="width: 100%;text-align: center !important;">检验信息</label>
			  </div>
			  <div class="layui-form-item">
			    <label class="layui-form-label">检验人</label>
			    <div class="layui-input-inline">
			      <%-- <input type="text" id="test_name" placeholder="请输入检验人" value="${sessionScope.user.username }" class="layui-input"> --%>
			      <select name="test_name" id="test_name">
			      	<option value="">--请选择--</option>
			      	<c:forEach var="item" items="${testList}">
			      		<option value="${item.username}">${item.username}</option>
			      	</c:forEach>
			      </select>
			    </div>
			  </div>
			  <div class="layui-form-item">
			    <label class="layui-form-label">检验时间</label>
			    <div class="layui-input-inline">
			      <input type="text" id="test_time" placeholder="请输选择检验时间" readonly="readonly"
			       onclick="layui.laydate({elem: this, istime: true, format: 'YYYY-MM-DD hh:mm:ss'})" class="layui-input">
			    </div>
			  </div>
			  <div class="layui-form-item">
			    <label class="layui-form-label">机器编号</label>
			    <div class="layui-input-inline">
			      <input type="text" id="test_machine" placeholder="请输入机器编号" class="layui-input">
			    </div>
			  </div>
			  <div class="layui-form-item">
			    <label class="layui-form-label">检测结果</label>
			    <div class="layui-input-inline">
			      <input type="text" id="test_result" placeholder="请输入监测结果"  class="layui-input">
			    </div>
			  </div>
			  <div class="layui-form-item">
			    <label class="layui-form-label">结果影响</label>
			    <div class="layui-input-inline">
			      <textarea id="test_influence" placeholder="请输入结果影响" class="layui-textarea"></textarea>
			    </div>
			  </div>
			  <div class="layui-form-item">
			    <label class="layui-form-label">上传视频</label>
			    <div class="layui-input-inline">
			      <input type="file" name="test_video" id="test_video_upload" lay-type="file" lay-ext="mp4|rmvb|avi|3GP|mov" >
			    </div>
			    <input type="text" class="hide" id="test_video_input"/>
			  </div>
			  <div class="layui-form-item">
			   	<label class="layui-form-label">已传视频</label>
			    <div class="layui-input-inline">
					<span id="test_video_span" style="line-height: 38px;"></span>
			    </div>
			  </div>
			</div>
	    </div>
	    <div class="layui-tab-item layui-show inline">
	  	 	<div class="layui-form" >
	  	 	  <div class="layui-form-item">
			    <label class="layui-form-label" style="width: 100%;text-align: center !important;">抽检信息</label>
			  </div>
			  <div class="layui-form-item">
			    <label class="layui-form-label">抽检人</label>
			    <div class="layui-input-inline">
			      <%-- <input type="text" id="test_name2" value="${sessionScope.user.username }" placeholder="请输入抽检人"  class="layui-input"> --%>
			      <select name="test_name2" id="test_name2">
			      	<option value="">--请选择--</option>
			      	<c:forEach var="item" items="${testList}">
			      		<option value="${item.username}">${item.username}</option>
			      	</c:forEach>
			      </select>
			    </div>
			  </div>
			  <div class="layui-form-item">
			    <label class="layui-form-label">抽检时间</label>
			    <div class="layui-input-inline">
			      <input type="text" id="test_time2" readonly="readonly" placeholder="请输选择抽检时间" onclick="layui.laydate({elem: this, istime: true, format: 'YYYY-MM-DD hh:mm:ss'})"  class="layui-input">
			    </div>
			  </div>
			  <div class="layui-form-item">
			    <label class="layui-form-label">机器编号</label>
			    <div class="layui-input-inline">
			      <input type="text" id="test_machine2" placeholder="请输入机器编号"  class="layui-input">
			    </div>
			  </div>
			  <div class="layui-form-item">
			    <label class="layui-form-label">抽检结果</label>
			    <div class="layui-input-inline">
			      <input type="text" id="test_result2" placeholder="请输入抽检结果"  class="layui-input">
			    </div>
			  </div>
			  <div class="layui-form-item">
			    <label class="layui-form-label">结果影响</label>
			    <div class="layui-input-inline">
			      <textarea id="test_influence2" placeholder="请输入结果影响" class="layui-textarea"></textarea>
			    </div>
			  </div>
			  <div class="layui-form-item">
			    <label class="layui-form-label">上传视频</label>
			    <div class="layui-input-inline">
			      <input type="file" name="test_video2" id="test_video_upload2" lay-type="file" lay-ext="mp4|rmvb|avi|3GP|mov" >
			    </div>
			    <input type="text" class="hide" id="test_video_input2"/>
			  </div>
			  <div class="layui-form-item">
			   	<label class="layui-form-label">已传视频</label>
			    <div class="layui-input-inline">
					<span id="test_video_span2" style="line-height: 38px;"></span>
			    </div>
			  </div>
			</div>
	    </div>
	    <div class="layui-tab-item layui-show inline">
	  	 	<div class="layui-form" >
	  	 	  <div class="layui-form-item">
			    <label class="layui-form-label" style="width: 100%;text-align: center !important;">运输信息</label>
			  </div>
			  <div class="layui-form-item">
			    <label class="layui-form-label">运输人</label>
			    <div class="layui-input-inline">
			      <input type="text" id="transport_user" placeholder="请输入运输司机"  class="layui-input">
			    </div>
			  </div>
			  <div class="layui-form-item">
			    <label class="layui-form-label">车辆编号</label>
			    <div class="layui-input-inline">
			      <input type="text" id="transport_truck" placeholder="请输入车辆编号" class="layui-input">
			    </div>
			  </div>
			  <div class="layui-form-item">
			    <label class="layui-form-label">目的地</label>
			    <div class="layui-input-inline">
			      <input type="text" id="transport_destination" placeholder="请输入目的地"  class="layui-input">
			    </div>
			  </div>
			  <div class="layui-form-item">
			    <label class="layui-form-label">上传照片</label>
			    <div class="layui-input-inline">
			      <input type="file" name="transport_pic" id="transport_pic_upload" lay-type="file" lay-ext="png|jpg|jpeg" >
			    </div>
			    <input type="text" class="hide" id="transport_pic_input"/>
			  </div>
			  <div class="layui-form-item">
			   	<label class="layui-form-label">已传图片</label>
			    <div class="layui-input-inline">
					<span id="transport_pic_span" style="display: none;"></span>
					<img  id="transport_pic_img" width="150" height="150" src="" style="display: none;">
			    </div>
			  </div>
			</div>
	    </div>
	    <div class="layui-tab-item layui-show inline">
	  	 	<div class="layui-form" >
	  	 	  <div class="layui-form-item">
			    <label class="layui-form-label" style="width: 100%;text-align: center !important;">
			    二维码&nbsp;&nbsp;&nbsp;<button class="layui-btn layui-btn-mini"  onclick="produceQrcode();">生成</button>&nbsp;
			    <button id="print_btn" class="layui-btn layui-btn-mini layui-btn-disabled" disabled="disabled"  onclick="print();">打印</button></label>
			  </div>
			  <div class="layui-form-item">
			    <div class="layui-input-inline" style="text-align: center;width: 100%;margin: 0 auto;">
			    	<div id="qrcode_div" style="width: 200px;height: 200px;background: #e2e2e2;margin-left: 65px;vertical-align: middle;line-height: 200px;">未生成二维码</div>
			    	<img id="qrcode_img" class="hide" alt="二维码" src="${path }/images/qrcode_logo.png" width="200" height="200">
			    	<input type="text" class="hide" id="qrcode"/>
			    </div>
			  </div>
			</div>
	    </div>
	  </div>
	  <div style="width: 100%;text-align: center;margin: 0 auto;"><button class="layui-btn" id="btn">提交</button></div>
	<!-- </div>  -->
</div>
<script src="${path}/js/jquery.min.js" type="text/javascript"></script>
<script type="text/javascript">
layui.use(['element', 'layer', 'form','laydate'], function(){
  var element = layui.element()
  ,jq = layui.jquery
  ,form = layui.form()
  ,laypage = layui.laypage;

  //图片预览
  jq('.list-table td .thumb').hover(function(){
    jq(this).append('<img class="thumb-show" src="'+jq(this).attr('thumb')+'" >');
  },function(){
    jq(this).find('img').remove();
  });

 
  
  layui.use('upload', function() {
		var index;
		layui.upload({
			elem:'#farmer_video_upload',
			title:'上传',
			url : '${path}/video/uploadVideo.do',
			before: function(input){
				index = layer.msg('视频上传中', {
					  icon: 16
					  ,shade: 0.01
					});
			    //返回的参数item，即为当前的input DOM对象
			    console.log('视频上传中');
			},
			success : function(rs) {
				layer.close(index);
				layer.msg('视频上传成功', {
					  icon: 1,
					  time: 2000 //2秒关闭（如果不配置，默认是3秒）
					}, function(){
					  	
					});
				jq("#farmer_video_span").attr("title",rs.filename);
				jq("#farmer_video_span").html(rs.filename);
				jq("#farmer_video_input").val(rs.name);
			}
			
		});

	});
  layui.use('upload', function() {
		var index;
		layui.upload({
			elem:'#purchase_video_upload',
			title:'上传',
			url : '${path}/video/uploadPurchaseVideo.do',
			before: function(input){
				index = layer.msg('视频上传中', {
					  icon: 16
					  ,shade: 0.01
					});
			    //返回的参数item，即为当前的input DOM对象
			    console.log('视频上传中');
			},
			success : function(rs) {
				layer.close(index);
				layer.msg('视频上传成功', {
					  icon: 1,
					  time: 2000 //2秒关闭（如果不配置，默认是3秒）
					}, function(){
					  	
					});
				jq("#purchase_video_span").html(rs.filename);
				jq("#purchase_video_span").attr("title",rs.filename);
				jq("#purchase_video_input").val(rs.name);
			}
			
		});

	});
  layui.use('upload', function() {
		var index;
		layui.upload({
			elem:'#test_video_upload',
			title:'上传',
			url : '${path}/video/uploadTestVideo.do',
			before: function(input){
				index = layer.msg('视频上传中', {
					  icon: 16
					  ,shade: 0.01
					});
			    //返回的参数item，即为当前的input DOM对象
			    console.log('视频上传中');
			},
			success : function(rs) {
				layer.close(index);
				layer.msg('视频上传成功', {
					  icon: 1,
					  time: 2000 //2秒关闭（如果不配置，默认是3秒）
					}, function(){
					  	
					});
				jq("#test_video_span").html(rs.filename);
				jq("#test_video_span").attr("title",rs.filename);
				jq("#test_video_input").val(rs.name);
			}
			
		});

	});
  layui.use('upload', function() {
		var index;
		layui.upload({
			elem:'#test_video_upload2',
			title:'上传',
			url : '${path}/video/uploadTestVideo.do',
			before: function(input){
				index = layer.msg('视频上传中', {
					  icon: 16
					  ,shade: 0.01
					});
			    //返回的参数item，即为当前的input DOM对象
			    console.log('视频上传中');
			},
			success : function(rs) {
				layer.close(index);
				layer.msg('视频上传成功', {
					  icon: 1,
					  time: 2000 //2秒关闭（如果不配置，默认是3秒）
					}, function(){
					  	
					});
				jq("#test_video_span2").html(rs.filename);
				jq("#test_video_span2").attr("title",rs.filename);
				jq("#test_video_input2").val(rs.name);
			}
			
		});

	});
  layui.use('upload', function() {
		var index;
		layui.upload({
			elem:'#transport_pic_upload',
			title:'上传',
			url : '${path}/video/uploadTransportPic.do',
			before: function(input){
				index = layer.msg('图片上传中', {
					  icon: 16
					  ,shade: 0.01
					});
			    //返回的参数item，即为当前的input DOM对象
			    console.log('图片上传中');
			},
			success : function(rs) {
				layer.close(index);
				layer.msg('图片上传成功', {
					  icon: 1,
					  time: 2000 //2秒关闭（如果不配置，默认是3秒）
					}, function(){
					  	
					});
				jq("#transport_pic_span").html(rs.filename);
				jq("#transport_pic_span").attr("title",rs.filename);
				jq("#transport_pic_input").val(rs.name);
				jq("#transport_pic_img").attr("src",'${path}/uploadPic/'+rs.name).show();
			}
			
		});

	});
  
})

function produceQrcode(){
	$.ajax({
		  url:'${path}/qrcode/produce.do',
		  type:'post',
		  dataType:'json',
		  data:{'trace_id':''},
		  success:function(rs){
			  rs = eval("(" + rs + ")");
			  if(rs.code=="200"){
				  $("#qrcode_div").hide();//css("backgroud-image","url("+rs.path+")");
				  $("#qrcode_img").removeClass("hide").attr("src",'${path}/qrcode/'+rs.name+".jpg");
				  $("#qrcode").val(rs.name+".jpg");
				  $("#trace_id").val(rs.trace_id);
				  $("#print_btn").attr("disabled",true).addClass("layui-btn-disabled");
			  }else{
				  layer.msg("生成失败！");
			  }
		  }
	  }) 
}
$(document).on('click','#btn',function(){
	  var farmer_name = $("#farmer_name").val();
	  if(""==farmer_name||null==farmer_name){
		  layer.msg("请填写姓名！",{time:1000},function(){
			  $("#farmer_name").focus();
		  });
			  return;
	  }
	  var farmer_phone = $("#farmer_phone").val();
	  if(""==farmer_phone||null==farmer_phone){
		  layer.msg("请填写手机号！",{time:1000},function(){
			  $("#farmer_phone").focus();
		  });
			  return;
	  }else if(!isTelephone(farmer_phone)){
		  layer.msg("手机号不合法！",{time:1000},function(){
			  $("#farmer_phone").focus().val("");
		  });
			  return;
	  }
	  var farmer_hzs = $("#farmer_hzs").val();
	  var purchase_name = $("#purchase_name").val();
	  if(""==purchase_name||null==purchase_name){
		  layer.msg("请填写采购人！",{time:1000},function(){
			  $("#purchase_name").focus();
		  });
			  return;
	  }
	  var purchase_type = $("#purchase_type").val();
	  if(""==purchase_type||null==purchase_type){
		  layer.msg("请填写蔬菜名称！",{time:1000},function(){
			  $("#purchase_type").focus();
		  });
			  return;
	  }
	  var purchase_num = $("#purchase_num").val();
	  if(""==purchase_num||null==purchase_num){
		  layer.msg("请填写采购数量！",{time:1000},function(){
			  $("#purchase_num").focus();
		  });
			  return;
	  }
	  var purchase_time = $("#purchase_time").val();
	  if(""==purchase_time||null==purchase_time){
		  layer.msg("请填写采购时间！",{time:1000},function(){
			  $("#purchase_time").focus();
		  });
			  return;
	  }
	  var test_name = $("#test_name").val();
	  var test_name2 = $("#test_name2").val();
	  if(""==test_name){
		  layer.msg("请填写检验人！",{time:1000},function(){
			  $("#test_name").focus();
		  });
			  return;
	  }
	  var test_time = $("#test_time").val();
	  var test_time2 = $("#test_time2").val();
	  if(""==test_time||null==test_time){
		  layer.msg("请填写检验时间！",function(){
			  $("#test_time").focus();
		  });
			  return;
	  }
	  var test_machine = $("#test_machine").val();
	  var test_machine2 = $("#test_machine2").val();
	  if(""==test_machine||null==test_machine){
		  layer.msg("请填写机器编号！",{time:1000},function(){
			  $("#test_machine").focus();
		  });
			  return;
	  }
	  var test_result = $("#test_result").val();
	  var test_result2 = $("#test_result2").val();
	  var test_influence = $("#test_influence").val();
	  var test_influence2 = $("#test_influence2").val();
	  if(""==test_result||null==test_result){
		  layer.msg("请填写检验结果！",{time:1000},function(){
			  $("#test_result").focus();
		  });
		  return false;
	  }
	  var transport_user = $("#transport_user").val();
	  if(""==transport_user||null==transport_user){
		  layer.msg("请填写运输人！",{time:1000},function(){
			  $("#transport_user").focus();
		  });
			  return;
	  }
	  var transport_truck = $("#transport_truck").val();
	  if(""==transport_truck){
		  layer.msg("请填写车辆编号！",{time:1000},function(){
			  $("#transport_truck").focus();
		  });
			  return ;
	  }
	  var transport_destination = $("#transport_destination").val();
	  if(""==transport_destination||null==transport_destination){
		  layer.msg("请填写目的地！",{time:1000},function(){
			  $("#transport_destination").focus();
		  });
			  return;
	  }
	  if(""==$('#qrcode').val()||null==$('#qrcode').val()){
		  layer.msg("请重新生成二维码！");
			  return;
	  }
	  var farmer_video = $("#farmer_video_input").val();
	  var purchase_video = $("#purchase_video_input").val();
	  var trace_id = "";
	  $.ajax({
		  url:'${path}/trace/farmerAdd.do',
		  type:'post',
		  async: false,
		  dataType:'json',
		  data:{'trace_id':$("#trace_id").val(),'farmer_name':farmer_name,'farmer_phone':farmer_phone,'farmer_video':farmer_video,'farmer_hzs':farmer_hzs},
		  success:function(rs){
			  rs = eval("(" + rs + ")");
			  if(rs.code=="200"){
				  trace_id = rs.trace_id;
				  $.ajax({
					  url:'${path}/trace/purchaseAdd.do', //购买
					  type:'post',
					  async: false,
					  dataType:'json',
					  data:{'trace_id':trace_id,
						  'purchase_name':purchase_name,
						  'purchase_type':purchase_type,
						  'purchase_num':purchase_num,
						  'purchase_time':purchase_time,
						  'purchase_video':purchase_video},
					  success:function(rs){
						  rs = eval("(" + rs + ")");
						  if(rs.code=="200"){ //检验
							  $.ajax({
								  url:'${path}/trace/testAdd.do',
								  type:'post',
								  async: false,
								  dataType:'json',
								  data:{'trace_id':trace_id,'test_name':test_name,'test_time':test_time,'test_machine':test_machine,
									  'test_result':test_result,'test_influence':test_influence,'test_video':$("#test_video_input").val()},
								  success:function(rs){
									  rs = eval("(" + rs + ")");
									  if(rs.code=="200"){ //运输
										  $.ajax({
											  url:'${path}/trace/transportAdd.do',
											  type:'post',
											  async: false,
											  dataType:'json',
											  data:{'trace_id':trace_id,'transport_user':transport_user,
												  'transport_truck':transport_truck,'transport_destination':transport_destination,'transport_pic':$("#transport_pic_input").val()},
											  success:function(rs){
												  rs = eval("(" + rs + ")");
												  if(rs.code=="200"){
													  $.ajax({
														  url:'${path}/trace/samplingAdd.do',
														  type:'post',
														  async: false,
														  dataType:'json',
														  data:{'trace_id':trace_id,'test_name':test_name2,'test_time':test_time2,'test_machine':test_machine2,
															  'test_result':test_result2,'test_influence':test_influence2,'test_video':$("#test_video_input2").val()},
														  success:function(rs){
															  rs = eval("(" + rs + ")");
															  if(rs.code=="200"){
																 /*  layer.msg("提交成功！",function(){
																	  
																  }); */
															  }else{
															  }
														  }
													  }) 
													  $.ajax({
														  url:'${path}/trace/qrcodeAdd.do', //二维码
														  type:'post',
														  async: false,
														  dataType:'json',
														  data:{'trace_id':trace_id,'qrcode_path':$('#qrcode').val()},
														  success:function(rs){
															  rs = eval("(" + rs + ")");
															  if(rs.code=="200"){
																  $('#qrcode').val("");
																  $("#print_btn").removeClass("layui-btn-disabled").attr("disabled",false);
																  //$("#qrcode_div").show();
																  //$("#qrcode_img").addClass("hide");
																  layer.msg("提交成功！",{time:1000},function(){
																	  
																  }); 
															  }else{
																  layer.msg("提交失败！",{time:1000}); 
															  }
														  }
													  }) 
												  }else{
													  layer.msg("提交失败！",{time:1000});
												  }
											  }
										  })
									  }else{
										  layer.msg("提交失败！",{time:1000});
									  }
								  }
							  }) 
						  }
					  }
				  }) 
			  }else{
				  layer.msg("提交失败！",{time:1000});
			  }
		  }
	  }) 
	  
	  
	   
	  
})

function print(){
	var trace_id = $("#trace_id").val();
	if(""==trace_id){
		layer.msg("请先生成二维码");
		return;
	}else{
		
		layer.open({
			  type: 2,
			  title: "打印",
			  area: ['250px', '260px'],
			  shade: 0.8,
			  closeBtn: 1,
			  shadeClose: true,
			  content: '${path}/trace/print.do?trace_id='+trace_id
			});
	}
}

 function checkMobile(s){  
	    var length = s.length;  
	    if(length == 11 && /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1})|(14[0-9]{1})|)+\d{8})$/.test(s) )  
	    {  
	        return true;  
	    }else{  
	        return false;  
	    }  
	}  
</script>
</body>
</html>