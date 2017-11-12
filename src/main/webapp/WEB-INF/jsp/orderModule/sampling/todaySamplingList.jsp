<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../common/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>今日取样</title>
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
	<script src="${path}/layer/layer.js" type="text/javascript"></script>
	<script type="text/javascript" src="${path}/layui/layui.js"></script>
	<style type="text/css">
		body{background-color: #eee;}
		thead tr th{text-align: center;}
		tbody tr td{text-align: center;}
		table {border-bottom: 1px solid #eee; }
	</style>
</head>
<body>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title">今日取样单<!-- （距离需求单锁定还有：<span>30</span>分钟） --></h3>
		</div>
		<div class="panel-body">
			
		</div>
		<table class="table table-striped table-bordered table-condensed">
			<thead>
				<tr>
					<th>农户</th><th>种类</th><th>品级</th><th>三品一标</th><th>操作</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${fn:length(list)==0 }">
					<tr><td colspan="6">暂无数据</td></tr>
				</c:if>
				<c:forEach var="item" items="${list}">
					<tr>
						<td>${item.farmer.farmer_name }</td>
						<td>${item.purchase.purchase_kind }</td>
						<td>${item.purchase.purchase_grade }</td>
						<td>${item.purchase.purchase_spyb }</td>
						<td>
							<c:if test="${item.trace_flow.trace_status eq '1' }">
							<a href="javascript:;" onclick="add('${item.trace_flow.trace_id}','${item.purchase.purchase_kind }',
							'${item.purchase.purchase_grade }','${item.purchase.purchase_spyb}','${item.qybh}');">取样</a>
							</c:if>
							<c:if test="${item.trace_flow.trace_status ne '1'}">
								已取样
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</tbody>
  		</table>
		<div class="panel-footer" style="margin-top: 20px;">
			<button type="button" class="btn btn-default" onclick="back();">返回</button>
		</div>
	</div>
	<div style="display:none;padding: 5%;" id="modal_add" >
		<form method="post" action="${path}/sampling/addQhSamplingSave2.do" id="form">
			<div class="form-group">
				<label for="name">名称</label> 
				<input type="hidden" id="test_kind" name="test_kind" >
				<input type="hidden" id="test_grade" name="test_grade"> 
				<input type="hidden" id="test_spyb" name="test_spyb"> 
				<input type="hidden" id="trace_id" name="trace_id">
				<input type="hidden" id="test_bh" name="test_bh">
			    <input type="text"
					class="form-control" id="name" readonly="readonly">
			</div>
			<div class="form-group">
				<label for="test_num">取样数量</label> <input type="text"
					class="form-control" id="test_num" name="test_num"
					placeholder="取样数量">
			</div>
			<div class="form-group">
				<label>原产地证明</label> <input type="file" name="file2"
					id="uploadYcdzm" lay-type="images" class="layui-upload-file">
				<span id="img"></span>
				<button type="button" class="btn btn-mini btn-danger del_btn2 hide">删除</button>
				<input type="hidden" id="real_path2"> <input type="hidden"
					name="ycdzm" id="ycdzm">
			</div>
			<div class="form-group">
				<label for="test_num">取样视频</label> <input type="file" name="file"
					id="upload" lay-type="video" accept="video/*"
					class="layui-upload-file"> <span id="video"></span>
				<button type="button" class="btn btn-mini btn-danger del_btn hide">删除</button>
				<input type="hidden" id="real_path"> <input type="hidden"
					name="purchase_video" id="purchase_video">
			</div>
			<div class="form-group" style="text-align: center;">
				<button type="button" class="btn btn-success" onclick="save();"
					id="submit_btn">保存</button>
				<button type="button" class="btn btn-default"
					onclick="closeAll();">关闭</button>
			</div>
		</form>
	</div>
<script type="text/javascript">
function add(trace_id,kind,grade,spyb,qybh){
	//window.location.href = "${path}/sampling/addSampling.do"
	$("#trace_id").val(trace_id);
	$("#test_kind").val(kind);
	$("#test_grade").val(grade);
	$("#test_spyb").val(spyb);
	$("#test_bh").val(qybh);
	$("#name").val(grade+"级"+kind+spyb);
	layer.open({
		type:'1',
		title:'新增取样',
		closeBtn:1,
		area: ['90%','60%'],
		shadeClose: true,
		content: $('#modal_add')
	})
}
layui.use(
		[ 'element', 'form', 'upload', 'layedit', 'laydate' ],function() {
		var element = layui.element(), 
		jq = layui.jquery;
		layui.upload({
            elem:'#upload',
            title:'上传视频',
            ext:'MP4|mp4|avi|mov',
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
                    	$("#sampling_video").val(rs.name);
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
							$("#sampling_video").val("");
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
        title:'原产地证明',
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

function checkPhone(){
var farmer_phone = $("#farmer_phone").val();
if(""!=farmer_phone){
	$.ajax({
		url:'${path}/sampling/checkPhone.do',
		type:'post',
		dataType:'json',
		data:{'phone':farmer_phone},
		success:function(rs){
			if(""!=rs){
				rs = $.parseJSON(rs);
				if("200"==rs.code){
					$("#farmer_name").val(rs.farmer_name);
					//$("#farmer_hzs").val(rs.farmer_hzs);
					$("#base_id").val(rs.baseid);
					$("#"+rs.baseid).attr("selected",true);
				}
			}
		}
	})
}
}	

function save(){

$("#submit_btn").hide();
$("#form").submit();
}

function getNum(){
var opt = $("#test_kind>option:selected");
if(""!=opt.val()){
	$("#num").val(opt.data("num"));
}
}

function closeModal(){
layer.closeAll();
}

function del(id){
	$.ajax({
		type:'post',
		url:'${path}/sampling/delSampling.do',
		data:{'id':id},
		dataType:'json',
		success:function(rs){
			if(null!=rs&&""!=rs){
				rs = $.parseJSON(rs);
				if(rs.code=="200"){
					layer.msg('删除成功！',{time:1000},function(){
						self.location.reload();
					})
				}
				
			}
		}
	})
}
function submit(){
	$.ajax({
		type:'post',
		url:'${path}/sampling/submitQyd.do',
		data:{'id':'${totalInfo.id}'},
		dataType:'json',
		success:function(rs){
			if(null!=rs&&""!=rs){
				rs = $.parseJSON(rs);
				if(rs.code=="200"){
					layer.msg('提交成功！',{time:1000},function(){
						self.location.reload();
					})
				}
				
			}
		}
	})
}

function edit(id){
	$.ajax({
		type:'post',
		url:'${path}/require/editRequire.do',
		data:{'id':id},
		dataType:'json',
		success:function(rs){
			if(null!=rs&&""!=rs){
				rs = $.parseJSON(rs);
				$("#modal_edit_id").val(rs.id);
				$("#modal_edit_kind").val(rs.kind);
				$("#modal_edit_grade").val(rs.grade);
				$("#modal_edit_num").val(rs.num);
				layer.open({
					type:'1',
					title:'编辑',
					closeBtn:1,
					area: ['90%','70%'],
					shadeClose: true,
					content: $('#modal_edit')
				})
			}
		}
	})
	
}

function modal_edit_save(){
	var produce_id = $("#modal_edit_produce_id").val();
	var num = $("#modal_edit_num").val();
	if(""==num||0==num){
		layer.msg('请填写需求量！',{time:1000});
		return;
	}
	if(isNaN(num)){
		layer.msg('需求量应该是数字！',{time:1000});
		return;
	}
	$.ajax({
		type:'post',
		url:'${path}/sampling/editRequireSave.do',
		data:{'id':id,'num':num},
		dataType:'json',
		success:function(rs){
			if(null!=rs&&""!=rs){
				rs = $.parseJSON(rs);
				if(rs.code=="200"){
					layer.msg('修改成功！',{time:1000},function(){
						self.location.reload();
					})
				}else{
					layer.msg('修改失败',{time:1000})
				}
				
			}
		}
	})
}
function modal_add_save(){
	var kind = $("#modal_add_kind").val();
	if(""==kind){
		layer.msg('请填写种类！',{time:1000});
		return;
	}
	var grade = $("#modal_add_grade").val();
	if(""==grade){
		layer.msg('请填写品级！',{time:1000});
		return;
	}
	var num = $("#modal_add_num").val();
	if(""==num||0==num){
		layer.msg('请填写需求量！',{time:1000});
		return;
	}
	if(isNaN(num)){
		layer.msg('需求量应该是数字！',{time:1000});
		return;
	}
	$.ajax({
		type:'post',
		url:'${path}/sampling/addRequireSave.do',
		data:{'parentid':'${totalInfo.id}','kind':kind,'grade':grade,'num':parseFloat(num)},
		dataType:'json',
		success:function(rs){
			if(null!=rs&&""!=rs){
				rs = $.parseJSON(rs);
				if(rs.code=="200"){
					layer.msg('新增成功！',{time:1000},function(){
						self.location.reload();
					})
				}else if("1"==rs.code){
					layer.msg('此种类等级已经存在,</br>请选择其他种类或者品级！',{time:1000})
				}else{
					layer.msg('新增失败',{time:1000})
				}
				
			}
		}
	})
}

function close(){
	layer.closeAll();
}
function back(){
	window.location.href = "${path}/sampling/today_Qhsampling.do"
}

</script>
</body>
</html>
