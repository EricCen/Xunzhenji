<%@ page import="net.xunzhenji.QrCodeSetting" %>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="batch"><g:message code="batch.label" default="Batch"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:select id="batch" name="batch.id" from="${net.xunzhenji.mall.Batch.list()}" optionKey="id" required=""
                      value="${qrCodeSettingInstance?.batch?.id}" class="many-to-one"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="title"><g:message code="default.title.label" default="标题"/></label>
        </th>
        <td><g:textField name="title" id="title" class="px" value="${qrCodeSettingInstance.title}" /></td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="openIds">OpenIds</label>
        </th>
        <td><g:textArea name="openIds" id="openIds" rows="5" style="width:590px;height:100px;border: ridge;">${openIds}</g:textArea>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="variable"><g:message code="qrCodeSetting.variable.label" default="Variable"/></label>
        </th>
        <td><g:textArea rows="5" style="width:580px;border: ridge;" name="variable" required=""
                        value="${qrCodeSettingInstance?.variable}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label><g:message code="default.images.label" default="图片列表"/><span
                    class="required-indicator">*</span><br>
                <span style="font-size: 0.5em">最佳显示尺寸：640*480</span>
            </label>
        </th>
        <td style="display: flex;">
            <g:each in="${qrCodeSettingInstance.images?.sort{it.order}}" var="image">
                <div class="uploaded-img">
                    <div>
                        <label for="image_order_${image.id}">顺序:</label>
                        <input class="px" type="number" name="image_order_${image.id}" value="${image.order}">
                    </div>
                    <div>
                        <label>水印位置:</label>
                        <a onclick="changeMarkerLocation(${image.id}, 'topleft')">左上</a>
                        <a onclick="changeMarkerLocation(${image.id}, 'topright')">右上</a>
                        <a onclick="changeMarkerLocation(${image.id}, 'bottomleft')">左下</a>
                        <a onclick="changeMarkerLocation(${image.id}, 'bottomright')">右下</a>
                    </div>
                    <img style="max-width:200px;" src="${image.thumbUrl}" data-url="${image.deleteUrl}" id="${image.id}">
                </div>
            </g:each>
            <div class="form-ele fileupload-container" id="fileupload-container-image">
                <div class="fileupload-block" for="fileupload" style="display:none">
                    <p>拖拽图片放在此处上传</p>
                    <span>或者</span>
                    <span>点击此处上传</span>
                </div>
            </div>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="content"><g:message code="default.content.label" default="Content"/></label>
        </th>
        <td><g:textArea name="content" id="content" rows="5" style="width:590px;height:360px">${qrCodeSettingInstance?.content}</g:textArea>
        </td>
    </tr>
    </tbody>
</table>

<script src="/kindeditor/kindeditor.js" type="text/javascript"></script>
<script src="/kindeditor/lang/zh_CN.js" type="text/javascript"></script>
<script src="/kindeditor/plugins/code/prettify.js" type="text/javascript"></script>
<script src="/kindeditor/plugins/filemanager/filemanager.js" type="text/javascript"></script>

<asset:javascript src="jquery.lazyload.js"/>
<asset:javascript src="jquery.iframe-transport.js"/>
<asset:javascript src="jquery.fileupload.js"/>
<asset:javascript src="utilities.js"/>

<r:script>
    var editor;
    KindEditor.ready(function(K) {
        editor = K.create('#content', {
            filterMode: false,
            resizeType : 1,
            allowPreviewEmoticons : false,
            fileManagerJson : '${createLink(controller: "upload", action: "fileManager", params: [ownerClass: "QrCodeSetting", id:"${qrCodeSettingInstance.id}"])}',
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
		initFileUpload('fileupload-container-image', 'image', 10);
		$("img.lazy").lazyload({
			threshold : 200
		});
	});
</r:script>