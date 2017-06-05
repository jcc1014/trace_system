<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
    <title>${sysname}</title>
   <link rel="stylesheet" href="${path}/layui/css/layui.css">
    <link rel="stylesheet" href="${path}/res/global.css">
    <script type="text/javascript" src="${path}/layui/layui.js"></script>
    <script type="text/javascript" src="${path}/js/commonUtil.js"></script>
    <style type="text/css">
    	.layui-upload-button{position: relative;}
    	.layui-tab-item{display: inline-block !important;}
    </style>
</head>
<body>
<div class="layui-tab layui-tab-brief main-tab-container" style="margin-top: 20px;">
    <ul class="layui-tab-title main-tab-title">
      <div class="main-tab-item">抽检信息</div>
    </ul>
    <div class="layui-tab-content" style="margin-top: 40px;margin-left: 200px;">
			<form class="layui-form">
				<div class="layui-tab-item layui-show">
					<input type="hidden" id="test_id" name="test_id" value="${sampling.test_id}">
					<div class="layui-form-item">
						<label class="layui-form-label">抽检人</label>
						<div class="layui-input-inline">
							<select name="test_name" id="test_name">
								<option value="">--请选择--</option>
								<c:forEach var="item" items="${testList}">
									<option value="${item.username}"
										<c:if test="${item.username eq sampling.test_name }">selected="selected"</c:if>>${item.username}</option>
								</c:forEach>
							</select>
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">抽检时间</label>
						<div class="layui-input-inline">
							<input type="text" id="test_time" readonly="readonly"
								placeholder="请输选择抽检时间"
								onclick="layui.laydate({elem: this, istime: true, format: 'YYYY-MM-DD hh:mm:ss'})"
								class="layui-input" value="${sampling.test_time }"
								name="test_time">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">机器编号</label>
						<div class="layui-input-inline">
							<input type="text" id="test_machine" placeholder="请输入机器编号"
								class="layui-input" value="${sampling.test_machine }"
								name="test_machine">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">抽检结果</label>
						<div class="layui-input-inline">
							<input type="text" id="test_result" placeholder="请输入抽检结果"
								class="layui-input" value="${sampling.test_result }"
								name="test_result">
						</div>
					</div>
					
				</div>
				<div class="layui-tab-item layui-show">
					<div class="layui-form-item">
						<label class="layui-form-label">上传视频</label>
						<div class="layui-input-inline">
							<input type="file" name="test_video" id="test_video_upload"
								lay-type="file" lay-ext="mp4|rmvb|avi|3GP|mov">
						</div>
						<input type="text" class="hide" id="test_video_input" />
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">已传视频</label>
						<div class="layui-input-inline">
							<span id="test_video_span" style="line-height: 38px;">${sampling.test_video}</span>
							<c:if test="${sampling.test_video ne '' && sampling.test_video != null }">
								<button type="button" onclick="watchVideo('${sampling.test_video}');" class="layui-btn layui-btn-mini layui-btn-primary">查看</button>
							</c:if>
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">结果影响</label>
						<div class="layui-input-inline">
							<textarea id="test_influence" placeholder="请输入结果影响"
								class="layui-textarea"
								name="test_influence">${sampling.test_influence }</textarea>
						</div>
					</div>
				</div>
				<div class="layui-form-item" style="margin-top: 50px;">
						<div class="layui-input-block">
							<button type="button" class="layui-btn" id="save">保存</button>
							<button type="button" class="layui-btn layui-btn-primary"
								id="back">返回</button>
						</div>
				</div>
			</form>
		</div>
</div>
<script type="text/javascript">
	layui.use(
		[ 'element', 'form', 'upload', 'layedit', 'laydate' ],function() {
		var element = layui.element(), 
		form = layui.form(), 
		layedit = layui.layedit, 
		laydate = layui.laydate, 
		jq = layui.jquery;

	jq("#save").on('click', function() {
		var test_id = jq("#test_id").val();
		var test_name = jq("#test_name").val();
		var test_time = jq("#test_time").val();
		var test_machine = jq("#test_machine").val();
		var test_result = jq("#test_result").val();
		var test_influence = jq("#test_influence").val();
		var test_video = jq("#test_video_input").val();
		
		jq.ajax({
			  url:'${path}/trace/samplingSave.do',
			  type:'post',
			  async: false,
			  dataType:'json',
			  data:{'test_id':test_id,'test_name':test_name,'test_time':test_time,'test_machine':test_machine,
				  'test_result':test_result,'test_influence':test_influence,'test_video':test_video},
			  success:function(rs){
				  rs = eval("(" + rs + ")");
				  if(rs.code=="200"){
					  layer.msg("修改成功！",{time:1000},function(){
						  var url = "${path}/trace/list.do";
							window.location.href = url;
					  }); 
				  }else{
					  layer.msg("修改失败！",{time:1000},function(){
						  var url = "${path}/trace/list.do";
							window.location.href = url;
					  }); 
				  }
			  }
		  }) 
	})
	jq("#back").on('click', function() {
		var url = "${path}/trace/list.do";
		window.location.href = url;
	})
	
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
})	
function watchVideo(path){
		layer.open({
			  type: 2,
			  title: "查看视频",
			  area: ['400px', '350px'],
			  shade: 0,
			  closeBtn: 1,
			  shadeClose: true,
			  content: '${path}/video/watchVideo.do?path='+path
			});
	}
</script>
</body>
</html>