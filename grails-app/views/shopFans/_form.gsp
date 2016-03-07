<%@ page import="net.xunzhenji.shop.ShopFans" %>



<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="fans"><g:message code="shopFans.fans.label" default="Fans"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:select id="fans" name="fans.id" from="${net.xunzhenji.wechat.WeChatFans.list()}" optionKey="id"
                      required="" value="${shopFansInstance?.fans?.id}" class="many-to-one"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="shop"><g:message code="shopFans.shop.label" default="Shop"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:select id="shop" name="shop.id" from="${net.xunzhenji.shop.Shop.list()}" optionKey="id" required=""
                      value="${shopFansInstance?.shop?.id}" class="many-to-one"/>
        </td>
    </tr>
    </tbody>
</table>

