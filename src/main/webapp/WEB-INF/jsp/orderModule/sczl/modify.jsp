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
    <style type="text/css">
    .layui-disabled, .layui-disabled:hover {color: #222!important;border-color: #D2D2D2!important;}
    </style>
  </head>
 <body>
 <div class="layui-tab layui-tab-brief main-tab-container" style="margin-top: 20px;">
  	<ul class="layui-tab-title main-tab-title">
      <div class="main-tab-item">修改蔬菜分类</div>
    </ul>
    
    <div class="layui-tab-content" style="margin-top: 40px;margin-left: 200px;">
			<form class="layui-form">
				<div class="layui-tab-item layui-show">
					<input type="hidden" name="id" id="id" value="${sczl.id }">
					<div class="layui-form-item">
						<label class="layui-form-label">种类</label>
						<div class="layui-input-inline input-custom-width">
							<select name="kind" id="kind" disabled="disabled">
								<option value=""></option>
				            	<c:forEach var="item" items="${goodsList}">
					            	<option value="${item.goods_name }"
					            	<c:if test="${item.goods_name eq sczl.kind }">selected="selected"</c:if> 
					            	>${item.goods_name }</option>
				            	</c:forEach>
							</select>
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">等级</label>
						<div class="layui-input-inline input-custom-width">
							<select name="grade" id="grade" disabled="disabled">
								<option value="${sczl.grade }" selected="selected">${sczl.grade }</option>
							</select>
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">三品一标</label>
						<div class="layui-input-inline input-custom-width">
							<select name="spyb" id="spyb" disabled="disabled">
								<option value=""></option>
				            	<c:forEach var="item" items="${dictList}">
					            	<option value="${item.dict_name }"
					            	<c:if test="${item.dict_name eq sczl.spyb }">selected="selected"</c:if> 
					            	>${item.dict_name }</option>
				            	</c:forEach>
							</select>
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">描述</label>
						<div class="layui-input-inline input-custom-width">
							<textarea  id="content" name="content" rows="10" style="height: 130px;"
								  placeholder="请输入标准描述"
								class="layui-input"></textarea>
						</div>
					</div>

					<div class="layui-form-item" style="margin-top: 50px;">
						<div class="layui-input-block">
							<button type="button" class="layui-btn" id="save_btn">保存</button>
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
            url : '${path}/upload/upload.do?path=video',
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
                    	$("#video").val(rs.name);
                    	$("#real_path").val(rs.path);
                    	$("#videoSpan").html(rs.name);
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
							$("#video").val("");
							$("#real_path").val("");
							$("#videoSpan").html('');
							$('.del_btn').addClass('hide');
						})
					}
				}
			}
		})
	})
		
	jq("#save_btn").on('click',function(){
		var id = jq("#id").val();
		var content = jq("#content").val();
		if(content==null || content=="" || content==undefined){
			 layer.msg('请填写描述',{time:1000});
			 return;
		}
		jq.ajax({
			url : '${path}/sczl/modifySave.do',
			type : 'post',
			data:{'id':id,'content':content},
			dataType : 'json',
			success : function(rs) {
				rs = eval("(" + rs + ")");
				if("200"==rs.code){
					layer.msg("修改成功！",{time:1000}, function() {
						window.location.href = "${path}/sczl/list.do";
					});
				}
				else{
					layer.msg("修改失败！",{time:1000}, function() {
						window.location.href = "${path}/sczl/list.do";
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
	window.location.href = "${path}/sczl/list.do";
}

</script>
</body>
</html>
