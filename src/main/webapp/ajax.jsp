<!DOCTYPE html>
<html>
<head>
    <title>Ajax Demo</title>
    <!-- 声明文档使用的字符编码 -->
    <meta charset='utf-8'>
    <!-- 优先使用 IE 最新版本和 Chrome -->
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <script type="text/javascript" src="./js/jquery.min.js"></script>
    <script type="text/javascript">

        function getRequest() {
            var xmlHttp = null;
            try {// Chrome, Firefox, Opera, Safari
                xmlHttp = new XMLHttpRequest();
            } catch (e) {
                try {// Internet Explorer
                    xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
                } catch (e) {
                    try {// Internet Explorer
                        xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
                    } catch (e) {
                        alert("your browser not support ajax!");
                    }
                }
            }
            return xmlHttp;
        }

        function doGet(url){ 
            var xmlHttp = getRequest(); //初始化xmlhttp对象
            console.log(xmlHttp);
            xmlHttp.open("GET",url); 
            xmlHttp.send(); 
            xmlHttp.onreadystatechange = function() { 
            if ((xmlHttp.readyState == 4) && (xmlHttp.status == 200)) { 
                console.log("success"); 
            } else { 
                console.log("fail"); 
            } 
            } 
        } 
        function doPost(url,data){ 
            // 注意在传参数值的时候最好使用encodeURI处理一下，以防出现乱码 
            createxmlHttpRequest(); 
            xmlHttp.open("POST",url); 
            xmlHttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded"); 
            xmlHttp.send(data); 
            xmlHttp.onreadystatechange = function() { 
                if ((xmlHttp.readyState == 4) && (xmlHttp.status == 200)) { 
                    console.log("success"); 
                } else { 
                    console.log("fail"); 
                } 
            } 
        } 
    </script>
</head>
<body>

</body>
</html>