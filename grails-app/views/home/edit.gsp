
<%@ page import="org.apache.tools.ant.util.DateUtils" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="admin"/>
    <title>首页编辑器</title>
    <link rel="stylesheet" href="/kindeditor/themes/default/default.css" />
    <link rel="stylesheet" href="/kindeditor/plugins/code/prettify.css" />
    <asset:stylesheet href="upload.css"/>
</head>
<body>
<div class="content">
<div class="cLineB"><h4>编辑首页内容</h4><a href="javascript:history.go(-1);"  class="right btnGrayS vm" style="margin-top:-27px" >返回</a></div>

<g:form method="post" action="save">
    <div class="msgWrap form">
        <TABLE class="userinfoArea" border="0" cellSpacing="0" cellPadding="0" width="100%">
            <TBODY>
            <TR>
                <TH style="width:120px" valign="top"><span class="red">*</span><label for="title">浏览器标题：</label>
                    <g:hasErrors bean="${homePage}" field="title">
                        <g:eachError bean="${homePage}" field="title">
                            <br/><p style="color: red;"><g:message error="${it}"/></p>
                        </g:eachError>
                    </g:hasErrors>
                </TH>
                <TD><input type="text" class="px" id="keywords" value="${homePage.title}"  name="title" style="width:580px;"></TD>
            </TR>
            <TR>
                <TH valign="top"><span class="red">*</span>图片：</TH>
                <TD>
                    <div class="form-ele fileupload-container" id="fileupload-container-image">
                        <g:each in="${homePage.images}" var="image">
                            <div class="uploaded-img">
                                <img style="max-width:200px;" src="${image.url}" data-url="${image.deleteUrl}" id="${image.id}">
                            </div>
                        </g:each>
                        <div class="fileupload-block" for="fileupload" style="display:none">
                            <p>拖拽图片放在此处上传</p>
                            <span>或者</span>
                            <span>点击此处上传</span>
                        </div>
                    </div>
                </TD>
            </TR>
            <TR>
                <TH><span class="red">*</span><label for="productList">商品列表：</label>
                    <g:hasErrors bean="${homePage}" field="productList">
                        <g:eachError bean="${homePage}" field="productList">
                            <br/><p style="color: red;"><g:message error="${it}"/></p>
                        </g:eachError>
                    </g:hasErrors></TH>
                <TD><input type="text" class="px" id="productList" value="${homePage.title}"    name="productList" style="width:580px;">
                </TD>
            </TR>
            <TR>
                <TH><span class="red">*</span><label for="content">页面内容：</label>
                    <g:hasErrors bean="${homePage}" field="content">
                        <g:eachError bean="${homePage}" field="content">
                            <br/><p style="color: red;"><g:message error="${it}"/></p>
                        </g:eachError>
                    </g:hasErrors></TH>
                <TD><textarea name="content" id="content"  rows="5" style="width:590px;height:360px">${homePage.content}</textarea></TD>
            </TR>
            <TR>
                <input value="1" name="texttype" type="hidden">
                <TH></TH>
                <TD><input type="submit" value="保存" name="sbmt" class="btnGreen left">
                &nbsp;&nbsp;&nbsp;
                    <g:link action="index" class="btnGray vm">取消</g:link></TD>
            </TR>
            </TBODY>
        </TABLE>

    </div>
</g:form>

</div>

<div class="clr"></div>

<asset:javascript src="jquery.iframe-transport.js" />
<asset:javascript src="jquery.fileupload.js" />
<asset:javascript src="utilities.js" />
<script src="/kindeditor/kindeditor.js" type="text/javascript"></script>
<script src="/kindeditor/lang/zh_CN.js" type="text/javascript"></script>
<script src="/kindeditor/plugins/code/prettify.js" type="text/javascript"></script>
<asset:javascript src="upyun.js?${org.apache.commons.lang.time.DateFormatUtils.format(new Date(), "yyyyMMddHHmmss")}" />
<r:script>
    var editor;
    KindEditor.ready(function(K) {
        editor = K.create('#content', {
            filterMode: false,
            resizeType : 1,
            allowPreviewEmoticons : false,
            allowImageUpload : true,
            postParams:{'uid':"<sec:loggedInUserInfo field="id" />"},
            uploadJson : '/upload/fileUpload',
            items : [
                'source','fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
                'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
                'insertunorderedlist', '|', 'emoticons', 'image', 'link', 'music', 'video','diyTool']
        })
    });

    $(document).ready(function(e) {
		initFileUpload('fileupload-container-image', 'image', 5);
	});
</r:script>
</body>
</html>
