<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>微信公众平台</title>
    <meta http-equiv="MSThemeCompatible" content="Yes" />
    <asset:stylesheet href="style_2_common.css?BPm" />
    <asset:stylesheet href="style.css" />
    <asset:stylesheet href="cymain.css" />

    <style>
        body{line-height:180%;}
        ul.modules li{padding:4px 10px;margin:4px;background:#efefef;float:left;width:27%;}
        ul.modules li div.mleft{float:left;width:40%}
        ul.modules li div.mright{float:right;width:55%;text-align:right;}
    </style>
    <g:javascript library="jquery" />
    <r:layoutResources/>
</head>
<body style="background:#fff;padding:20px 20px;">
<div style="background:#fefbe4;border:1px solid #f3ecb9;color:#993300;padding:10px;margin-bottom:5px;">使用方法：点击对应内容后面的“选中”即可。</div>
<h4>图文消息列表</h4>
<table class="ListProduct" border="0" cellSpacing="0" cellPadding="0" width="100%">
    <thead>
    <tr>
        <th>标题</th>
        <th style=" width:80px;">操作 <span class="tooltips" ><asset:image src="price_help.png" align="absmiddle"/><span>
            <p>点击“选中”即可</p>
        </span></span></th>
    </tr>
    </thead>
    <g:if test="${images}">
        <g:each in="${images}" var="image">
            <tr>
                <td>${image.title}</td>
                <td class="norightborder">
                    <a href="###" onclick="returnHomepage(${image.id},'${image.title}','${image.pic?.url}','${image.digest}')">选中</a>
                </td>
            </tr>
        </g:each>
        <g:each in="${multiImages}" var="multiImage">
            <tr>
                <td>${multiImage.images.collect{it.title}.join(' ')}</td>
                <td class="norightborder">
                    <a href="###" onclick="returnHomepage(${multiImage.id},'${multiImage.images.collect{it.title}.join(' ')}','${multiImage.images[0]?.pic}','${multiImage.images[0]?.digest}')">选中</a>
                </td>
            </tr>
        </g:each>
    </g:if>
    <g:else>
        <tr><td colspan="2" align="center"><g:link controller="image" action="add" target="_blank" style="color:#369">还没有图文消息，请点击这里添加图文消息</g:link></td></tr>
    </g:else>
</table>
<div class="footactions" style="padding-left:10px">
    <div class="pages"></div>
</div>

<asset:javascript src="common.js" />
<script src="/artDialog/jquery.artDialog.js?skin=default"></script>
<script src="/artDialog/plugins/iframeTools.js"></script>.
<script>
    var titledom=art.dialog.data('titledom');
    var imgids=art.dialog.data('imgids');
    // 返回数据到主页面
    function returnHomepage(id,title,pic,info){

        var origin = artDialog.open.origin;
        var dom = origin.document.getElementById(titledom);
        var imgidsdom = origin.document.getElementById(imgids);
        var multinews= origin.document.getElementById(art.dialog.data('multinews'));
        var singlenews= origin.document.getElementById(art.dialog.data('singlenews'));
        var multione= origin.document.getElementById(art.dialog.data('multione'));
        var js_appmsg_preview= origin.document.getElementById(art.dialog.data('js_appmsg_preview'));
        //dom.value+=','+url;
        imgCount=imgidsdom.value.split(',').length-1;
        //
        dom.innerHTML='<div class="mediaPanel"><div class="mediaHead"><span class="title" id="zbt">'
                +title+'</span><span class="time">${org.apache.commons.lang.time.DateFormatUtils.format(new Date(), 'yyyy-MM-dd')}</span><div class="clr"></div></div><div class="mediaImg"><img id="suicaipic1" src="'
        +pic+'"></div><div class="mediaContent mediaContentP"><p id="zinfo">'
        +info+'</p></div><div class="mediaFooter"><span class="mesgIcon right"></span><span style="line-height:50px;" class="left">查看全文</span><div class="clr"></div></div></div>';

        if(multione.innerHTML.trim()==''){
            singlenews.style.display="";
            multinews.style.display="none";

            multione.innerHTML=' <h4 class="appmsg_title"><a href="javascript:void(0);" onClick="return false;" target="_blank">'+title+'</a></h4><div class="appmsg_thumb_wrp"><img style="border:1px solid #ddd" class="js_appmsg_thumb appmsg_thumb" src="'+pic+'"><i class="appmsg_thumb default" style="background:url('+pic+');background-size:100% 100%">&nbsp;</i></div>';

        }else{
            singlenews.style.display="none";
            multinews.style.display="";
            js_appmsg_preview.innerHTML=js_appmsg_preview.innerHTML+'<div id="appmsgItem4" data-fileid="" data-id="4" class="appmsg_item js_appmsg_item "><img class="js_appmsg_thumb appmsg_thumb" src="'+pic+'"><i class="appmsg_thumb default" style="background:url('+pic+');background-size:100% 100%">&nbsp;</i><h4 class="appmsg_title"><a onClick="return false;" href="javascript:void(0);" target="_blank">'+title+'</a></h4></div>';
        }
        dom.style.display="";
        imgidsdom.value+=','+id;
        setTimeout("art.dialog.close()", 100 )
    }
</script>
</body>
</html>