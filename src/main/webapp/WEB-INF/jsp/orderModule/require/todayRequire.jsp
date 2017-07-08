<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../common/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>生产基地</title>
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
			<h3 class="panel-title">今日需求单<!-- （距离需求单锁定还有：<span>30</span>分钟） --></h3>
		</div>
		<div class="panel-body">
			<div><h4>需求单信息</h4></div>
			<div>名称：${totalInfo.name}</div>
			<div>时间：${totalInfo.createtime}</div>
			<div>地址：${totalInfo.source_name}</div>
			<div>负责人：${sessionScope.user.username}</div>
			<div>手机：${sessionScope.baseInfo.phone}</div>
		</div>
		<table class="table table-striped table-bordered table-condensed">
			<thead>
				<tr>
					<th>种类</th><th>品级</th><th>需求量</th><th>操作</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${fn:length(requireList)==0 }">
					<tr><td colspan="4">暂无数据</td></tr>
				</c:if>
				<c:forEach var="item" items="${requireList}">
					<tr>
						<td>${item.kind }</td>
						<td>${item.grade }</td>
						<td>${item.num }</td>
						<td>
							<c:if test="${totalInfo.status eq '0' }">
							<a href="javascript:;" onclick="edit('${item.id}');"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span></a>
							&nbsp;&nbsp;
							<a href="javascript:;" onclick="del('${item.id}');"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></a>
							</c:if>
							<c:if test="${totalInfo.status eq '1' }">
								已提交
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</tbody>
  		</table>
		<div class="panel-footer" style="margin-top: 20px;">
			<c:if test="${totalInfo.status eq '0' }">
				<c:if test="${fn:length(requireList)>0  }">
					<button type="button" class="btn btn-primary" onclick="submit();">提交</button>
				</c:if>
				<button type="button" class="btn btn-success" onclick="add();">增加</button>
			</c:if>
			<button type="button" class="btn btn-default" onclick="window.location.href = '${path}/baseInfo/index.do';">返回</button>
		</div>
	</div>
<div style="display:none;padding: 5%;" id="modal_edit">
<form>
  <div class="form-group">
    <label for="modal_edit_kind">种类</label>
    <input type="hidden" id="modal_edit_id" >
    <input type="text" class="form-control" id="modal_edit_kind" placeholder="种类" readonly="readonly">
  </div>
  <div class="form-group">
    <label for="modal_edit_grade">品级</label>
    <input type="text" class="form-control" id="modal_edit_grade" placeholder="品级" readonly="readonly">
  </div>
  <div class="form-group">
    <label for="modal_edit_num">需求量</label>
    <input type="number" class="form-control" id="modal_edit_num" placeholder="需求量">
  </div>
  <div class="form-group" style="text-align: center;">
	  <button type="button" class="btn btn-success" onclick="modal_edit_save();">修改</button>
	  <button type="button" class="btn btn-default" onclick="close();">关闭</button>
  </div>
</form>
</div>
<div style="display:none;padding: 5%;" id="modal_add" >
<form>
  <div class="form-group">
    <label for="modal_add_kind">种类</label>
    <select class="form-control" id="modal_add_kind">
    	<option value="">请选择</option>
    	<c:forEach items="${goodsList}" var ="item">
	    	<option value="${item.goods_name}">${item.goods_name}</option>
    	</c:forEach>
    </select>
  </div>
  <div class="form-group">
    <label for="modal_add_grade">品级</label>
    <select class="form-control" id="modal_add_grade">
    	<option value="">请选择</option>
    	<option value="1">1</option>
    	<option value="2">2</option>
    	<option value="3">3</option>
    </select>
  </div>
  <div class="form-group">
    <label for="modal_add_num">需求量</label>
    <input type="number" class="form-control" id="modal_add_num" placeholder="需求量">
  </div>
  <div class="form-group" style="text-align: center;">
	  <button type="button" class="btn btn-success" onclick="modal_add_save();">保存</button>
	  <button type="button" class="btn btn-default" onclick="close();">关闭</button>
  </div>
</form>
</div>
<script type="text/javascript">
function add(){
	$("#modal_add_type").val("");
	$("#modal_add_grade").val("");
	$("#modal_add_num").val("");
	layer.open({
		type:'1',
		title:'新增',
		closeBtn:1,
		area: ['90%','70%'],
		shadeClose: true,
		content: $('#modal_add')
	})
}

function del(id){
	$.ajax({
		type:'post',
		url:'${path}/require/delRequire.do',
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
		url:'${path}/require/submitXqd.do',
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
		url:'${path}/require/editRequireSave.do',
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
		url:'${path}/require/addRequireSave.do',
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