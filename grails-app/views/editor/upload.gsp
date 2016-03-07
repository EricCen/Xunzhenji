<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>微信公众平台</title>
    <meta name="layout" content="empty"/>
    <meta http-equiv="MSThemeCompatible" content="Yes" />
    <asset:stylesheet href="style_2_common.css"/>
    <asset:stylesheet href="cymain.css"/>
    <g:javascript library="jquery" />
</head>
<body style="background:#fff">
    <div style="background:#fefbe4;border:1px solid #f3ecb9;color:#993300;padding:10px;width:90%;margin:40px auto 5px auto;">选中文件后点击上传按钮或者点击“从素材库选择”直接从已上传文件中选择</div>
    <g:form enctype="multipart/form-data" action="fileUpload" controller="editor" method="POST" style="font-size:14px;padding:30px 20px 10px 20px;">
        <p id="picsize" style="margin-bottom:20px"></p>
        <p><div style="font-size:14px;">选择本地文件：<br><br>
        <input type="file" style="width:90%;border:1px solid #ddd" name="imgFile"></input></div>
        <div style="padding:50px 0;text-align:center;">
            <input id="submitbtn" name="doSubmit" type="submit" class="btnGreen" value="上传" onclick="this.value='上传中...'" />
            <input name="btnchoose" onclick="location.href='{pigcms::U('Attachment/my',array('type'=>'my'))}'" type="button" class="btnGreen" value="从素材库选择" />
        </div></p>
    </g:form>


<asset:javascript src="common.js"/>
<script src="/artDialog/jquery.artDialog.js?skin=default"></script>
<script src="/artDialog/plugins/iframeTools.js"></script>
<script>
    var domid=art.dialog.data('domid');
    // 返回数据到主页面
    function returnHomepage(url){
        var origin = artDialog.open.origin;
        var dom = origin.document.getElementById(domid);
        var domsrcid=domid+'_src';

        if(origin.document.getElementById(domsrcid)){
            origin.document.getElementById(domsrcid).src=url;
        }

        dom.value=url;
        setTimeout("art.dialog.close()", 1500 )
    }
</script>
<script>
    if (art.dialog.data('width')) {
        var w = art.dialog.data('width');// 获取由主页面传递过来的数据
        var h = art.dialog.data('height');
        if(w){
            jQuery('#picsize').html('<span style="color:#930; font-size:14px;margin-bottom:20px;">图片最佳尺寸：宽'+w+'px 高 '+h+'px</span>');
        }else{
            jQuery('#picsize').html('<span style="color:red; font-size:14px;margin-bottom:20px;">图片宽高不限</span>');
        }
    }else{
        //alert('d');
    }
</script>
</body>
</html>