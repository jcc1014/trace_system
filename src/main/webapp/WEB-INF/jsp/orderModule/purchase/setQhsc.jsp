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
	<script src="${path}/js/jquery-2.1.1.min.js" type="text/javascript"></script>
	<script src="${path}/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="${path}/layer/layer.js" type="text/javascript"></script>
	<style type="text/css">
		body{background-color: #eee;}
		thead tr th{text-align: center;}
		tbody tr td{text-align: center;}
		table {border-bottom: 1px solid #eee; }
		.checkbox{text-align: center;margin-left: 10px;}
	</style>
</head>
<body>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title">${totalInfo.createtime}缺货单</h3>
		</div>
		<div class="panel-body">
			<%-- <c:if test="${qhd eq '0' && sessionScope.user.usertype ne '1' }">
				<button type="button" class="btn btn-success" onclick="createQhd();">生成缺货单</button>
			</c:if> --%>
			<button type="button" class="btn btn-success" onclick="add();">选择采购市场</button>
		</div>
		<table class="table table-striped table-bordered table-condensed">
			<thead>
				<tr>
					<th width="40">
						<a href="#" onclick="selectAll();">选择</a>
					</th>
					<th>种类</th><th>品级</th><th>三品一标</th>
				</tr>
			</thead>
			<tbody id="tbody">
				<c:if test="${fn:length(purchaseInfos)==0 }">
					<tr><td colspan="4">暂无数据</td></tr>
				</c:if>
				<c:forEach var="item" items="${purchaseInfos}">
					<tr>
						<td align="center">
							<input type="checkbox" id="${item.purchase_id}" class="checkbox" />
						</td>
						<td>${item.kind }</td>
						<td>${item.grade }</td>
						<td>${item.spyb }</td>
					</tr>
				</c:forEach>
			</tbody>
  		</table>
		<div class="panel-footer" style="margin-top: 20px;">
			<button type="button" class="btn btn-default" onclick="back();">返回</button>
		</div>
	</div>
<div style="display:none;padding: 5%;" id="modal_add" >
<form>
  <div class="form-group">
    <label for="sc">采购市场</label>
    <select class="form-control" id="sc">
    	<option value="">请选择</option>
    	<c:forEach items="${baseList}" var="item">
	    	<option value="${item.id }">${item.name}</option>
    	</c:forEach>
    </select>
  </div>
  <div class="form-group" style="text-align: center;">
	  <button type="button" class="btn btn-success" onclick="save();">保存</button>
	  <button type="button" class="btn btn-default" onclick="closeModal();">关闭</button>
  </div>
</form>
</div>
<script type="text/javascript">

function back(){
	window.location.href = '${path}/purchaseInfo/allQhd.do';
}
function select(id){
	window.location.href = '${path}/purchase/addQhPurchase.do?purchase_id='+id;
}
function add(){
	var checkbox = $("input[type=checkbox]:checked");
	if(0==checkbox.length){
		layer.msg('请选择菜品！',{time:1000});
		return;
	}
	layer.open({
		type:'1',
		title:'选择市场',
		closeBtn:1,
		area: ['90%','30%'],
		shadeClose: true,
		content: $('#modal_add')
	})
}
function save(){
	var sc = $("#sc").val();
	if(""==sc){
		layer.msg('请选择市场！',{time:1000});
		return;
	}
	var ids = [];
	var checkbox = $("input[type=checkbox]:checked");
	$.each(checkbox,function(i,o){
		ids.push($(this).attr("id"));
	})
	ids = ids.toString();
	$.ajax({
		type:'post',
		url:'${path}/purchaseInfo/saveQhsc.do',
		data:{'ids':ids,'sc':sc},
		dataType:'json',
		success:function(rs){
			if(null!=rs&&""!=rs){
				rs = $.parseJSON(rs);
				if(rs.code=="200"){
					layer.msg('保存成功！',{time:1000},function(){
						self.location.reload();
					})
				}else if("1"==rs.code){
					layer.msg('保存失败',{time:1000})
				}else{
					layer.msg('保存失败',{time:1000})
				}
				
			}
		}
	})
}

function closeModal(){
	layer.closeAll();
}
var f= 0;
function selectAll(){
	if(f==0){
		$("input[type=checkbox]").prop("checked",true);
		f = 1;
	}else{
		$("input[type=checkbox]").prop("checked",false);
		f = 0;
	}
}

</script>
</body>
</html>
