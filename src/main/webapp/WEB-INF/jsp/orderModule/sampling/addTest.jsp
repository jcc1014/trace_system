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
    <script type="text/javascript" src="${path}/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${path}/js/citypicker/city-picker.data.js"></script>
    <script type="text/javascript" src="${path}/js/citypicker/city-picker.js"></script>
    <!-- 百度地图api 秘钥=DD279b2a90afdf0ae7a3796787a0742e -->
    <script src="http://api.map.baidu.com/api?v=2.0&ak=DD279b2a90afdf0ae7a3796787a0742e" type="text/javascript"></script>
  </head>
 <body>
 <div class="layui-tab layui-tab-brief main-tab-container" style="margin-top: 20px;">
  	<ul class="layui-tab-title main-tab-title">
      <div class="main-tab-item">检验信息</div>
    </ul>
    
    <div class="layui-tab-content" style="margin-top: 40px;margin-left: 100px;">
			<form class="layui-form">
				<div class="layui-tab-item layui-show">
					<input type="hidden" id="test_id" value="${test.test_id }">
					<div class="layui-form-item">
						<label class="layui-form-label">样品编号</label>
						<div class="layui-input-inline input-custom-width">
							<input type="text" id="test_bh" 
								class="layui-input" value="${test.test_bh }" readonly="readonly">
						</div>
						<label class="layui-form-label">样品种类</label>
						<div class="layui-input-inline input-custom-width">
							<input type="text" id="test_kind" value="${test.test_kind }"
								class="layui-input" readonly="readonly">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">样品品级</label>
						<div class="layui-input-inline input-custom-width">
							<input type="text" id="test_grade" value="${test.test_grade }"
								class="layui-input" readonly="readonly">
						</div>
						<label class="layui-form-label">检验人</label>
						<div class="layui-input-inline input-custom-width">
							<input type="text" id="test_user" value="${sessionScope.user.username }" name="test_user"
								class="layui-input" readonly="readonly">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">检验结果</label>
						<div class="layui-input-inline input-custom-width">
							<%-- <input type="text" id="test_result" value="${test.test_result }" name="test_result"
								class="layui-input"> --%>
							 <select id="test_result" name="test_result" class="layui-input">
								<option value="">--选择--</option>
								<option value="1">合格</option>
								<option value="2">不合格</option>
							</select>
						</div>
						<label class="layui-form-label">检验机器</label>
						<div class="layui-input-inline input-custom-width">
							<input type="text" id="test_machine" name="test_machine"
								class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">结果影响</label>
						<div class="layui-input-inline input-custom-width">
							<textarea id="test_influence" name="test_influence" style="resize:none;" placeholder="请输入检验结果" class="layui-textarea"></textarea>
						</div>
					</div>
					<div class="layui-form-item">
                        <label class="layui-form-label">上传视频</label>
                        <div class="layui-input-inline" style="width:113px;">
						    <input type="file" name="file" id="upload" lay-type="video" class="layui-upload-file">
                        </div>
					</div>
					<div class="layui-form-item" id="pic_display">
						<label class="layui-form-label">已传视频</label>
						<div id="picDiv" class="layui-input-block">
							<input type="hidden" id="test_video" name="test_video" value="">
							<input type="hidden" id="real_path" name="real_path" value="">
							<span id="video"></span>
							 <a style="margin-left: 10px"
								class="layui-btn layui-btn-small layui-btn-danger del_btn hide"
								 title="删除"> <i class="layui-icon"></i>
							</a>
							<div style="min-height: 10px"></div>
						</div>
					</div>

					<div class="layui-form-item" style="margin-top: 50px;">
						<div class="layui-input-block">
							<button type="button" class="layui-btn" id="test_save">保存</button>
							<button type="button" class="layui-btn layui-btn-primary" onclick="back();">返回</button>
						</div>
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
	
		layui.upload({
            elem:'#upload',
            title:'上传视频',
            url : '${path}/upload/upload.do?path=testVideo',
            before: function(){
                index = layer.msg('视频上传中', {
                    icon: 16
                    ,shade: 0.01
                });
            },
            success : function(rs) {
                layer.close(index);
                if (rs.code == "success") {
                    layer.msg('上传成功', {
                        icon: 1,
                        time: 2000 //2秒关闭（默认3秒）
                    }, function(){
                    	$("#test_video").val(rs.name);
                    	$("#real_path").val(rs.path);
                    	$("#video").html(rs.name);
                    	$(".del_btn").removeClass('hide');
                    });
                   
                } else {
                    layer.msg('上传失败' + rs.msg + ',请检查视频名称是否有中文或重试', {
                        icon: 2,
                        time: 2000 //2秒关闭（默认3秒）
                    }, function(){});
                }
            }
        });
		
	jq(".del_btn").on('click',function(){
		var path = $('#real_path').val();
		jq.ajax({
			url:'${path}/upload/delUpload.do',
			type:'post',
			data:{'path':path},
			success:function(rs){
				if(""!=rs){
					rs = jq.parseJSON(rs);
					if(typeof(rs)!='object'){
						rs = jq.parseJSON(rs);
					}
					if(rs.code=="200"){
						layer.msg('删除成功！',{time:1000},function(){
							$("#test_video").val("");
							$("#real_path").val("");
							$("#video").html('');
							$('.del_btn').addClass('hide');
						})
					}
				}
			}
		})
	})
		
	
	jq("#test_save").on('click',function(){
		var test_result = jq("#test_result").val();
		var test_machine = jq("#test_machine").val();
		var test_influence = jq("#test_influence").val();
		var test_video = jq("#test_video").val();
		if(test_result==null || test_result=="" || test_result==undefined){
			 layer.msg('请输入检验结果',{time:1000});
			 return;
		}
		if(test_machine==null || test_machine=="" || test_machine==undefined){
			 layer.msg('请输入检验机器',{time:1000});
			 return;
		}
		jq.ajax({
			url : '${path}/sampling/testSave.do',
			type : 'post',
			data:{'test_id':$("#test_id").val(),'test_result':test_result,'test_machine':test_machine,'test_influence':test_influence,
				'test_video':test_video},
			dataType : 'json',
			success : function(rs) {
				rs = eval("(" + rs + ")");
				if("200"==rs.code){
					layer.msg("保存成功",{time:1000}, function() {
						window.location.href = "${path}/sampling/testList.do";
					});
				}else{
					layer.msg("保存失败",{time:1000}, function() {
						window.location.href = "${path}/sampling/testList.do";
					});
				}
			}
		})
	});
})

function closeLayer(){
	layer.closeAll();
}

function back(){
	window.location.href = "${path}/sampling/testList.do";
}

</script>
</body>
</html>
