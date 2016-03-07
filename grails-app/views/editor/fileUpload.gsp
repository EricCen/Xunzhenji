<%--
  Created by IntelliJ IDEA.
  User: Kevin
  Date: 2015/5/8
  Time: 17:09
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>上传结果</title>
    <meta name="layout" content="empty"/>
    <r:require module="jquery"/>
    <r:layoutResources />

</head>

<body>
    <script src="/artDialog/jquery.artDialog.js?skin=default"></script>
    <script src="/artDialog/plugins/iframeTools.js"></script>

    <script>
        var mediaId=art.dialog.data('mediaId');
        var imgId=art.dialog.data('imgId');
        // 返回数据到主页面
        function returnHomepage(id, url){
            var origin = artDialog.open.origin;
            var mediaIdDom = origin.document.getElementById(mediaId);
            var imgIdDom = origin.document.getElementById(imgId);
            var mediasrcid=mediaId+'_src';
            var imgsrcid=imgId+'_src';

            if(origin.document.getElementById(mediasrcid)){
                origin.document.getElementById(mediasrcid).src=id;
            }

            if(origin.document.getElementById(imgsrcid)){
                origin.document.getElementById(imgsrcid).src=url;
            }

            mediaIdDom.value=id;
            imgIdDom.src=url;
            setTimeout("art.dialog.close()", 1500 )
        }
    </script>
        <g:if test="${error}">
            <div style="text-align: center; color: red"><b>上传失败</b></div>
            <script>
                setTimeout("history.go(-1);", 1500 );
            </script>
        </g:if> <g:if test="${!error}">
            <div style="text-align: center;"><b>上传成功</b></div>
            <script>
                returnHomepage('${id}','${url}');
            </script>
        </g:if>

</body>
</html>