<%@ page import="net.xunzhenji.wechat.WeChatFansActivity" %>



<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="actionContent"><g:message code="weChatFansActivity.actionContent.label"
                                                  default="Action Content"/></label>
        </th>
        <td><g:textField class="px" name="actionContent"
                         value="${weChatFansActivityInstance?.actionContent}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="product"><g:message code="weChatFansActivity.product.label" default="Product"/></label>
        </th>
        <td><g:select id="product" name="product.id" from="${net.xunzhenji.mall.Product.list()}" optionKey="id"
                      value="${weChatFansActivityInstance?.product?.id}" class="many-to-one"
                      noSelection="['null': '']"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="actionType"><g:message code="weChatFansActivity.actionType.label" default="Action Type"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:select name="actionType" from="${net.xunzhenji.wechat.WeChatFansActivity$ActionType?.values()}"
                      keys="${net.xunzhenji.wechat.WeChatFansActivity$ActionType.values()*.name()}" required=""
                      value="${weChatFansActivityInstance?.actionType?.name()}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="fans"><g:message code="weChatFansActivity.fans.label" default="Fans"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:select id="fans" name="fans.id" from="${net.xunzhenji.wechat.WeChatFans.list()}" optionKey="id"
                      required="" value="${weChatFansActivityInstance?.fans?.id}" class="many-to-one"/>
        </td>
    </tr>
    </tbody>
</table>

