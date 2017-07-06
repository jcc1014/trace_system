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
			<form class="layui-form" method="post" action="${path}/transport/addTransportSave.do" id="form">
				<div class="layui-tab-item layui-show">
					<input type="hidden" id="trace_id" name="trace_id" value="${trace_id }">
					<div class="layui-form-item">
						<label class="layui-form-label">运输员</label>
						<div class="layui-input-inline input-custom-width">
							<input type="text" id="transport_user" name="transport_user"
								class="layui-input" >
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">运输车辆</label>
						<div class="layui-input-inline input-custom-width">
							<input type="text" id="transport_truck" name="transport_truck" 
								class="layui-input" >
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">目的地</label>
						<div class="layui-input-inline input-custom-width">
							<textarea id="transport_destination" name="transport_destination" style="resize:none;" class="layui-textarea"></textarea>
						</div>
					</div>
					<div class="layui-form-item">
                        <label class="layui-form-label">上传图片</label>
                        <div class="layui-input-inline" style="width:113px;">
						    <input type="file" name="file" id="upload" class="layui-upload-file">
                        </div>
					</div>
					<div class="layui-form-item" id="pic_display" style="display: none">
                            <label class="layui-form-label">已传图片</label>
                   </div>
					<div class="layui-form-item" id="pic_display">
						<label class="layui-form-label">已传图片</label>
						<div id="picDiv" class="layui-input-block">
							<input type="hidden" id="transport_pic" name="transport_pic" value="">
							<input type="hidden" id="real_path" name="real_path" value="">
							<img class="input-custom-width" src="" id="picImg"/> <a
								style="margin-left: 10px"
								class="layui-btn layui-btn-small layui-btn-danger del_btn hide"
								 title="删除"> <i class="layui-icon"></i>
							</a>
							<div style="min-height: 10px"></div>
						</div>
					</div>

					<div class="layui-form-item" style="margin-top: 50px;">
						<div class="layui-input-block">
							<button type="button" class="layui-btn" id="save">保存</button>
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
            title:'上传图片',
            url : '${path}/upload/upload.do?path=transportPic',
            before: function(){
                index = layer.msg('上传中', {
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
                    	$("#transport_pic").val(rs.name);
                    	$("#real_path").val(rs.path);
                    	$("#picImg").attr('src','${path}/transportPic/'+rs.name);
                    	$(".del_btn").removeClass('hide');
                    });
                   
                } else {
                    layer.msg('上传失败' + rs.msg + ',请检查图片名称是否合法或重试', {
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
							$("#transport_pic").val("");
							$("#real_path").val("");
							$("#picImg").attr('src','');
							$('.del_btn').addClass('hide');
						})
					}
				}
			}
		})
	})
		
	
	jq("#save").on('click',function(){
		var transport_user = jq("#transport_user").val();
		var transport_truck = jq("#transport_truck").val();
		var transport_destination = jq("#transport_destination").val();
		var transport_pic = jq("#transport_pic").val();
		if(transport_user==null || transport_user=="" || transport_user==undefined){
			 layer.msg('请输入运输员',{time:1000});
			 return;
		}
		if(transport_truck==null || transport_truck=="" || transport_truck==undefined){
			 layer.msg('请输入运输车辆',{time:1000});
			 return;
		}
		if(transport_destination==null || transport_destination=="" || transport_destination==undefined){
			 layer.msg('请输入运输目的地',{time:1000});
			 return;
		}
		if(transport_pic==null || transport_pic=="" || transport_pic==undefined){
			 layer.msg('请上传照片',{time:1000});
			 return;
		}
		$("#form").submit();
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
