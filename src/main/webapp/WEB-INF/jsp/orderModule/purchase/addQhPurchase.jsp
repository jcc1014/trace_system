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
			<form method="post" action="${path}/purchase/addQhPurchaseSave.do" id="form">
				<div class="form-group">
					<label >种类</label> 
					<input type="text" class="form-control" name="purchase_kind" 
					value="${purchaseInfo.kind }" readonly="readonly">
					<input type="hidden" name="purchase_parentid" 
					value="${purchaseInfo.purchase_id }">
				</div>
				<div class="form-group">
					<label >品级</label> <input
						type="text" class="form-control" name="purchase_grade" value="${purchaseInfo.grade }" readonly="readonly">
				</div>
				<div class="form-group">
					<label >采购人</label> <input
						type="text" class="form-control" name="purchase_user" value="${sessionScope.user.username }" readonly="readonly">
				</div>
				<div class="form-group">
					<label >市场/基地</label> 
					<select name="trace_id" id="trace_id" class="form-control" >
							<option value="">--请选择--</option>
						<c:forEach var="item" items="${list}">
							<option value="${item.trace_id }">${item.farmer_name }</option>
						</c:forEach>
					</select>
				</div>
				<div class="form-group">
					<label >采购价</label> 
					<input type="number" class="form-control"
						value=""
						 name="purchase_price" id="purchase_price">
				</div>
				<div class="form-group">
					<label >采购数量(还有${purchaseInfo.remain_number }未采购)</label> 
					<input type="number" class="form-control"
					 name="purchase_num" id="purchase_num" onblur="checkNum();"
					 placeholder="还有${purchaseInfo.remain_number }未采购">
				</div>
				<div class="form-group" style="display: none;">
					<label >采购视频</label> 
					<input type="file" name="file" id="upload" lay-type="video" class="layui-upload-file">
					<span id="video"></span><button class="btn btn-mini btn-danger del_btn hide">删除</button>
					<input type="hidden" id="real_path" >
					<input type="hidden" name="purchase_video" id="purchase_video" >
				</div>
				<div class="form-group" style="display: none;">
					<label >原产地证明</label> 
					<input type="file" name="file2" id="uploadYcdzm" lay-type="images" class="layui-upload-file">
					<span id="img"></span><button class="btn btn-mini btn-danger del_btn2 hide">删除</button>
					<input type="hidden" id="real_path2" >
					<input type="hidden" name="ycdzm" id="ycdzm" >
				</div>
				<div class="form-group">
					<label >运输员</label> <input
						type="text" class="form-control" 
						id="transport_user" name="transport_user">
				</div>
				<div class="form-group">
					<label >运输车辆</label> <input
						type="text" class="form-control" 
						id="transport_truck" name="transport_truck" >
				</div>
				<div class="form-group">
					<label >目的地</label> <input
						type="text" class="form-control" 
						id="transport_destination" name="transport_destination">
				</div>
				<button type="button" class="btn btn-primary" onclick="submit();">提交</button>
				<button type="button" class="btn btn-default" onclick="window.location.href='${path}/purchaseInfo/getQhd.do'">返回</button>
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
                        time: 1000 //2秒关闭（默认3秒）
                    }, function(){
                    	$("#purchase_video").val(rs.name);
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
							$("#purchase_video").val("");
							$("#real_path").val("");
							$("#video").html('');
							$('.del_btn').addClass('hide');
						})
					}
				}
			}
		})
	})
		layui.upload({
            elem:'#uploadYcdzm',
            title:'上传视频',
            url : '${path}/upload/upload.do?path=ycdzm',
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
                    	$("#ycdzm").val(rs.name);
                    	$("#real_path2").val(rs.path);
                    	$("#img").html(rs.name);
                    	$(".del_btn2").removeClass('hide');
                    });
                   
                } else {
                    layer.msg('上传失败' + rs.msg + ',请检查视频名称是否有中文或重试', {
                        icon: 2,
                        time: 2000 //2秒关闭（默认3秒）
                    }, function(){});
                }
            }
        });
		
	jq(".del_btn2").on('click',function(){
		var path = $('#real_path2').val();
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
							$("#ycdzm").val("");
							$("#real_path2").val("");
							$("#img").html('');
							$('.del_btn2').addClass('hide');
						})
					}
				}
			}
		})
	})
		
	
})
function submit(){
	var trace_id = $("#trace_id").val();
	if(""==trace_id||null==trace_id){
		layer.msg('请选择农户！',{time:1000});
		return;
	}
	var purchase_price = $("#purchase_price").val();
	if("0.0"==purchase_price||""==purchase_price||null==purchase_price||isNaN(purchase_price)){
		layer.msg('采购价格格式不正确！',{time:1000});
		return;
	}
	var purchase_num = $("#purchase_num").val();
	if("0.0"==purchase_price||""==purchase_num||null==purchase_num||isNaN(purchase_num)){
		layer.msg('采购数量格式不正确！',{time:1000});
		return;
	}
	var transport_user = $("#transport_user").val();
	if(""==transport_user||null==transport_user){
		layer.msg('请填写运输人！',{time:1000});
		return;
	}
	var transport_truck = $("#transport_truck").val();
	if(""==transport_truck||null==transport_truck){
		layer.msg('请填写运输车辆！',{time:1000});
		return;
	}
	var transport_destination = $("#transport_destination").val();
	if(""==transport_destination||null==transport_destination){
		layer.msg('请填写运输目的地！',{time:1000});
		return;
	}
	$("#form").submit();
}

function checkNum(){
	var purchase_num = $("#purchase_num").val();
	if(""!=purchase_num&&!isNaN(purchase_num)){
		if(parseFloat(purchase_num)>parseFloat('${purchaseInfo.remain_number}')){
			layer.msg('采购数量不能多于未采购量！',{time:1000});
			$("#purchase_num").val("").focus();
			return;
		}
	}else{
		layer.msg('采购数量格式不正确！',{time:1000});
		$("#purchase_num").val("").focus();
		return;
	}
}
</script>
</body>
</html>
