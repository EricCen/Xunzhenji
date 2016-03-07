%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%

<%@ page import="net.xunzhenji.mall.Batch" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="admin">
    <g:set var="entityName" value="${message(code: 'batch.label', default: 'Batch')}"/>
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

<div id="show-batch" class="content scaffold-show" role="main">
    <h1>批次详细情况</h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>

    <div style="display: flex;">
        <div style="flex-grow: 1">
            <table class="userinfoArea express" border="0" cellspacing="0" cellpadding="0" width="100%">
                <tbody>
                <g:if test="${batchInstance?.title}">
                    <tr>
                        <th><span id="title-label" class="property-label">
                            <g:message code="batch.title.label" default="标题"/></span>
                        </th>
                        <td><span class="property-value" aria-labelledby="title-label">
                            ${batchInstance.product.title} - ${batchInstance.title}</span>
                        </td>
                    </tr>
                </g:if>
                <g:if test="${batchInstance?.product?.weight}">
                    <tr>
                        <th><span id="weight-label" class="property-label">
                            <g:message code="product.weight.label" default="净重"/></span>
                        </th>
                        <td><span class="property-value" aria-labelledby="weight-label">
                            ${batchInstance.product.weight / 1000}kg</span>
                        </td>
                    </tr>
                </g:if>
                <g:if test="${batchInstance?.product?.grossWeight}">
                    <tr>
                        <th><span id="gross-weight-label" class="property-label">
                            <g:message code="product.grossWeight.label" default="毛重"/></span>
                        </th>
                        <td><span class="property-value" aria-labelledby="gross-weight-label">
                            ${batchInstance.product.grossWeight / 1000}kg</span>
                        </td>
                    </tr>
                </g:if>
                <g:if test="${batchInstance?.price}">
                    <tr>
                        <th><span id="price-label" class="property-label">
                            <g:message code="batch.price.label" default="价格"/></span>
                        </th>
                        <td><span class="property-value" aria-labelledby="price-label">
                            <g:fieldValue bean="${batchInstance}" field="price"/></span>
                        </td>
                    </tr>
                </g:if>
                <g:if test="${batchInstance?.cost}">
                    <tr>
                        <th><span id="cost-label" class="property-label">
                            除物流外成本</span>
                        </th>
                        <td><span class="property-value" aria-labelledby="cost-label">
                            <g:fieldValue bean="${batchInstance}" field="cost"/></span>
                        </td>
                    </tr>
                </g:if>
            </tbody>
            </table>
        </div>

        <div style="flex-grow: 1">
            <table class="userinfoArea express" border="0" cellspacing="0" cellpadding="0" width="100%">
                <tbody>
                <g:if test="${batchInstance?.product?.express?.name}">
                    <tr>
                        <th><span id="express-label" class="property-label">快递名称</span>
                        </th>
                        <td><span class="property-value" aria-labelledby="express-label">
                            ${batchInstance.product.express.name}</span>
                        </td>
                    </tr>
                </g:if>
                <g:if test="${batchInstance?.product?.express?.firstWeightPrice}">
                    <tr>
                        <th><span id="first-eight-price-label" class="property-label">首重</span>
                        </th>
                        <td><span class="property-value" aria-labelledby="first-eight-price-label">
                            ${batchInstance.product.express.firstWeightPrice}</span>
                        </td>
                    </tr>
                </g:if>
                <g:if test="${batchInstance?.product?.express?.continuedWeightPrice}">
                    <tr>
                        <th><span id="continued-weight-price-label" class="property-label">续重</span>
                        </th>
                        <td><span class="property-value" aria-labelledby="continued-weight-price-label">
                            ${batchInstance.product.express.continuedWeightPrice}</span>
                        </td>
                    </tr>
                </g:if>
                <g:if test="${batchInstance?.product?.express?.firstWeightTo}">
                    <tr>
                        <th><span id="first-weight-to-label" class="property-label">
                            <g:message code="express.firstWeightTo.label" default="首重重量"/>
                        </span>
                        </th>
                        <td><span class="property-value" aria-labelledby="first-weight-to-label">
                            ${batchInstance.product.express.firstWeightTo}</span>
                        </td>
                    </tr>
                </g:if>
                <g:if test="${batchInstance?.unitAllowance}">
                    <tr>
                        <th><span id="allowance-rate-label" class="property-label">
                            <g:message code="batch.unitAllowance.label" default="补贴比例"/></span>
                        </th>
                        <td><span class="property-value" aria-labelledby="allowance-rate-label">
                            ${batchInstance.unitAllowance}元</span>
                        </td>
                    </tr>
                </g:if>
                </tbody>
            </table>
        </div>
    </div>

    <g:form url="[resource: batchInstance, action: 'delete']" method="DELETE">
        <fieldset class="buttons">
            <g:link class="btnGreen left" action="edit" resource="${batchInstance}"><g:message
                    code="default.button.edit.label" default="Edit"/></g:link>
            <g:actionSubmit class="btnGreen left" action="delete"
                            value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                            onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
        </fieldset>
    </g:form>

    <div id="price-ladder" class="table list-table" border="0" cellspacing="0" cellpadding="0" width="100%">
    </div>

</div>

<div id="tpl-price-ladder" style="display: none">
    <div class="tr">
        <div class="th">拼单数量</div>

        <div class="th">运费</div>

        <div class="th">共节省运费</div>

        <div class="th">每件节省运费</div>

        <div class="th">平台补贴</div>

        <div class="th">每件商品可降价</div>

        <div class="th">群主每件得<br>(假设补贴全给群主)</div>

        <div class="th">群主收入</div>

        <div class="th">成本</div>

        <div class="th">总价</div>

        <div class="th">总利润</div>

        <div class="th">利润率</div>
    </div>
    {{#model}}
    <div class="tr">
        <div class="td">{{quantity}}</div>

        <div class="td">{{totalExpressFee}}</div>

        <div class="td">{{savedExpressFee}}</div>

        <div class="td">{{unitSavedExpressFee}}</div>

        <div class="td">{{unitAllowance}}</div>

        <div class="td">{{unitDiscountForProduct}}</div>

        <div class="td">{{unitAllowanceForOrganizer}}</div>

        <div class="td">{{organizerEarn}}</div>

        <div class="td">{{totalCost}}</div>

        <div class="td">{{totalPrice}}</div>

        <div class="td">{{totalProfit}}</div>

        <div class="td">{{profitRate}}%</div>
    </div>
    {{/model}}
</div>

<script>
    $(document).ready(function () {
        $.ajax({
            url: '${createLink(controller: "batch", action: "calcPriceLadder")}',
            data: {
                batchId: ${batchInstance.id}
            },
            success: function (data) {
                if (data.errorcode == 0) {
                    render($('#tpl-price-ladder'), $('#price-ladder'), data);
                }
            }
        })
    });
</script>
</body>
</html>
