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
	<script src="${path}/js/jquery-2.1.1.min.js" type="text/javascript"></script>
	<script src="${path}/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="${path}/layer/layer.js" type="text/javascript"></script>
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
					<th>农户</th><th>种类</th><th>品级</th><th>编号</th><th>数量</th><th>操作</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${fn:length(list)==0 }">
					<tr><td colspan="6">暂无数据</td></tr>
				</c:if>
				<c:forEach var="item" items="${list}">
					<tr>
						<td>${item.farmer.farmer_name }</td>
						<td>${item.test.test_kind }</td>
						<td>${item.test.test_grade }</td>
						<td>${item.test.test_bh }</td>
						<td>${item.test.test_num }</td>
						<td>
							<c:if test="${item.test.test_status eq '0' }">
							<%-- <a href="javascript:;" onclick="edit('${item.test.test_id}');"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span></a>
							&nbsp;&nbsp; --%>
							<a href="javascript:;" onclick="del('${item.test.test_id}');"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></a>
							</c:if>
							<c:if test="${item.test.test_status ne '0'}">
								已提交
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</tbody>
  		</table>
		<div class="panel-footer" style="margin-top: 20px;">
				<button type="button" class="btn btn-primary" onclick="submit();">提交</button>
				<button type="button" class="btn btn-success" onclick="add();">增加</button>
			<%-- <c:if test="${fn:length(list)>0 && list[0].test.test_status eq '0'  }">
				<button type="button" class="btn btn-primary" onclick="submit();">提交</button>
			</c:if>
			<c:if test="${fn:length(list)==0 || list[0].test.test_status eq '0'  }">
				<button type="button" class="btn btn-success" onclick="add();">增加</button>
			</c:if> --%>
			<!-- <button type="button" class="btn btn-success" onclick="add();">增加</button> -->
			<button type="button" class="btn btn-default" onclick="window.location.href = '${path}/baseInfo/index.do';">返回</button>
		</div>
	</div>
<script type="text/javascript">
function add(){
	window.location.href = "${path}/sampling/addQhSampling.do"
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
		url:'${path}/sampling/submitQhQyd.do',
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
</script>
</body>
</html>
