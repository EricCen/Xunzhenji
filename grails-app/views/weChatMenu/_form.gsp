<%@ page import="net.xunzhenji.wechat.WeChatMenu" %>



<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label><g:message code="weChatMenu.buttonGroup1.label" default="Button Group1"/></label>
        </th>
        <td>
            <ul class="one-to-many">
                <g:each in="${weChatMenuInstance?.buttons?.findAll{it.buttonType == net.xunzhenji.wechat.WeChatButton.ButtonType.Button.id}}" var="b">
                    <li><g:link controller="weChatButton" action="show" id="${b.id}">${b?.encodeAsHTML()}</g:link></li>
                </g:each>
                <li class="add">
                    <g:link controller="weChatButton" action="create"
                            params="['weChatMenu.id': weChatMenuInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'weChatButton.label', default: 'WeChatButton')])}</g:link>
                </li>
            </ul>

        </td>
    </tr>
    </tbody>
</table>
