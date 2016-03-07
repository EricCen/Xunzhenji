<%@ page import="net.xunzhenji.wechat.Media" %>



<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="type"><g:message code="media.type.label" default="Type"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:textField class="px" name="type" maxlength="6" required=""
                         value="${mediaInstance?.type}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="title"><g:message code="media.title.label" default="Title"/></label>
        </th>
        <td><g:textField class="px" name="title" value="${mediaInstance?.title}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="introduction"><g:message code="media.introduction.label" default="Introduction"/></label>
        </th>
        <td><g:textField class="px" name="introduction" value="${mediaInstance?.introduction}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="mediaId"><g:message code="media.mediaId.label" default="Media Id"/></label>
        </th>
        <td><g:textField class="px" name="mediaId" value="${mediaInstance?.mediaId}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="weChatCreatedAt"><g:message code="media.weChatCreatedAt.label"
                                                    default="We Chat Created At"/></label>
        </th>
        <td><g:datePicker name="weChatCreatedAt" precision="day" value="${mediaInstance?.weChatCreatedAt}"
                          default="none" noSelection="['': '']"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="host"><g:message code="media.host.label" default="Host"/></label>
        </th>
        <td><g:textField class="px" name="host" value="${mediaInstance?.host}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="path"><g:message code="media.path.label" default="Path"/></label>
        </th>
        <td><g:textField class="px" name="path" value="${mediaInstance?.path}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="thumbUrl"><g:message code="media.thumbUrl.label" default="Thumb Url"/></label>
        </th>
        <td><g:textField class="px" name="thumbUrl" value="${mediaInstance?.thumbUrl}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="url"><g:message code="media.url.label" default="Url"/></label>
        </th>
        <td><g:textField class="px" name="url" value="${mediaInstance?.url}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="fileName"><g:message code="media.fileName.label" default="File Name"/></label>
        </th>
        <td><g:textField class="px" name="fileName" value="${mediaInstance?.fileName}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="uploadName"><g:message code="media.uploadName.label" default="Upload Name"/></label>
        </th>
        <td><g:textField class="px" name="uploadName" value="${mediaInstance?.uploadName}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="size"><g:message code="media.size.label" default="Size"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:field name="size" type="number" value="${mediaInstance.size}" required=""/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="status"><g:message code="media.status.label" default="Status"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:field name="status" type="number" value="${mediaInstance.status}" required=""/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="weChatContext"><g:message code="media.weChatContext.label" default="We Chat Context"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:select id="weChatContext" name="weChatContext.id" from="${net.xunzhenji.wechat.WeChatContext.list()}"
                      optionKey="id" required="" value="${mediaInstance?.weChatContext?.id}" class="many-to-one"/>
        </td>
    </tr>
    </tbody>
</table>

