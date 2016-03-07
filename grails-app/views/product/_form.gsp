<asset:stylesheet href="upload.css"/>
<%@ page import="net.xunzhenji.mall.Category; net.xunzhenji.mall.Product" %>
<input type="hidden" name="addMarker" value="true">
<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="title"><g:message code="category.label" default="产品分类"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:select name="category.id"
                      from="${net.xunzhenji.mall.Category.list()}"
                      optionValue="name"
                      optionKey="id"
                      value="${productInstance?.category?.id}"/></td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="title"><g:message code="producer.label" default="生产者"/><span class="required-indicator">*</span>
            </label>
        </th>
        <td><g:select name="producer.id"
                      from="${net.xunzhenji.mall.Producer.list()}"
                      optionValue="name"
                      optionKey="id"
                      value="${productInstance?.producer?.id}"/></td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="title"><g:message code="default.title.label" default="标题"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:textField name="title" required="" class="px"
                         value="${productInstance?.title}"/></td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label><g:message code="product.banner.label" default="首页横幅"/><span
                    class="required-indicator">*</span><br>
                <span style="font-size: 0.5em">最佳显示尺寸：600*200</span>
            </label>
        </th>
        <td style="display: flex;">
            <g:if test="${productInstance.banner}">
                <div class="uploaded-img">
                    <img style="max-width:200px;" src="${productInstance.banner?.thumbUrl}"
                         data-url="${productInstance.banner?.deleteUrl}"
                         id="${productInstance.banner?.id}">
                </div>
            </g:if>
            <div class="form-ele fileupload-container" id="fileupload-container-banner">
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
            <label for="introduction"><g:message code="product.introduction.label" default="卖点"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><textarea name="introduction" id="introduction" rows="5" required=""
                      style="width:580px;border: ridge;">${productInstance.introduction}</textarea></td>
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
            <g:each in="${productInstance.images?.sort{it.order}}" var="image">
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
            <label for="content"><g:message code="default.content.label" default="详细内容"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><textarea name="content" id="content" rows="5"
                      style="width:590px;height:360px">${productInstance.content}</textarea></td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="extraPeriod"><g:message code="product.extraPeriod.label" default="保质期"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:field name="extraPeriod" type="number" class="px"
                     value="${productInstance.extraPeriod}" required=""/>天</td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="origin"><g:message code="product.origin.label" default="产地"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:textField name="origin" required="" class="px"
                         value="${productInstance?.origin}"/></td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="price"><g:message code="product.price.label" default="价格"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:field name="price" class="px"
                     value="${fieldValue(bean: productInstance, field: 'price')}" required=""/>元</td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="deposit"><g:message code="product.deposit.label" default="订金"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:field name="deposit" class="px"
                     value="${fieldValue(bean: productInstance, field: 'deposit')}" required=""/>元</td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="weeklyDiscount"><g:message code="product.weeklydiscount.label" default="每周提价"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:field name="weeklyDiscount" class="px"
                     value="${productInstance?.weeklyDiscount * 100}" required=""/>%</td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="quantityInStore"><g:message code="product.quantityInStore.label" default="库存"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:field name="quantityInStore" type="number" class="px"
                     value="${productInstance.quantityInStore}" required=""/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="weight"><g:message code="product.weight.label" default="净量"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:field name="weight" type="number" class="px" value="${productInstance.weight}"
                     required=""/>g</td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="grossWeight"><g:message code="product.grossWeight.label" default="毛重"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:field name="grossWeight" type="number" class="px" value="${productInstance.grossWeight}"
                     required=""/>g</td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="region"><g:message code="product.region.label" default=""/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:field name="region" class="px" type="text" value="${productInstance.region}" required=""/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="title"><g:message code="express.label" default="快递"/></label>
        </th>
        <td><g:select name="express.id"
                      from="${net.xunzhenji.mall.Express.list()}"
                      optionValue="name"
                      optionKey="id"
                      value="${productInstance?.express?.id}"/></td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="remark"><g:message code="product.remark.label" default="备注"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td>
            <textarea name="remark" id="remark" rows="5" required=""
                      style="width:580px;border: ridge;">${productInstance?.remark}</textarea>
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
            fileManagerJson : '../fileManager/${productInstance.id}',
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
		initFileUpload('fileupload-container-image', 'image', 6);
		initFileUpload('fileupload-container-banner', 'banner', 1);
		$("img.lazy").lazyload({
			threshold : 200
		});
	});
</r:script>
