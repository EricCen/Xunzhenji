%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%

<%@ page import="net.xunzhenji.model.DeliveryStatus; org.apache.commons.lang.time.DateFormatUtils; net.xunzhenji.mall.ProductOrder" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="admin">
    <g:set var="entityName" value="${message(code: 'productOrder.label', default: '订单')}"/>
    <title>订单管理</title>
</head>

<body>

<div id="list-productOrder" class="content scaffold-list" role="main">
    <h1><g:message code="default.list.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <div>
        <div class="searchbar left">
            <div class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
                <div class="tr grid">
                    <div class="th col10">${message(code: 'product.label', default: 'Product')}</div>

                    <div class="td col5"><input id="txtProductName" class="txt"></div>

                    <div class="th col10">${message(code: 'batch.label', default: 'Batch')}</div>

                    <div class="td col5"><input type="text" id="txtBatch" class="txt"></div>

                    <div class="td col10"></div>
                </div>

                <div class="tr">
                    <div class="th">${message(code: 'productOrder.paymentStatus.label', default: '支付状态')}</div>

                    <div class="td"><g:select id="ddlPaymentStatus" name="paymentStatus"
                                              from="${net.xunzhenji.model.PaymentStatus.getSelectOptions()}"
                                              optionKey="id" optionValue="name"/>
                    </div>

                    <div class="th">${message(code: 'productOrder.deliveryStatus.label', default: '物流状态')}</div>

                    <div class="td"><g:select id="ddlDeliveryStatus" name="deliveryStatus"
                                              from="${net.xunzhenji.model.DeliveryStatus.getSelectOptions()}"
                                              optionKey="id" optionValue="name"/>
                    </div>

                    <div class="td">
                        <input type="button" value="查询" id="msgSearchBtn" href="" class="btnGrayS" title="查询"
                               onclick="searchOrders(1);">
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="order-tbl-body" class="table list-table" border="0" cellspacing="0" cellpadding="0" width="100%">
    </div>

    <div class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
        <div class="tr">
            <div class="td">第</div>

            <div class="td"><select id="ddlPage" name="pageNumber" onchange="searchOrders($('#ddlPage').val());"></select></div>

            <div class="td">页</div>
        </div>
    </div>


    <div id="tpl-order-tbl" style="display:none;">
        <div class="tr">
            <div class="th">编号</div>

            <div class="th">${message(code: 'product.title.label', default: '产品名称')}</div>

            <div class="th">${message(code: 'batch.title.label', default: '批次名称')}</div>

            <div class="th">${message(code: 'productOrder.quantity.label', default: '数量')}</div>

            <div class="th">${message(code: 'productOrder.orderDate.label', default: '订单日期')}</div>

            <div class="th">${message(code: 'productOrder.orderPrice.label', default: '订单价格')}</div>

            <div class="th" style="width: 12em;">${message(code: 'productOrder.address.label', default: '地址')}</div>

            <div class="th" style="width: 6em;">${message(code: 'default.phone.label', default: '电话')}</div>

            <div class="th" style="width: 6em;">${message(code: 'default.name.label', default: '姓名')}</div>

            <div class="th">${message(code: 'userInfo.subscribe.label', default: '关注')}</div>

            <div class="th">${message(code: 'productOrder.displayStatus.label', default: '状态')}</div>

            <div class="th">操作</div>
        </div>
        {{#productOrderInstanceList}}
        <div class="tr">
            <div class="td">{{id}}</div>

            <div class="td">{{productTitle}}</div>

            <div class="td">{{batchTitle}}</div>

            <div class="td">{{quantity}}</div>

            <div class="td">{{orderDate}}</div>

            <div class="td">{{orderPrice}}</div>

            <div class="td">{{address}}</div>

            <div class="td">{{phone}}</div>

            <div class="td">{{name}}</div>

            <div class="td">{{subscribe}}</div>

        <div class="td">显示:{{displayStatus}}<br>
            支付:{{paymentStatus}}<br>
            物流:{{deliveryStatus}}
        </div>

            <div class="td">
                <a href="/productOrder/edit/{{id}}">编辑</a><br>
                <a href="/productOrder/confirmDeliveryTime/{{id}}">提醒确定发货时间</a><br>
                <a href="/productOrder/remindForPayment/{{id}}">提醒支付</a><br>
                <a href="/productOrder/remindDelivery/{{id}}">提醒收货</a><br>
                <a href="/productOrder/split/{{id}}">拆分</a><br>
                <a href="{{h5DetailLink}}">订单详情</a>
            </div>
        </div>
        {{/productOrderInstanceList}}
    </div>

    <script>
        $(document).ready(function () {
            searchOrders(1);
        });

        function searchOrders(pageNumber) {

            $.ajax({
                url: '${createLink(controller: "productOrder", action: "searchOrders")}',
                data: {
                    product: $('#txtProductName').val(),
                    batch: $('#txtBatch').val(),
                    paymentStatus: $('#ddlPaymentStatus').val(),
                    deliveryStatus: $('#ddlDeliveryStatus').val(),
                    page: pageNumber
                },
                success: function (data) {
                    if (data.errorcode == 0) {

                        render($('#tpl-order-tbl'), $('#order-tbl-body'), data.model);

                        if (data.model.pageCount) {
                            $('#ddlPage').empty();
                            for (var pageIndex = 1; pageIndex <= data.model.pageCount; pageIndex++) {
                                var option = $("<option>").val(pageIndex).text(pageIndex);
                                $('#ddlPage').append(option);
                            }
                            $('#ddlPage').val(pageNumber);
                        }
                    }
                }
            });
        }

    </script>
</div>
</body>
</html>
