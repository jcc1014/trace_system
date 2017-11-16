<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../common/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>新增采购</title>
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="apple-mobile-web-app-status-bar-style" content="black"> 
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="format-detection" content="telephone=no">
	<link href="${path}/css/bootstrap.css" rel="stylesheet" media="screen">
	<link rel="stylesheet" href="${path}/layui/css/layui.css">
	<script src="${path}/js/jquery-2.1.1.min.js" type="text/javascript"></script>
	<script src="${path}/js/bootstrap.min.js" type="text/javascript"></script>
	<script type="text/javascript" src="${path}/layui/layui.js"></script>
	<style type="text/css">


.form-control[disabled], .form-control[readonly], fieldset[disabled] .form-control
	{
	cursor: not-allowed;
	background-color: #fff;
	opacity: 1;
}
</style>
</head>
<body>

	<div class="panel panel-default" style="height: 100%;border-bottom:0px #fff;">
		<div class="panel-heading">
			<h3 class="panel-title">新增采购</h3>
		</div>
		<div class="panel-body">
			<form method="post" id="form">
				<div class="form-group">
					<label >批次号</label> 
					<input type="text" class="form-control" name="pch" 
					value="${pch}" readonly="readonly" id="pch"
					>
				</div>
				<div class="form-group">
					<label >种类</label> 
					<select class="form-control" id="kind" name="kind">
				    	<option value="">请选择</option>
				    	<c:forEach items="${goodsList}" var ="item">
					    	<option value="${item.goods_name}">${item.goods_name}</option>
				    	</c:forEach>
				    </select>
					<%-- <input type="hidden" name="id" 
					value="${meat.meat_id }"> --%>
				</div>
				<div class="form-group">
					<label >品级</label> 
					<select class="form-control" id="grade" name="grade">
				    	<option value="1">1级</option>
				    	<option value="2">2级</option>
				    	<option value="3">3级</option>
				    </select>
				</div>
				<div class="form-group">
					<label >采购量</label> <input
						type="number" class="form-control" name="num" id="num" >
				</div>
				<div class="form-group">
					<label >生产厂家</label> <input
						type="text" class="form-control" name="sccj" id="sccj" >
				</div>
				<!-- <div class="form-group">
					<label >三品一标</label> <input
						type="text" class="form-control" >
				</div> -->
				<div class="form-group">
					<label >采购人</label> <input
						type="text" class="form-control" name="cgr" id="cgr"
						value="${sessionScope.user.realname }" readonly="readonly"
						>
				</div>
				
				<!-- <div class="form-group" style="display: none;">
					<label >采购价</label> <input
						type="number" class="form-control"
						 name="cgj" id="purchase_price">
				</div> -->
				<div class="form-group">
					<label >检测报告</label> 
					<input type="file" name="file" id="upload" lay-type="image" class="layui-upload-file">
					<span id="img"></span><button class="btn btn-mini btn-danger del_btn hide">删除</button>
					<input type="hidden" id="real_path" >
					<input type="hidden" name="jcbg" id="jcbg" >
				</div>
				
				<div class="form-group">
					<label >超市价</label> <input
						type="number" class="form-control"
						 name="csj" id="market_price">
				</div> 
				<div class="form-group" >
					<label >食堂价</label> <input
						type="number" class="form-control"
						 name="stj" id="canteen_price">
				</div> 
				<div class="form-group" >
					<label >零售价</label> <input
						type="number" class="form-control"
						 name="lsj" id="retail_price">
				</div> 
				<div class="form-group" >
					<label >其他价</label> <input
						type="number" class="form-control"
						 name="qtj" id="other_price">
				</div> 
				<button type="button" class="btn btn-primary" id="submit_btn" onclick="submitD();">提交</button>
				<button type="button" class="btn btn-default" onclick="parent.closeModal();">关闭</button> 
			</form>
		</div>
	</div>
<script type="text/javascript">
layui.use(
		[ 'element', 'form', 'upload', 'layedit', 'laydate' ],function() {
		var element = layui.element(), 
		jq = layui.jquery;
		layui.upload({
            elem:'#upload',
            title:'上传文件',
            url : '${path}/upload/upload.do?path=jcbg',
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
                        time: 1000 //2秒关闭（默认3秒）
                    }, function(){
                    	$("#jcbg").val(rs.name);
                    	$("#real_path").val(rs.path);
                    	$("#img").html(rs.name);
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
							$("#jcbg").val("");
							$("#real_path").val("");
							$("#img").html('');
							$('.del_btn').addClass('hide');
						})
					}
				}
			}
		})
	})
		
	
})
function submitD(){
	var kind = $("#kind").val();
	if(""==kind||null==kind){
		layer.msg('请选择种类！',{time:1000});
		return;
	}
	var grade = $("#grade").val();
	if(""==grade||null==grade){
		layer.msg('请选择品级',{time:1000});
		return;
	}
	var num = $("#num").val();
	if(""==num||null==num||isNaN(num)){
		layer.msg('采购数量格式不正确！',{time:1000});
		return;
	}
	/* var price = $("#price").val();
	if(""==price||null==price||isNaN(price)){
		layer.msg('采购单价不正确！',{time:1000});
		return;
	} */
	var sccj = $("#sccj").val();
	if(""==sccj||null==sccj){
		layer.msg('请填写生产厂家！',{time:1000});
		return;
	}
	var jcbg = $("#jcbg").val();
	if(""==jcbg||null==jcbg){
		layer.msg('请上传检测报告！',{time:1000});
		return;
	}
	var market_price = $("#market_price").val();
	if(""==market_price||null==market_price||isNaN(market_price)){
		layer.msg('超市价格格式不正确！',{time:1000});
		return;
	}
	var canteen_price = $("#canteen_price").val();
	if(""==canteen_price||null==canteen_price||isNaN(canteen_price)){
		layer.msg('超市价格格式不正确！',{time:1000});
		return;
	}
	var retail_price = $("#retail_price").val();
	if(""==retail_price||null==retail_price||isNaN(retail_price)){
		layer.msg('零售价格格式不正确！',{time:1000});
		return;
	}         
	var other_price = $("#other_price").val();
	if(""==other_price||null==other_price||isNaN(other_price)){
		layer.msg('其他价格格式不正确！',{time:1000});
		return;
	}
	//$("#submit_btn").hide();
	$.ajax({
		type:'post',
		url:'${path}/fruit/addSave.do',
		dataType:'json',
		data:{'pch':$("#pch").val(),'kind':kind,'grade':grade,'num':num,
			'sccj':sccj,'jcbg':jcbg,'cgr':$("#cgr").val(),
			'canteen_price':canteen_price,'market_price':market_price,
			'retail_price':retail_price,'other_price':other_price},
		success:function(rs){
			if(""!=rs){
				layer.msg("新增成功！",{time:1000},function(){
					parent.closeModal();
				});
			}
		},
		error:function(rs){
			layer.msg("出错了！",{time:1000},function(){
				
			});
		}
	})
}

</script>
</body>
</html>
