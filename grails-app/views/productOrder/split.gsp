%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%

<%@ page import="net.xunzhenji.model.DeliveryStatus; net.xunzhenji.mall.ProductOrder" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="admin">
    <g:set var="entityName" value="${message(code: 'productOrder.label', default: 'ProductOrder')}"/>
    <title>拆分订单</title>
</head>

<body>
<div class="nav" role="navigation">
    <ul>
        <li><g:link class='btnGrayS vm bigbtn' action="index"><asset:image src="text.png" class="vm"/><g:message
                code="default.list.label" args="[entityName]"/></g:link></li>
    </ul>
</div>

<div id="show-productOrder" class="content scaffold-show" role="main">
    <h1><g:message code="default.show.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <g:form action="splitOrder" id="${productOrderInstance.id}" method="POST">
        <table class="userinfoArea productOrder" border="0" cellspacing="0" cellpadding="0" width="100%">
            <tbody>

            <tr>
                <th><span id="remainQuantity-label" class="property-label">保留数量</span></th>

                <td><g:field type="number" class="px" name="remainQuantity" value="${productOrderInstance.quantity}"/></td>
            </tr>
            </tbody>
        </table>
        <g:actionSubmit class="btnGreen left" action="splitOrder" value="拆分"/>
    </g:form>
</div>
</body>
</html>
