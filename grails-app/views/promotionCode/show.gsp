%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%


<%@ page import="net.xunzhenji.mall.PromotionCode" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="admin">
    <g:set var="entityName" value="${message(code: 'promotionCode.label', default: 'PromotionCode')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>
<div class="nav" role="navigation">
    <ul>
        <li><g:link class='btnGrayS vm bigbtn' action="index"><asset:image src="text.png" class="vm"/><g:message
                code="default.list.label" args="[entityName]"/></g:link></li>
        <li><g:link class='btnGrayS vm bigbtn' action="create"><asset:image src="text.png" class="vm"/><g:message
                code="default.new.label" args="[entityName]"/></g:link></li>
    </ul>
</div>

<div id="show-promotionCode" class="content scaffold-show" role="main">
    <h1><g:message code="default.show.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <ol class="property-list promotionCode">
        <table class="userinfoArea promotionCode" border="0" cellspacing="0" cellpadding="0" width="100%">
            <tbody>

            <g:if test="${promotionCodeInstance?.title}">
                <tr>
                    <th><span id="title-label" class="property-label"><g:message code="default.title.label"
                                                                                 default="Title"/></span></th>

                    <td><span class="property-value" aria-labelledby="title-label"><g:fieldValue
                            bean="${promotionCodeInstance}" field="title"/></span></td>

                </tr>
            </g:if>

            <g:if test="${promotionCodeInstance?.description}">
                <tr>
                    <th><span id="description-label" class="property-label"><g:message code="default.description.label"
                                                                                       default="Description"/></span>
                    </th>

                    <td><span class="property-value" aria-labelledby="description-label"><g:fieldValue
                            bean="${promotionCodeInstance}" field="description"/></span></td>

                </tr>
            </g:if>

            <g:if test="${promotionCodeInstance?.code}">
                <tr>
                    <th><span id="code-label" class="property-label"><g:message code="promotionCode.code.label"
                                                                                default="Code"/></span></th>

                    <td><span class="property-value" aria-labelledby="code-label"><g:fieldValue
                            bean="${promotionCodeInstance}" field="code"/></span></td>

                </tr>
            </g:if>

            <g:if test="${promotionCodeInstance?.discount}">
                <tr>
                    <th><span id="discount-label" class="property-label"><g:message code="promotionCode.discount.label"
                                                                                    default="Discount"/></span></th>

                    <td><span class="property-value" aria-labelledby="discount-label"><g:fieldValue
                            bean="${promotionCodeInstance}" field="discount"/></span></td>
                </tr>
            </g:if>

            <g:if test="${promotionCodeInstance?.price}">
                <tr>
                    <th><span id="price-label" class="property-label"><g:message code="promotionCode.price.label"
                                                                                 default="Price"/></span></th>

                    <td><span class="property-value" aria-labelledby="price-label"><g:fieldValue
                            bean="${promotionCodeInstance}" field="price"/></span></td>
                </tr>
            </g:if>

            <g:if test="${promotionCodeInstance?.minimumOrder}">
                <tr>
                    <th><span id="minimumOrder-label" class="property-label"><g:message
                            code="promotionCode.minimumOrder.label"
                            default="minimumOrder"/></span></th>

                    <td><span class="property-value" aria-labelledby="minimumOrder-label"><g:fieldValue
                            bean="${promotionCodeInstance}" field="minimumOrder"/></span></td>
                </tr>
            </g:if>

            <g:if test="${promotionCodeInstance?.maximumUsed}">
                <tr>
                    <th><span id="maximumUsed-label" class="property-label"><g:message
                            code="promotionCode.maximumUsed.label"
                            default="Price"/></span></th>

                    <td><span class="property-value" aria-labelledby="maximumUsed-label"><g:fieldValue
                            bean="${promotionCodeInstance}" field="maximumUsed"/></span></td>
                </tr>
            </g:if>

            <g:if test="${promotionCodeInstance?.usedCount}">
                <tr>
                    <th><span id="usedCount-label" class="property-label"><g:message
                            code="promotionCode.usedCount.label"
                            default="usedCount"/></span></th>

                    <td><span class="property-value" aria-labelledby="usedCount-label"><g:fieldValue
                            bean="${promotionCodeInstance}" field="usedCount"/></span></td>
                </tr>
            </g:if>

            <g:if test="${promotionCodeInstance?.expiredDate}">
                <tr>
                    <th><span id="expiredDate-label" class="property-label"><g:message
                            code="promotionCode.expiredDate.label" default="Expired Date"/></span></th>

                    <td><span class="property-value" aria-labelledby="expiredDate-label"><g:formatDate
                            format="yyyy-MM-dd" date="${promotionCodeInstance?.expiredDate}"/></span></td>

                </tr>
            </g:if>

            <g:if test="${promotionCodeInstance?.includeExpress}">
                <tr>
                    <th><span id="includeExpress-label" class="property-label"><g:message
                            code="promotionCode.includeExpress.label" default="Include Express"/></span></th>

                    <td><span class="property-value" aria-labelledby="includeExpress-label"><g:formatBoolean
                            boolean="${promotionCodeInstance?.includeExpress}" true="是" false="否"/></span></td>
                </tr>
            </g:if>

            <g:if test="${promotionCodeInstance?.address}">
                <tr>
                    <th><span id="address-label" class="property-label"><g:message
                            code="default.address.label" default="Address"/></span></th>

                    <td><span class="property-value"
                              aria-labelledby="address-label">${promotionCodeInstance?.address?.name} ${promotionCodeInstance?.address}</span>
                    </td>
                </tr>
            </g:if>

            <g:if test="${promotionCodeInstance?.products}">
                <tr>
                    <th><span id="products-label" class="property-label"><g:message
                            code="product.label" default="Product"/></span></th>

                    <td><span class="property-value" aria-labelledby="includeExpress-label">
                        <g:each in="${promotionCodeInstance.products}" var="product">
                            <span>${product}</span><br>
                        </g:each>
                    </td>

                </tr>
            </g:if>

            </tbody>
        </table>

    </ol>
    <g:form url="[resource: promotionCodeInstance, action: 'delete']" method="DELETE">
        <fieldset class="buttons">
            <g:link class="btnGreen left" action="edit" resource="${promotionCodeInstance}"><g:message
                    code="default.button.edit.label" default="Edit"/></g:link>
            <g:actionSubmit class="btnGreen left" action="delete"
                            value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                            onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
        </fieldset>
    </g:form>
</div>
</body>
</html>
