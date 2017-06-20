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
</head>
<body>
<div class="layui-tab layui-tab-brief main-tab-container" style="margin-top: 20px;">
    <ul class="layui-tab-title main-tab-title">
      <div class="main-tab-item">商品信息</div>
    </ul>
    <div class="layui-tab-content" style="margin-top: 40px;margin-left: 200px;">
			<form class="layui-form" action="">
				<div class="layui-tab-item layui-show">
					<input type="hidden" name="goods_id" value="${goods.goods_id}">
					<div class="layui-form-item">
						<label class="layui-form-label">商品名称</label>
						<div class="layui-input-inline input-custom-width">
							<input value="${goods.goods_name}" type="text" required lay-verify="required" id="goods_name" name="goods_name" autocomplete="off" placeholder="请输入商品名称" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">商品类型</label>
						<div class="layui-input-inline input-custom-width">
							<select name="goods_type" id="goods_type" required lay-verify="required">
								<option value="">--选择--</option>
								<c:forEach items="${types}" var="type">
                                    <c:if test="${goods.goods_type eq type.dict_id}">
                                        <option value="${type.dict_id}" selected="selected">${type.dict_name}</option>
                                    </c:if>
                                    <c:if test="${goods.goods_type ne type.dict_id}">
                                        <option value="${type.dict_id}">${type.dict_name}</option>
                                    </c:if>
								</c:forEach>
							</select>
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">商品描述</label>
						<div class="layui-input-inline input-custom-width">
							<textarea required lay-verify="required" name="goods_description" placeholder="请输入商品描述" class="layui-textarea">${goods.goods_description}</textarea>
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">最新价格(元)</label>
						<div class="layui-input-inline input-custom-width">
							<input value="${goods.new_price}" required lay-verify="required" type="text" id="new_price" name="new_price" autocomplete="off" placeholder="请输入最新价格" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">原始价格(元)</label>
						<div class="layui-input-inline input-custom-width">
							<input value="${goods.old_price}" type="text" id="old_price" name="old_price" autocomplete="off" placeholder="请输入原始价格" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
                        <label class="layui-form-label">上传图片</label>
                        <div class="layui-input-inline" style="width:113px;">
						    <input type="file" name="file" id="upload" class="layui-upload-file">
                        </div>
					</div>
                    <c:if test="${empty pics}">
                        <div class="layui-form-item" id="pic_display" style="display: none">
                            <label class="layui-form-label">已传图片</label>
                        </div>
                    </c:if>
                    <c:if test="${!empty pics}">
                        <div class="layui-form-item" id="pic_display">
                            <label class="layui-form-label">已传图片</label>
                            <c:forEach items="${pics}" var="pic" varStatus="status">
                                <div id="pic${status.index + 1}" class="layui-input-block">
                                    <input type="hidden" name="goods_pic" value="${pic.pic_path}">
                                    <input type="hidden" name="real_path" value="${pic.real_path}">
                                    <img class="input-custom-width" src="${pic.pic_path}" />
                                    <a style="margin-left:10px" class="layui-btn layui-btn-small layui-btn-danger del_btn" data-div="pic${status.index + 1}" data-realPath="${pic.real_path}" title="删除">
                                        <i class="layui-icon"></i>
                                    </a>
                                    <div style="min-height: 10px"></div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:if>
					<div class="layui-form-item" style="margin-top: 50px;">
						<div class="layui-input-block">
							<button type="button" class="layui-btn" lay-filter="save" lay-submit>保存</button>
							<button type="button" class="layui-btn layui-btn-primary" id="back">返回</button>
						</div>
					</div>
				</div>
                <input type="hidden" name="del_pic_path" id="del_pic_path" value=""/>
			</form>
		</div>
</div>
<script type="text/javascript">
    layui.use([ 'element', 'form', 'upload', 'layedit', 'laydate' ],function() {
		var element = layui.element(),
		form = layui.form(),
		layedit = layui.layedit,
		laydate = layui.laydate,
		jq = layui.jquery;

        jq('.del_btn').click(function(){
            var realPath = jq(this).data('realPath') || jq(this).attr("data-realPath");
            var div_id = jq(this).data('div') || jq(this).attr('data-div');
            layer.confirm('确定删除?', function(index){
                var del_pic_path = jq('#del_pic_path').val();
                jq('#del_pic_path').val(del_pic_path ? del_pic_path + "," + realPath : realPath);
                jq('#' + div_id).remove();
                if (jq('.del_btn').length == 0) {
                    jq('#pic_display').hide();
                }
                layer.close(index);
            });
        });

		var pic_index = 0;
        layui.upload({
            elem:'#upload',
            title:'点击上传',
            url : '${path}/goods/uploadPic.do',
            before: function(){
                index = layer.msg('图片上传中', {
                    icon: 16
                    ,shade: 0.01
                });
            },
            success : function(rs) {
                layer.close(index);
                if (rs.code == 200) {
                    pic_index ++;
                    layer.msg('图片上传' + rs.msg + ',点击上传按钮继续上传', {
                        icon: 1,
                        time: 2000 //2秒关闭（默认3秒）
                    }, function(){});
                    var html = '';
                    html += '<div id="pic' + pic_index + '_new" class="layui-input-block">';
                    html += '<input type="hidden" name="goods_pic" value="' + rs.data.src + '">';
                    html += '<input type="hidden" name="real_path" value="' + rs.data.realPath + '">';
                    html += '<img class="input-custom-width" src="' + rs.data.src + '" />';
                    html += '<a id="btn' + pic_index + '_new" style="margin-left:10px" class="layui-btn layui-btn-small layui-btn-danger del_btn" data-div="pic' + pic_index + '_new" data-realPath="' + rs.data.realPath + '" title="删除"><i class="layui-icon"></i></a>';
                    html += '<div style="min-height: 10px"></div></div>';
                    jq('#pic_display').append(html);
                    jq('#pic_display').show();
                    jq('#btn' + pic_index + '_new').click(function(){
                        var realPath = jq(this).data('realPath') || jq(this).attr("data-realPath");
                        var div_id = jq(this).data('div') || jq(this).attr('data-div');
                        layer.confirm('确定删除?', function(index){
                            var del_pic_path = jq('#del_pic_path').val();
                            jq('#del_pic_path').val(del_pic_path ? del_pic_path + "," + realPath : realPath);
                            jq('#' + div_id).remove();
                            if (jq('.del_btn').length == 0) {
                                jq('#pic_display').hide();
                            }
                            layer.close(index);
                        });
                    });
                } else {
                    layer.msg('图片上传' + rs.msg + ',请检查图片或重试', {
                        icon: 2,
                        time: 2000 //2秒关闭（默认3秒）
                    }, function(){});
                }
            }
        });

		//监听提交  
        form.on('submit(save)', function(data){
            if (data.field.goods_pic) {
                var goods_pics = '';
                jq('input[name=goods_pic]').each(function(){
                    goods_pics += jq(this).val() + ',';
                });
                data.field.goods_pic = goods_pics.substring(0, goods_pics.length - 1);
                var real_path = '';
                jq('input[name=real_path]').each(function(){
                    real_path += jq(this).val() + ',';
                });
                data.field.real_path = real_path.substring(0, real_path.length - 1);
            } else {
                layer.msg("必须上传图片",function(){});
                return;
			}
            jq.ajax({
                url : '${path}/goods/save.do',
                type: 'post',
                data: data.field,
                dataType : 'json',
                success : function(rs) {
                    layer.msg("保存" + rs.msg,{time:1000}, function() {
                        if (rs.code == 200) {
                            var url = "${path}/goods/list.do";
                            window.location.href = url;
                        }
                    });
                }
            })
        });
		jq("#back").on('click', function() {
			var url = "${path}/goods/list.do";
			window.location.href = url;
		})
	})
</script>
</body>
</html>