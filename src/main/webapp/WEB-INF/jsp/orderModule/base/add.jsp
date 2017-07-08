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
    <script type="text/javascript" src="${path}/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${path}/js/citypicker/city-picker.data.js"></script>
    <script type="text/javascript" src="${path}/js/citypicker/city-picker.js"></script>
    <!-- 百度地图api 秘钥=DD279b2a90afdf0ae7a3796787a0742e -->
    <script src="http://api.map.baidu.com/api?v=2.0&ak=DD279b2a90afdf0ae7a3796787a0742e" type="text/javascript"></script>
  </head>
 <body>
 <div class="layui-tab layui-tab-brief main-tab-container" style="margin-top: 20px;">
  	<ul class="layui-tab-title main-tab-title">
      <div class="main-tab-item">新增需求方信息</div>
    </ul>
    
    <div class="layui-tab-content" style="margin-top: 40px;margin-left: 200px;">
			<form class="layui-form">
				<div class="layui-tab-item layui-show">
					<input type="hidden" name="id" value="">
					<div class="layui-form-item">
						<label class="layui-form-label">类型</label>
						<div class="layui-input-inline input-custom-width">
							<select name="type" id="type">
								<option value="1">生产基地</option>
								<option value="5">供应基地</option>
								<option value="2">超市</option>
								<option value="3">食堂</option>
								<option value="4">孟鑫</option>
							</select>
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">名称</label>
						<div class="layui-input-inline input-custom-width">
							<input type="text" id="name" name="name"
								 autocomplete="off" placeholder="请输入名称"
								class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">代码</label>
						<div class="layui-input-inline input-custom-width">
							<input type="text" id="code" name="code"
								 autocomplete="off" placeholder="请输入名称代码（拼音首字母）"
								class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">负责人</label>
						<div class="layui-input-inline input-custom-width">
							<input type="text" id="username" name="username"
								 autocomplete="off" placeholder="请输入负责人"
								class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">手机</label>
						<div class="layui-input-inline input-custom-width">
							<input type="text" id="phone" name="phone"
								 autocomplete="off" placeholder="请输入手机"
								class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">地址</label>
						<div class="layui-input-inline input-custom-width">
							<input type="text" id="address" name="address"
								 autocomplete="off" placeholder="请输入地址"
								class="layui-input">
						</div>
					</div>
					<!-- <div class="layui-form-item">
                        <label class="layui-form-label">上传图片</label>
                        <div class="layui-input-inline" style="width:113px;">
						    <input type="file" name="file" id="upload" class="layui-upload-file">
                        </div>
					</div>
                   <div class="layui-form-item" id="pic_display" style="display: none">
                            <label class="layui-form-label">已传图片</label>
                   </div>
					<div class="layui-form-item" id="pic_display">
						<label class="layui-form-label">已传图片</label>
						<div id="picDiv" class="layui-input-block">
							<input type="hidden" id="shop_pic" name="shop_pic" value="">
							<input type="hidden" id="real_path" name="real_path" value="">
							<img class="input-custom-width" src="" id="picImg"/> <a
								style="margin-left: 10px"
								class="layui-btn layui-btn-small layui-btn-danger del_btn hide"
								 title="删除"> <i class="layui-icon"></i>
							</a>
							<div style="min-height: 10px"></div>
						</div>
					</div> -->

					<div class="layui-form-item" style="margin-top: 50px;">
						<div class="layui-input-block">
							<button type="button" class="layui-btn" id="save_btn">保存</button>
							<button type="button" class="layui-btn layui-btn-primary" onclick="back();">返回</button>
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
		
	jq("#save_btn").on('click',function(){
		var type = jq("#type").val();
		var name = jq("#name").val();
		var code = jq("#code").val();
		var phone = jq("#phone").val();
		var address = jq("#address").val();
		var username = jq("#username").val();
		if(type==null || type=="" || type==undefined){
			 layer.msg('请选择类型',{time:1000});
			 return;
		}
		var usertype = "A";
		if(type !="1" && type !="5"){
			usertype = "B";
		}
		if(name==null || name=="" || name==undefined){
			 layer.msg('请输入名称',{time:1000});
			 return;
		}
		if(code==null || code=="" || code==undefined){
			 layer.msg('请输入代码',{time:1000});
			 return;
		}
		if(username==null || username=="" || username==undefined){
			 layer.msg('请输入负责人名称',{time:1000});
			 return;
		}
		if(phone==null || phone==""){
			 layer.msg('请输入负责人手机',{time:1000});
			 return;
		}
		if(!isTelephone(phone)){
			 layer.msg('负责人电话不合法',{time:1000});
			 return;
		}
		if(address==null || address=="" || address==undefined){
			layer.msg('请填写详细地址');
			return;
		}
		var re =/^[a-z\d\u4E00-\u9FA5]+$/i;
		if(!re.test(address)){
			layer.msg('详细地址不可包含特殊字符');
			return;
		}
		jq.ajax({
			url : '${path}/baseInfo/addSave.do',
			type : 'post',
			data:{'type':type,'address':address,'name':name,'code':code,
				'username':username,'phone':phone,'usertype':usertype},
			dataType : 'json',
			success : function(rs) {
				rs = eval("(" + rs + ")");
				if("200"==rs.code){
					layer.msg("新增成功！管理人为"+username+",</br>登录密码为000000",{time:2000}, function() {
						self.location.reload();
					});
				}
			}
		})
	});
})

function closeLayer(){
	layer.closeAll();
}

function back(){
	window.location.href = "${path}/baseInfo/list.do";
}

$("#username").blur(function(){
	var username = $("#username").val();
	$.ajax({
		url : '${path}/shop/checkUser.do',
		type : 'post',
		data:{'username':username},
		dataType : 'json',
		success : function(rs) {
			rs = eval("(" + rs + ")");
			if("200"==rs.code){
				layer.msg("负责人名称可用！",{time:1000});
			}
			else{
				layer.msg("负责人名称已被占用！",{time:1000},function(){
					$("#username").val("").focus();
				});
			}
		}
	})
})
</script>
</body>
</html>
