<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../common/common.jsp" %>
<!DOCTYPE HTML>
<html>
  <head>
    <meta charset="UTF-8">
    <title>${sysname }</title>
    <link rel="stylesheet" href="${path}/layui/css/layui.css">
    <link rel="stylesheet" href="${path}/res/global.css">
    <link rel="stylesheet" href="${path}/res/bootstrap.min.css">
    <link rel="stylesheet" href="${path}/res/city-picker.css">
    <script type="text/javascript" src="${path}/layui/layui.js"></script>
    <script type="text/javascript" src="${path}/js/commonUtil.js"></script>
    <script type="text/javascript" src="${path}/js/jquery.min.js"></script>
    <style type="text/css">
    	input{width: 100px;}
    </style>
  </head>
 <body>
<div class="layui-tab layui-tab-brief main-tab-container" style="margin-top: 20px;">
  	<ul class="layui-tab-title main-tab-title">
      <div class="main-tab-item">生产基地信息</div>
    </ul>
    <div class="layui-tab-content">
      <div class="layui-tab-item layui-show">
      <!-- 搜索 -->
      <form class="layui-form layui-form-pane search-form" action="">
        <div class="layui-form-item">
          <%-- <label class="layui-form-label">商家名称</label>
          <div class="layui-input-inline">
            <input type="text" style="display: inline-block;" name="shopname" id="shopname" value="${shopname}" placeholder="请输入商家名称搜索" autocomplete="off" class="layui-input">
          </div>
          <button class="layui-btn" id="search">搜索</button> --%>
          <%-- <c:if test="${produce_parent_id != null && produce_parent_id ne '' }">
	          <button class="layui-btn" type="button" disabled="disabled" data-id="${produce_parent_id }">已生成供应单</button>
          </c:if>
          <c:if test="${produce_parent_id == null || produce_parent_id eq '' }">
	          <button class="layui-btn" type="button" onclick="create(this);" data-id="${produce_parent_id }">生成供应单</button>
          </c:if> --%>
          <button class="layui-btn" type="button" onclick="addRow();">新增</button>
        </div>
      </form>
      <form class="layui-form">
        <table class="list-table">
          <thead>
            <tr>
              <td align="center" width="10%">日期</td>
              <td align="center" width="15%">基地名称</td>
              <td align="center" width="15%">基地地址</td>
              <td align="center" width="10%">种类</td>
              <td align="center" width="10%">品级</td>
              <td align="center" width="10%">供应量</td>
              <td align="center" width="10%">单位</td>
              <td align="center" width="10%">价格</td>
              <td align="center" width="10%">操作</td>
            </tr> 
          </thead>
          <tbody>
          	<c:forEach var="item" items="${producelist}" varStatus="index">
          		<tr id="${item.shop_id}" align="center">
          			<td align="center">${fn:substring(item.createtime,0,10)}</td>
          			<td align="center">${item.produce_name}</td>
          			<td align="center">${item.produce_place}</td>
          			<td align="center">${item.type}</td>
          			<td align="center">${item.grade} </td>
          			<td align="center">${item.supply_number}</td>
          			<td align="center">${item.dw}</td>
          			<td align="center">${item.price}</td>
          			<td style="text-align: center;">
          				<!-- <a class="layui-btn layui-btn-small layui-btn-warm detail_btn" title="详细信息" 
          				href="javascript:;" >
          					<i class="layui-icon">&#xe63c;</i>
          				</a> -->
			          <a class="layui-btn layui-btn-small layui-btn-danger del_btn"
			             onclick="del('${item.produce_id}');"  title="删除"><i class="layui-icon"></i></a> 
		            </td> 
          		</tr>
          	</c:forEach>
          		<tr id="template" align="center" class="hide">
          			<td align="center">${nowDate}</td>
          			<td align="center"><input type="text" class="produce_name" placeholder="生产基地名称"/></td>
          			<td align="center"><input type="text" class="produce_place" placeholder="生产基地地址"/></td>
          			<td align="center">
          				<%-- <select class="type">
          					<c:forEach items="${goodsList}" var="t">
          						<option value="${t.goods_name }">${t.goods_name }</option>
          					</c:forEach>
          				</select> --%>
          				<input type="text" class="type" placeholder="种类"/>
          			</td>
          			<td align="center"><input type="text" class="grade" placeholder="品级"/></td>
          			<td align="center"><input type="number" class="supply_number" placeholder="供应量"/></td>
          			<td align="center"><input type="text" class="dw" placeholder="单位"/></td>
          			<td align="center"><input type="number" class="price" placeholder="价格"/></td>
          			<td style="text-align: center;">
			          <a class="layui-btn layui-btn-small layui-btn-danger del_btn"
			             onclick="delRow(this);"  title="删除">删除</a> 
			          <a class="layui-btn layui-btn-small layui-btn-danger del_btn"
			             onclick="save(this);"  title="保存">保存</a> 
		            </td> 
          		</tr>
          </tbody>
        </table>
      </form>
      </div>
    </div>
</div>
<script type="text/javascript">
var num = parseInt('${num}');
var curr = parseInt('${curr}');
layui.use(
		[ 'element', 'form','laypage', 'upload', 'layedit', 'laydate' ],function() {
		var element = layui.element(), 
		form = layui.form(), 
		laypage = layui.laypage,
		layedit = layui.layedit, 
		laydate = layui.laydate, 
		jq = layui.jquery;
		
})

function addRow(){
	var tr = $("#template").clone();
	$("#template").before(tr).prev().attr("id","").removeClass("hide");
}

function del(id){
	$.ajax({
		type:'post',
		url:'${path}/produce/delete.do',
		data:{'produce_id':id},
		dataType:'json',
		success:function(rs){
			if(""!=rs){
				rs = $.parseJSON(rs);
				if(rs.code=="200"){
					layer.msg('删除成功！',{time:1000},function(){
						self.location.reload();
					})
				}else{
					layer.msg('删除失败！',{time:1000},function(){
						self.location.reload();
					})
				}
			}
		},
		error:function(){
			layer.msg('出错了！');
		}
	})
}

function delRow(obj){
	var _this = $(obj);
	var tr = _this.parent().parent();
	tr.remove();
}

function save(obj){
	var _this = $(obj);
	var tr = _this.parent().parent();
	var produce_name = tr.find(".produce_name").val();
	var produce_place = tr.find(".produce_place").val();
	var type = tr.find(".type").val();
	var grade = tr.find(".grade").val();
	var supply_number = tr.find(".supply_number").val();
	var price = tr.find(".price").val();
	var dw = tr.find(".dw").val();
	$.ajax({
		type:'post',
		url:'${path}/produce/addSave.do',
		dataType:'json',
		data:{'produce_name':produce_name,'produce_place':produce_place,'type':type,
			'grade':grade,'supply_number':supply_number,'price':price,'dw':dw},
		success:function(rs){
			if(""!=rs){
				rs = $.parseJSON(rs);
				if(rs.code=="200"){
					layer.msg('保存成功！',{time:1000},function(){
						self.location.reload();
					})
				}else{
					layer.msg('保存失败！',{time:1000},function(){
						self.location.reload();
					})
				}
			}
		},
		error:function(){
			layer.msg('出错了！');
		}
	})
}
</script>
</body>
</html>
