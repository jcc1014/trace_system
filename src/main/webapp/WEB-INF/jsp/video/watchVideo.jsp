<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
    <title>${sysname}</title>
   <link rel="stylesheet" href="${path}/layui/css/layui.css">
    <link rel="stylesheet" href="${path}/res/global.css">
    <link href="${path}/js/videojs/css/video-js.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="${path}/layui/layui.js"></script>
    <script type="text/javascript" src="${path}/js/commonUtil.js"></script>
	<script src="${path}/js/videojs/js/video.js"></script>
	<script>
    videojs.options.flash.swf = "video-js.swf";
    var myPlayer = videojs('video_1');
    videojs("video_1").ready(function(){
        var myPlayer = this;
        myPlayer.play();
    });
	</script>
</head>
<body>
<video id="video_1" class="video-js vjs-default-skin" controls preload="none" width="400" height="300"
      poster=""
      data-setup="{}">
    <source src="${path}/video/${video}" type='video/mp4' />
    <source src="${path}/video/${video}" type='video/webm' />
    <source src="${path}/video/${video}" type='video/ogg' />
    <source src="${path}/video/${video}" type='video/mov' />
    <source src="${path}/video/${video}" type='video/avi' />
    <source src="${path}/video/${video}" type='video/3GP' />
    <track kind="captions" src="demo.captions.vtt" srclang="en" label="English"></track><!-- Tracks need an ending tag thanks to IE9 -->
    <track kind="subtitles" src="demo.captions.vtt" srclang="en" label="English"></track><!-- Tracks need an ending tag thanks to IE9 -->
</video>
</body>
</html>