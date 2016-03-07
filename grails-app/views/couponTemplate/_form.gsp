<%@ page import="net.xunzhenji.mall.CouponTemplate" %>


<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
	<tbody>
	<tr>
		<th>
			<label for="title"><g:message code="default.title.label" default="Title" /><span class="required-indicator">*</span></label>
		</th>
		<td><g:textField class="px" name="title" required="" value="${couponInstance?.title}"/>
		</td>
	</tr>
	</tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
	<tbody>
	<tr>
		<th>
			<label for="bubbleContent"><g:message code="coupon.bubbleContent.label" default="Title" /><span class="required-indicator">*</span></label>
		</th>
		<td><g:textField class="px" name="bubbleContent" required="" value="${couponInstance?.bubbleContent}"/>
		</td>
	</tr>
	</tbody>
</table>

	<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
		<tbody>
		<tr>
			<th>
				<label for="product"><g:message code="product.label" default="Product" /><span class="required-indicator">*</span></label>
			</th>
			<td><g:select id="product" name="product.id" from="${net.xunzhenji.mall.Product.list()}" optionKey="id" required="" value="${couponInstance?.product?.id}" class="many-to-one"/>
</td>
		</tr>
		</tbody>
	</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
	<tbody>
	<tr>
		<th>
			<label for="content"><g:message code="default.content.label" default="Content" /><span class="required-indicator">*</span></label>
		</th>
		<td><textarea name="content" id="content" rows="5"
					  style="width:590px;height:360px">${couponInstance?.content}</textarea></td>
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
            fileManagerJson : '${createLink(controller: "upload", action: "fileManager", params: [ownerClass: "coupon", id:"${couponInstance?.id}"])}',
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
