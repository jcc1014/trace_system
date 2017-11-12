<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../common/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>采购主管</title>
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
	<%-- <script src="${path}/layer/layer.js" type="text/javascript"></script> --%>
	<script type="text/javascript" src="${path}/layui/layui.js"></script>
	<style type="text/css">
		body{background-color: #eee;}
		thead tr th{text-align: center;}
		tbody tr td{text-align: center;}
		table {border-bottom: 1px solid #eee; }
		.col-xs-4{height: 34px;padding-top: 5px;}
	</style>
</head>
<body>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title">${totalInfo.name}</h3>
		</div>
		<div class="panel-body">
			<div class="row">
				<div class="col-xs-4">采购人:</div>
				<div class="col-xs-8">
					<input
					type="text" class="form-control" name="sc" value="${sessionScope.user.realname }" readonly="readonly">
				</div>
			</div>
			<div class="row" style="margin-top: 5px;">
				<div class="col-xs-4">市场:</div>
				<div class="col-xs-8">
					<input
					type="text" class="form-control" id="sc" value="${bInfo.name}" readonly="readonly">
				</div>
			</div>
			<div class="row" style="margin-top: 5px;">
				<div class="col-xs-4">供应商:</div>
				<div class="col-xs-8">
					<select name="trace_id" id="farmer_name" class="form-control" >
						<option value="">--请选择--</option>
						<c:forEach var="item" items="${farmerList}">
							<option value="${item.farmer_id}"
							<c:if test="${item.farmer_id eq sessionScope.farmer_id}">selected="selected"</c:if>
							>${item.farmer_name}${item.farmer_phone }</option>
						</c:forEach>
					</select>
				</div>
			</div>
			<div class="row" style="margin-top: 5px;">
				<div class="col-xs-4">运输员:</div>
				<div class="col-xs-8">
					<input
					type="text" class="form-control" 
					id="transport_user" name="transport_user" value="${sessionScope.transport_user }">
				</div>
			</div>
			<div class="row" style="margin-top: 5px;">
				<div class="col-xs-4">运输车辆:</div>
				<div class="col-xs-8">
					<input
					type="text" class="form-control" 
					id="transport_truck" name="transport_truck" value="${sessionScope.transport_truck }">
				</div>
			</div>
			<div class="row" style="margin-top: 5px;">
				<div class="col-xs-4">目的地:</div>
				<div class="col-xs-8">
					 <input
					type="text" class="form-control" 
					id="transport_destination" name="transport_destination" value="${sessionScope.transport_desitination}">
				</div>
			</div>
		</div>
		<table class="table table-striped table-bordered table-condensed">
			<thead>
				<tr>
					<th>种类</th><th>品级</th><th>三品一标</th><th>采购量</th><th>未采量</th><th>操作</th>
				</tr>
			</thead>
			<tbody id="tbody">
				<c:if test="${fn:length(purchaseInfos)==0 }">
					<tr><td colspan="6">暂无数据</td></tr>
				</c:if>
				<c:forEach var="item" items="${purchaseInfos}">
					<tr>
						<td>${item.kind }</td>
						<td>${item.grade }</td>
						<td>${item.spyb }</td>
						<td>${item.number }</td>
						<td>${item.remain_number}</td>
						<td>
						<c:if test="${sessionScope.user.usertype eq '1' && item.remain_number != 0 }">
						<%-- <a href="javascript:;" onclick="purchase('${item.purchase_id}');">采购</a> --%>
						<a href="javascript:;" 
						onclick="purchase('${item.kind}','${item.grade}','${item.spyb}','${item.number}',
						'${item.remain_number }','${item.purchase_id }');">采购</a>
						</c:if> 
						<c:if test="${sessionScope.user.usertype ne '1' && item.remain_number != 0 }">
							暂无
						</c:if> 
						<c:if test="${sessionScope.user.usertype ne '1' && item.remain_number == 0 }">
							<a href="javascript:;" onclick="detail('${item.purchase_id}');">查看</a>
						</c:if> 
					</td>
					</tr>
				</c:forEach>
			</tbody>
  		</table>
		<div class="panel-footer" style="margin-top: 20px;">
			<button type="button" class="btn btn-default" onclick="back();">返回</button>
			<!-- <button type="button" class="btn btn-success" onclick="watch();">查看采购详单</button> -->
		</div>
	</div>
<div style="display:none;padding: 5%;" id="modal_add" >
<form>
  <div class="form-group">
    <label for="name">名称</label>
    <input type="hidden" id="kind">
    <input type="hidden" id="grade">
    <input type="hidden" id="spyb">
    <input type="hidden" id="number">
    <input type="hidden" id="purchase_id">
    <input type="text" class="form-control" id="name" readonly="readonly">
  </div>
  <div class="form-group">
    <label for="num">剩余采购量</label>
    <input type="number" class="form-control" id="num" readonly="readonly">
  </div>
  <div class="form-group">
    <label for="modal_add_num">本次采购量</label>
    <input type="number" class="form-control" id="purchase_num" placeholder="采购量" onblur="checkNum();">
  </div>
	<div class="form-group">
		<label>采购价</label> <input type="number" class="form-control"
			value="" name="purchase_price" id="purchase_price">
	</div>
	<div class="form-group" style="display: none;">
		<label>采购视频</label> <input type="file" name="file" id="upload"
			lay-type="video" class="layui-upload-file"> <span
			id="video"></span>
		<button class="btn btn-mini btn-danger del_btn hide">删除</button>
		<input type="hidden" id="real_path"> <input type="hidden"
			name="purchase_video" id="purchase_video">
	</div>
	<div class="form-group" style="display: none;">
		<label>原产地证明</label> <input type="file" name="file2"
			id="uploadYcdzm" lay-type="images" class="layui-upload-file">
		<span id="img"></span>
		<button class="btn btn-mini btn-danger del_btn2 hide">删除</button>
		<input type="hidden" id="real_path2"> <input type="hidden"
			name="ycdzm" id="ycdzm">
	</div>
	<div class="form-group" style="text-align: center;">
		<button type="button" class="btn btn-success"
			onclick="modal_add_save();">保存</button>
		<button type="button" class="btn btn-default"
			onclick="closeModal();">关闭</button>
	</div>
</form>
</div>
<script type="text/javascript">
function watch(){
	window.location.href = '${path}/purchase/watchPurchaseDetail.do';
}
function detail(id){
	window.location.href = '${path}/purchase/watchPurchaseDetailById.do?id='+id;
}
function back(){
	window.location.href = '${path}/purchaseInfo/allQhcgd.do';
}
/* function purchase(id){
	window.location.href = '${path}/purchase/addQhPurchase.do?purchase_id='+id;
} */
function purchase(kind,grade,spyb,number,rnum,pid){
	$("#num").val(rnum);
	$("#kind").val(kind);
	$("#grade").val(grade);
	$("#spyb").val(spyb);
	$("#number").val(number);
	$("#name").val(grade+"级"+kind+spyb);
	$("#purchase_id").val(pid);
	layer.open({
		type:'1',
		title:'新增采购',
		closeBtn:1,
		area: ['90%','80%'],
		shadeClose: true,
		content: $('#modal_add')
	})
}
function checkNum(){
	var purchase_num = $("#purchase_num").val();
	if(""!=purchase_num&&!isNaN(purchase_num)){
		if(parseFloat(purchase_num)>parseFloat($("#num").val())){
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
function modal_add_save(){
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
	$.ajax({
		url:'${path}/purchase/addPurchaseSave2.do',
		type:'post',
		data:{'transport_user':transport_user,'transport_truck':transport_truck,'transport_destination':transport_destination,
			'purchase_num':purchase_num,'purchase_kind':$("#kind").val(),'purchase_grade':$("#grade").val(),'purchase_spyb':$("#purchase_spyb").val(),
			'number':$("#number").val(),'farmer_id':$("#farmer_name").val(),'purchase_parentid':$("#purchase_id").val()},
		success:function(rs){
			layer.msg('新增成功！',{time:1000},function(){
				window.location.reload();
			});
		}
	})
}
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
		layui.upload({
            elem:'#uploadYcdzm',
            title:'上传视频',
            url : '${path}/upload/upload.do?path=ycdzm',
            before: function(){
                index = layer.msg('文件上传中', {
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
function closeModal(){
	layer.closeAll();
}
</script>
</body>
</html>
