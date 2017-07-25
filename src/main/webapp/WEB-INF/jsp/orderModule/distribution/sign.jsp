<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../common/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>签名</title>
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="apple-mobile-web-app-status-bar-style" content="black"> 
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="format-detection" content="telephone=no">
	<link href="${path}/css/bootstrap.css" rel="stylesheet" media="screen">
	<script src="${path}/js/mui.min.js" type="text/javascript"></script>
	<script src="${path}/js/jquery.js" type="text/javascript"></script>
	<script src="${path}/js/jq-signature.js" type="text/javascript"></script>
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
		<!-- <div class="panel-heading">
			<h3 class="panel-title">待收确认</h3>
		</div> -->
		<div class="panel-body">
			<div class="js-signature"
			     data-width="200"
			     data-height="200"
			     data-border="1px solid #1ABC9C"
			     data-background="#16A085"
			     data-line-color="#fff"
			     data-auto-fit="true">
			</div> 
		</div>
		<div class="panel-footer" style="margin-top: 20px;">
			<input id="clearBtn" type="button" class="btn btn-warning" onclick="clearCanvas();" value="清除">
			<input id="saveBtn" type="button" class="btn btn-primary" value="保存" onclick="saveSignature();">
			<button type="button" class="btn btn-default" onclick="back();">关闭</button>
		</div>
	</div>
<script type="text/javascript">
$(document).on('ready', function() {
	  $('.js-signature').jqSignature();
	});
	 
	function clearCanvas() {
	  //$('#signature').html('<p><em>Your signature will appear here when you click "Save Signature"</em></p>');
	  $('.js-signature').jqSignature('clearCanvas');
	  $('#saveBtn').attr('disabled', true);
	}
	 
	function saveSignature() {
	  var dataUrl = $('.js-signature').jqSignature('getDataURL');
	  //$('#signature').empty();
	  //var img = $('<img>').attr('src', dataUrl);
	  //$('#signature').append($('<p>').text("Here's your signature:"));
	  //$('#signature').append(img);
	  if(""!=dataUrl){
		  $.ajax({
			  type:'post',
			  url:'${path}/distribution/signSave.do',
			  data:{'time':'${time}','baseid':'${baseid}','signname':dataUrl},
			  dataType:'json',
			  success:function(rs){
				  if(""!=rs){
					  rs = $.parseJSON(rs);
					  if("200"==rs.code){
						  layer.msg('签名成功！',{time:1000},function(){
							  window.parent.closeModal();
						  })
					  }else{
						  layer.msg('签名失败，请联系管理员！',{time:1000})
					  }
					  
				  }
			  }
			  
		  })
	  }else{
		  layer.msg('请进行签名确认！',{time:1000});
	  } 
	}
	 
	$('.js-signature').on('jq.signature.changed', function() {
	  $('#saveBtn').attr('disabled', false);
	}); 
	function back(){
		window.parent.closeModal();
	}

</script>
</body>
</html>
