%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%


<%@ page import="net.xunzhenji.mall.Commission" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="admin">
    <g:set var="entityName" value="${message(code: 'commission.label', default: 'Commission')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>
<div class="nav" role="navigation">
    <ul>
        <li><g:link class='btnGrayS vm bigbtn' action="index"><asset:image src="text.png" class="vm"/><g:message
                code="default.list.label" args="[entityName]"/></g:link></li>
    </ul>
</div>

<div id="show-commission" class="content scaffold-show" role="main">
    <h1><g:message code="default.show.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <ol class="property-list commission">
        <table class="userinfoArea commission" border="0" cellspacing="0" cellpadding="0" width="100%">
            <tbody>

            <g:if test="${commissionInstance?.productName}">
                <tr>
                    <th><span id="productName-label" class="property-label"><g:message code="product.label"
                                                                                       default="Product Name"/></span>
                    </th>

                    <td>
                        <span class="property-value"
                              aria-labelledby="productName-label">${commissionInstance?.productName}</span></td>

                </tr>
            </g:if>

            <g:if test="${commissionInstance?.productOrder}">
                <tr>
                    <th><span id="productOrder-label" class="property-label"><g:message code="productOrder.label"
                                                                                        default="Product Order"/></span>
                    </th>

                    <td><span class="property-value" aria-labelledby="productOrder-label"><g:link
                            controller="productOrder" action="show"
                            id="${commissionInstance?.productOrder?.id}">${commissionInstance?.productOrder?.encodeAsHTML()}</g:link></span>
                    </td>

                </tr>
            </g:if>

            <g:if test="${commissionInstance?.organizer}">
                <tr>
                    <th><span id="organizer-label" class="property-label"><g:message code="commission.organizer.label"
                                                                                     default="Organizer"/></span></th>

                    <td><span class="property-value" aria-labelledby="organizer-label"><g:link controller="userInfo"
                                                                                               action="show"
                                                                                               id="${commissionInstance?.organizer?.id}">${commissionInstance?.organizer?.encodeAsHTML()}</g:link></span>
                    </td>

                </tr>
            </g:if>

            <g:if test="${commissionInstance?.amount}">
                <tr>
                    <th><span id="amount-label" class="property-label"><g:message code="default.amount.label"
                                                                                  default="Amount"/></span></th>

                    <td><span class="property-value" aria-labelledby="amount-label"><g:fieldValue
                            bean="${commissionInstance}" field="amount"/></span></td>

                </tr>
            </g:if>

            <g:if test="${commissionInstance?.state}">
                <tr>
                    <th><span id="state-label" class="property-label"><g:message code="default.state.label"
                                                                                 default="State"/></span></th>

                    <td><span class="property-value"
                              aria-labelledby="state-label">${Commission.CommissionState.valueOf(commissionInstance.state).description}</span>
                    </td>

                </tr>
            </g:if>

            <g:if test="${commissionInstance?.dateCreated}">
                <tr>
                    <th><span id="dateCreated-label" class="property-label"><g:message code="default.dateCreated.label"
                                                                                       default="Date Created"/></span>
                    </th>

                    <td><span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate
                            format="yyyy-MM-dd HH:mm:ss" date="${commissionInstance?.dateCreated}"/></span></td>

                </tr>
            </g:if>

            <g:if test="${commissionInstance?.lastUpdated}">
                <tr>
                    <th><span id="lastUpdated-label" class="property-label"><g:message code="default.lastUpdated.label"
                                                                                       default="Last Updated"/></span>
                    </th>

                    <td><span class="property-value" aria-labelledby="lastUpdated-label"><g:formatDate
                            format="yyyy-MM-dd HH:mm:ss" date="${commissionInstance?.lastUpdated}"/></span></td>

                </tr>
            </g:if>
            </tbody>
        </table>
    </ol>
    <g:form url="[resource: commissionInstance, action: 'delete']" method="DELETE">
        <fieldset class="buttons">
            <g:link class="btnGreen left" action="edit" resource="${commissionInstance}"><g:message
                    code="default.button.edit.label" default="Edit"/></g:link>
            <g:actionSubmit class="btnGreen left" action="delete"
                            value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                            onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
        </fieldset>
    </g:form>

    <div id="events-tbl-body" class="table list-table" border="0" cellspacing="0" cellpadding="0" width="100%">
        <h1>事件列表</h1>

        <div class="tr">
            <div class="th">事件</div>

            <div class="th">状态</div>

            <div class="th">金额</div>

            <div class="th">群主</div>

            <div class="th">时间</div>
        </div>

        <g:each in="${commissionEvents}" var="event">
            <div class="tr">
                <div class="td">${event.event}</div>

                <div class="td">${Commission.CommissionState.valueOf(event.state).description}</div>

                <div class="td">${event.amount}</div>

                <div class="td">${event.organizer.name}</div>

                <div class="td"><g:formatDate format="yy-MM-dd HH:mm" date="${event.dateCreated}"/></div>
            </div>
        </g:each>
    </div>
</div>
</body>
</html>
