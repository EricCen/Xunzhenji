<%@ page import="net.xunzhenji.wechat.WeChatButton" %>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="name"><g:message code="weChatButton.name.label" default="Name"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:textField class="px" name="name" required="" value="${weChatButtonInstance?.name}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="buttonType"><g:message code="weChatButton.buttonType.label" default="Button Type"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:select name="buttonType" from="${net.xunzhenji.wechat.WeChatButton.ButtonType.values()}"
                      optionKey="id" optionValue="desc" value="${weChatButtonInstance?.buttonType}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="parentBtn"><g:message code="weChatButton.parentBtn.label" default="Type"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:select name="parentBtn" from="${net.xunzhenji.wechat.WeChatButton.findAllByButtonType(WeChatButton.ButtonType.Button.id)}"
                      noSelection="${['null':'无父菜单']}" optionKey="id" optionValue="name" value="${weChatButtonInstance?.parentBtn?.id}"/>
        </td>
    </tr>
    </tbody>
</table>


<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="buttonEventType"><g:message code="weChatButton.buttonEventType.label" default="Type"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:select name="buttonEventType" from="${net.xunzhenji.wechat.WeChatButton.ButtonEventType.values()}"
                      optionKey="id" optionValue="desc" value="${weChatButtonInstance?.buttonEventType}"/>
        </td>
    </tr>
    </tbody>
</table>


<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="key"><g:message code="weChatButton.key.label" default="Key"/></label>
        </th>
        <td><g:textField class="px" name="key" value="${weChatButtonInstance?.key}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="url"><g:message code="weChatButton.url.label" default="Url"/></label>
        </th>
        <td><g:textField class="px" name="url" value="${weChatButtonInstance?.url}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="mediaId"><g:message code="weChatButton.mediaId.label" default="Media Id"/></label>
        </th>
        <td><g:textField class="px" name="mediaId" value="${weChatButtonInstance?.mediaId}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="weChatMenu"><g:message code="weChatButton.weChatMenu.label" default="We Chat Menu"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:select id="weChatMenu" name="weChatMenu.id" from="${net.xunzhenji.wechat.WeChatMenu.list()}"
                      optionKey="id" required="" value="${weChatButtonInstance?.weChatMenu?.id}" class="many-to-one"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="pushContent"><g:message code="weChatButton.pushContent.label" default="推送内容"/></label>
        </th>
        <td>
            <textarea name="pushContent" id="pushContent" rows="5"
                      style="width:580px;border: ridge;">${weChatButtonInstance?.pushContent}</textarea>
        </td>
    </tr>
    </tbody>
</table>