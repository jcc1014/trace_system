<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../common/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>生产/供应基地</title>
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
			<h3 class="panel-title"><span id="title">今日供应单（17点自动提交当日供应单）</span></h3>
		</div>
		<div class="panel-body">
			<div><h4>供应单信息</h4></div>
			<div>时间：<span id="time" style="color:red;"></span></div>
			<div>名称：${totalInfo.name}</div>
			<div>类型：
			<c:if test="${sessionScope.baseInfo.type eq '5'}">供应基地</c:if>
			<c:if test="${sessionScope.baseInfo.type eq '1'}">生产基地</c:if>
			</div>
			<div>时间：${totalInfo.createtime}</div>
			<div>产地：${totalInfo.source_name}</div>
			<div>负责人：${sessionScope.user.username}</div>
			<div>手机：${sessionScope.baseInfo.phone}</div>
		</div>
		<table class="table table-striped table-bordered table-condensed">
			<thead>
				<tr>
					<th>种类</th><th>品级</th><th>三品一标</th><th>供应量</th><th>价格</th><th>操作</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${fn:length(produceInfos)==0 }">
					<tr><td colspan="6">暂无数据</td></tr>
				</c:if>
				<c:forEach var="item" items="${produceInfos}">
					<tr>
						<td>${item.type }</td>
						<td>${item.grade }</td>
						<td>${item.spyb }</td>
						<td>${item.supply_number }</td>
						<td>${item.price }</td>
						<td>
							<c:if test="${item.status eq '0' }">
							<a href="javascript:;" onclick="edit('${item.produce_id}');"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span></a>
							&nbsp;&nbsp;
							<a href="javascript:;" onclick="del('${item.produce_id}');"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></a>
							</c:if>
							<c:if test="${item.status eq '1' }">
								已提交
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</tbody>
  		</table>
		<div class="panel-footer" style="margin-top: 20px;">
			<c:if test="${totalInfo.status eq '0' }">
			</c:if>
			<button type="button" id="submit" class="btn btn-primary" onclick="submit();">提交</button>
			<button type="button" class="btn btn-success" onclick="add();">增加</button>
			<button type="button" class="btn btn-default" onclick="window.location.href = '${path}/baseInfo/index.do';">返回</button>
		</div>
	</div>
<div style="display:none;padding: 5%;" id="modal_edit">
<form>
  <div class="form-group">
    <label for="modal_edit_type">种类</label>
    <input type="hidden" id="modal_edit_produce_id" >
    <input type="text" class="form-control" id="modal_edit_type" placeholder="种类" readonly="readonly">
  </div>
  <div class="form-group">
    <label for="modal_edit_grade">品级</label>
    <input type="text" class="form-control" id="modal_edit_grade" placeholder="品级" readonly="readonly">
  </div>
  <div class="form-group">
    <label for="modal_edit_spyb">三品一标</label>
    <input type="text" class="form-control" id="modal_edit_spyb"  readonly="readonly">
  </div>
  <div class="form-group">
    <label for="modal_edit_supply_number">供应量</label>
    <input type="number" class="form-control" id="modal_edit_supply_number" placeholder="供应量">
  </div>
  <div class="form-group">
    <label for="modal_edit_price">价格</label>
    <input type="number" class="form-control" id="modal_edit_price" placeholder="价格">
  </div>
  <div class="form-group" style="text-align: center;">
	  <button type="button" class="btn btn-success" onclick="modal_edit_save();">修改</button>
	  <button type="button" class="btn btn-default" onclick="closeModal();">关闭</button>
  </div>
</form>
</div>
<div style="display:none;padding: 5%;" id="modal_add" >
<form>
  <div class="form-group">
    <label for="modal_type">种类</label>
    <select class="form-control" id="modal_add_type">
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
    <label for="modal_add_spyb">三品一标</label>
    <select class="form-control" id="modal_add_spyb">
    	<option value="">请选择</option>
    	<c:forEach var="item" items="${dictList}">
	    	<option value="${item.dict_name }">${item.dict_name }</option>
    	</c:forEach>
    </select>
  </div>
  <div class="form-group">
    <label for="modal_add_supply_number">供应量</label>
    <input type="number" class="form-control" id="modal_add_supply_number" placeholder="供应量（斤或包）">
  </div>
  <div class="form-group">
    <label for="modal_add_price">价格</label>
    <input type="number" class="form-control" id="modal_add_price" placeholder="价格">
  </div>
  <div class="form-group" style="text-align: center;">
	  <button type="button" class="btn btn-success" onclick="modal_add_save();">保存</button>
	  <button type="button" class="btn btn-default" onclick="closeModal();">关闭</button>
  </div>
</form>
</div>
<script type="text/javascript">
$(function(){
	//设置一个定时器，五点之后开启
	setInterval("time();",1000);
})
function time(){
	var date = new Date();
    var seperator1 = "-";
    var seperator2 = ":";
    var month = date.getMonth() + 1;
    var strDate = date.getDate();
    if (month >= 1 && month <= 9) {
        month = "0" + month;
    }
    if (strDate >= 0 && strDate <= 9) {
        strDate = "0" + strDate;
    }
    var currentdate = date.getFullYear() + seperator1 + month + seperator1 + strDate
            + " " + formatTime(date.getHours()) + seperator2 + formatTime(date.getMinutes())
            + seperator2 + formatTime(date.getSeconds());
    var time = formatTime(date.getHours()) + seperator2 + formatTime(date.getMinutes())
    + seperator2 + formatTime(date.getSeconds());
    $("#time").html(time);
    if(time=="17:00:00"){
    	self.location.reload();
    }
    if(time>"17:00:00"){
    	//$("#submit").removeClass("hide");
    	$("#title").html("明日供应单（今日供应单可在历史纪录查看）")
    }
}
//格式化时间
function formatTime(time){
	//小于10的数以ss格式显示
	if(10>parseInt(time)){
		time = "0"+time;
	}
	return time;
}
function add(){
	$("#modal_add_type").val("");
	$("#modal_add_grade").val("");
	$("#modal_add_spyb").val("");
	$("#modal_add_supply_number").val("");
	$("#modal_add_price").val("");
	layer.open({
		type:'1',
		title:'新增',
		closeBtn:1,
		area: ['90%','75%'],
		shadeClose: true,
		content: $('#modal_add')
	})
}

function del(id){
	$.ajax({
		type:'post',
		url:'${path}/produce/delProduce.do',
		data:{'produce_id':id},
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
		url:'${path}/produce/submitGyd.do',
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
		url:'${path}/produce/editProduce.do',
		data:{'produce_id':id},
		dataType:'json',
		success:function(rs){
			if(null!=rs&&""!=rs){
				rs = $.parseJSON(rs);
				$("#modal_edit_produce_id").val(rs.produce_id);
				$("#modal_edit_type").val(rs.type);
				$("#modal_edit_grade").val(rs.grade);
				$("#modal_edit_spyb").val(rs.spyb);
				$("#modal_edit_supply_number").val(rs.supply_number);
				$("#modal_edit_price").val(rs.price);
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
	var supply_number = $("#modal_edit_supply_number").val();
	if(""==supply_number||0==supply_number){
		layer.msg('请填写供应量！',{time:1000});
		return;
	}
	if(isNaN(supply_number)){
		layer.msg('供应量应该是数字！',{time:1000});
		return;
	}
	var price = $("#modal_edit_price").val();
	if(""==supply_number||0==supply_number){
		layer.msg('请填写价格！',{time:1000});
		return;
	}
	if(isNaN(price)){
		layer.msg('价格应该是数字！',{time:1000});
		return;
	}
	$.ajax({
		type:'post',
		url:'${path}/produce/editProduceSave.do',
		data:{'produce_id':produce_id,'supply_number':supply_number,'price':price},
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
	var type = $("#modal_add_type").val();
	if(""==type){
		layer.msg('请填写种类！',{time:1000});
		return;
	}
	var grade = $("#modal_add_grade").val();
	if(""==grade){
		layer.msg('请填写品级！',{time:1000});
		return;
	}
	var spyb = $("#modal_add_spyb").val();
	if(""==spyb){
		layer.msg('请选择三品一标！',{time:1000});
		return;
	}
	var supply_number = $("#modal_add_supply_number").val();
	if(""==supply_number||0==supply_number){
		layer.msg('请填写供应量！',{time:1000});
		return;
	}
	if(isNaN(supply_number)){
		layer.msg('供应量应该是数字！',{time:1000});
		return;
	}
	var price = $("#modal_add_price").val();
	if(""==supply_number||0==supply_number){
		layer.msg('请填写价格！',{time:1000});
		return;
	}
	if(isNaN(price)){
		layer.msg('价格应该是数字！',{time:1000});
		return;
	}
	$.ajax({
		type:'post',
		url:'${path}/produce/addProduceSave.do',
		data:{'parent_id':'${totalInfo.id}','type':type,'grade':grade,'spyb':spyb,'supply_number':parseFloat(supply_number),'price':parseFloat(price)},
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

function closeModal(){
	layer.closeAll();
}
</script>
</body>
</html>
