%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%

<%@ page import="net.xunzhenji.About" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="admin">
    <g:set var="entityName" value="${message(code: 'about.label', default: 'About Us')}"/>
    <title><g:message code="default.edit.label" args="[entityName]"/></title>
</head>

<body>
<div class="content">
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <div class="cLineB">
        <h4><g:message code="default.edit.label" args="[entityName]"/></h4>
        <a href="javascript:history.go(-1);" class="right btnGrayS vm" style="margin-top:-27px">返回</a>
    </div>

    <g:form method="post" action="save">
        <div class="msgWrap form">
            <div class="table userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
                <div class="tr">
                    <div class="th">
                        <label><g:message code="default.images.label" default="图片列表"/><span
                                class="required-indicator">*</span><br>
                            <span style="font-size: 0.5em">最佳显示尺寸：640*480</span>
                        </label>
                    </div>

                    <div class="td">
                        <div class="form-ele fileupload-container" id="fileupload-container-image">
                            <g:each in="${aboutPage.images}" var="image">
                                <div class="uploaded-img">
                                    <img style="max-width:200px;" src="${image.url}" data-url="${image.deleteUrl}"
                                         id="${image.id}">
                                </div>
                            </g:each>
                            <div class="fileupload-block" for="fileupload" style="display:none">
                                <p>拖拽图片放在此处上传</p>
                                <span>或者</span>
                                <span>点击此处上传</span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="tr">
                    <div class="th">
                        <label for="content"><g:message code="default.content.label" default="Detail Content"/><span
                                class="required-indicator">*</span></label>
                    </div>

                    <div class="td">
                        <textarea name="content" id="content" rows="5"
                                  style="width:590px;height:360px">${aboutPage.content}</textarea>
                    </div>
                </div>

                <div class="tr">
                    <div class="th"></div>

                    <div class="td">
                        <input type="submit" value="保存" name="sbmt" class="btnGreen left">
                        &nbsp;&nbsp;&nbsp;
                        <g:link action="index" class="btnGray vm">取消</g:link>
                    </div>
                </div>
            </div>

        </div>
    </g:form>

</div>

<script src="/kindeditor/kindeditor.js" type="text/javascript"></script>
<script src="/kindeditor/lang/zh_CN.js" type="text/javascript"></script>
<script src="/kindeditor/plugins/code/prettify.js" type="text/javascript"></script>
<script src="/kindeditor/plugins/filemanager/filemanager.js" type="text/javascript"></script>

<asset:javascript src="jquery.lazyload.js"/>
<asset:javascript src="jquery.iframe-transport.js"/>
<asset:javascript src="jquery.fileupload.js"/>
<asset:javascript src="utilities.js"/>
<asset:stylesheet href="upload.css"/>

<r:script>
    var editor;
    KindEditor.ready(function(K) {
        editor = K.create('#content', {
            filterMode: false,
            resizeType : 1,
            allowPreviewEmoticons : false,
            fileManagerJson : '../fileManager/${aboutPage.id}',
            allowFileManager: true,
            postParams:{'uid':"<sec:loggedInUserInfo field="id"/>"},
            uploadJson : '/upload/fileUpload',
            items : [
                'source','preview','|','fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
                'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
                'insertunorderedlist', '|', 'emoticons','filemanager']
        })
    });

    $(document).ready(function(e) {
		initFileUpload('fileupload-container-image', 'image', 5);
		$("img.lazy").lazyload({
			threshold : 200
		});
	});
</r:script>
</body>
</html>
