<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<!DOCTYPE HTML>
<html>
  <head>
    <meta charset="UTF-8">
    <title>${sysname }</title>
    <link rel="stylesheet" href="${path}/layui/css/layui.css">
    <link rel="stylesheet" href="${path}/res/global.css">
    <script type="text/javascript" src="${path}/layui/layui.js"></script>
    <script type="text/javascript" src="${path}/js/commonUtil.js"></script>
  </head>
 <body>
 <div class="layui-tab layui-tab-brief main-tab-container" style="margin-top: 20px;">
  	<ul class="layui-tab-title main-tab-title">
      <div class="main-tab-item">新增进货</div>
    </ul>
     <div class="layui-tab-content" style="margin-top: 40px;margin-left: 200px;">
			<form class="layui-form">
				<div class="layui-tab-item layui-show">
					<input type="hidden" name="id" value="">
					<div class="layui-form-item">
						<label class="layui-form-label">商家名称</label>
						<div class="layui-input-inline input-custom-width">
							<select name="shop_name" id="shop_name">
								<option value="">--请选择--</option>
								<c:forEach var="item" items="${shoplist }">
									<option value="${item.shop_id}/${item.shop_name}">${item.shop_name}</option>
								</c:forEach>
							</select>
						</div>
					</div>

					<div class="layui-form-item">
						<label class="layui-form-label">商品种类</label>
						<div class="layui-input-inline input-custom-width">
							<select name="goods_name" id="goods_name">
								<option value="">--请选择--</option>
								<c:forEach var="item" items="${goodlist }">
									<option value="${item.goods_id}/${item.goods_name}">${item.goods_name}</option>
								</c:forEach>
							</select>
						</div>
					</div>
					
					<div class="layui-form-item">
						<label class="layui-form-label">商品数量</label>
						<div class="layui-input-inline input-custom-width">
							<input type="text" id="goods_num" name="goods_num"
								 autocomplete="off" placeholder="请输入进货数量单位：千克（kg）"
								class="layui-input">
						</div>
					</div>

					<div class="layui-form-item" style="margin-top: 50px;">
						<div class="layui-input-block">
							<button type="button" class="layui-btn" id="saveshopgoods">保存</button>
						</div>
					</div>
				</div>
			</form>
		</div>
 </div>
 <script type="text/javascript">
 layui.use(
		[ 'element', 'form', 'upload', 'layedit', 'laydate' ],function() {
		var element = layui.element(), 
		form = layui.form(), 
		layedit = layui.layedit, 
		laydate = layui.laydate, 
		jq = layui.jquery;
		
	jq("#saveshopgoods").on('click',function(){
		var shopid_temp = jq("#shop_name").val();
		var goodsid_temp = jq("#goods_name").val();
		var goods_num = jq("#goods_num").val();
		if(""==shopid_temp){
			layer.msg('请选择商家名称');
			return;
		}
		if(""==goodsid_temp){
			layer.msg('请选择进货种类');
			return;
		}
		if(""==goods_num){
			layer.msg('请输入进货数量');
			return;
		}else if(goods_num*1<=0){
			layer.msg('进货数量不合法');
			return;
		}
		
		var shop_index= shopid_temp.indexOf("/");
		var shop_id = shopid_temp.substring(0,shop_index);
		var shop_name = shopid_temp.substring(shop_index+1,shopid_temp.length);
		var goods_index = goodsid_temp.indexOf("/");
		var goods_id = goodsid_temp.substring(0,goods_index);
		var goods_name = goodsid_temp.substring(goods_index+1,goodsid_temp.length);
		jq.ajax({
			url : '${path}/shopgoods/addSave.do',
			type : 'post',
			data:{'shop_id':shop_id,'shop_name':shop_name,'goods_id':goods_id,'goods_name':goods_name,'goods_num':goods_num},
			dataType : 'json',
			success : function(rs) {
				rs = eval("(" + rs + ")");
				layer.msg(rs.msg,{time:1000}, function() {
					self.location.reload();
				});
			}
		})
	});
 })
 </script>
 </body>
</html>
