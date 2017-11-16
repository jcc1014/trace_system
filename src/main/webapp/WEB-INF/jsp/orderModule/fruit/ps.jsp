<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../common/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>新增配送</title>
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
		<!-- <div class="panel-heading">
			<h3 class="panel-title">新增采购</h3>
		</div> -->
		<div class="panel-body">
			<form method="post" id="form">
				<div class="form-group">
					<label >配送码</label> 
					<input type="text" class="form-control" name="code" 
					 id="code" value="${pch }" readonly="readonly"
					>
				</div>
				<div class="form-group">
					<label >种类</label> 
					<input type="text" class="form-control" name="kind" 
					value="${requireFruit.kind}" readonly="readonly" id="kind"
					>
					<input type="hidden" name="require_id" id="require_id"
					value="${requireFruit.id }"> 
				</div>
				<div class="form-group">
					<label >品级</label> 
					<input type="text" class="form-control" name="grade" 
					value="${requireFruit.grade}" readonly="readonly" id="grade"
					>
				</div>
				<div class="form-group">
					<label >批次号</label> 
					<!-- <input type="text" class="form-control" name="pch" 
					 id="pch" onblur="geteRemain();"
					> -->
					<select  class="form-control" name="pch" 
					 id="pch" onchange="geteRemain();">
						<option value="">请选择批次号</option>
						<c:forEach var="item" items="${fruitList}">
							<option value="${item.pch }">${item.pch}</option>
						</c:forEach>
					</select>
					<span id="remain_num" style="color: red;"></span>
					<input type="hidden" id="r_num"/>
					</div>
				<div class="form-group">
					<label >配送量</label> <input
						type="number" class="form-control" name="num" id="num" onblur="compare();">
				</div>
				<div class="form-group">
					<label >姓名</label> <input
						type="text" class="form-control" name="xm" id="xm" >
				</div>
				<div class="form-group">
					<label >车牌号</label> <input
						type="text" class="form-control" name="cph" id="cph" >
				</div>
				<div class="form-group">
					<label >配送人</label> <input
						type="text" class="form-control" name="psr" id="psr"
						value="${sessionScope.user.realname }" readonly="readonly"
						>
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
	var pch = $("#pch").val();
	if(""==pch||null==pch){
		layer.msg('批次号不能为空！',{time:1000});
		return;
	}
	var num = $("#num").val();
	if(""==num||null==num||isNaN(num)){
		layer.msg('数量格式不正确！',{time:1000});
		return;
	}
	
	$("#submit_btn").hide();
	$.ajax({
		type:'post',
		url:'${path}/fruit/psSave.do',
		dataType:'json',
		data:$("#form").serialize(),
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

function geteRemain(){
	var pch = $("#pch").val();
	if(null==pch||""==pch){
		layer.msg("批次号不能为空！",{time:1000});
		return;
	}
	$.ajax({
		type:'post',
		url:'${path}/fruit/getRemain.do',
		dataType:'json',
		data:{'pch':pch},
		success:function(rs){
			if(""!=rs){
				rs = $.parseJSON(rs);
				$("#remain_num").html("还有"+rs.remain+"可以配送！");
				$("#r_num").val(rs.remain);
				
			}
		},
		error:function(rs){
			layer.msg("出错了！",{time:1000},function(){
				
			});
		}
	})
}

function compare(){
	var remain = $("#r_num").val();
	var num = $("#num").val();
	if(""==num||"0"==num){
		layer.msg('数量不能为空！',{time:1000});
		$("#num").val("").focus();
		return;
	}
	if((parseFloat(remain)*1.1)<parseFloat(num)){
		layer.msg('数量不能大于剩余量的10%！',{time:1000});
		$("#num").val("").focus();
		return;
	}
}
</script>
</body>
</html>
