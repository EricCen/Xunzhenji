%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%

<%@ page import="net.xunzhenji.mall.ProductOrderPayments; net.xunzhenji.util.FormatUtil; net.xunzhenji.model.DeliveryStatus; net.xunzhenji.mall.ProductOrder" %>

	<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
		<tbody>
		<tr>
			<th>
				<label for="product.id"><g:message code="product.label" default="Product" /></label>
			</th>
			<td>${productOrderInstance?.product?.title}</td>
			<input type="hidden" id="product.id" name="product.id" value="${productOrderInstance?.product?.id}">
		</tr>
		</tbody>
	</table>

	<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
		<tbody>
		<tr>
			<th>
				<label for="batch.id"><g:message code="batch.label" default="Batch" /></label>
			</th>
			<td>${productOrderInstance?.batch?.title}</td>
			<input type="hidden" id="batch.id" name="batch.id" value="${productOrderInstance?.batch?.id}">
		</tr>
		</tbody>
	</table>

	<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
		<tbody>
		<tr>
			<th>
				<label for="address.id"><g:message code="productOrder.address.label" default="Address" /></label>
			</th>
			<td>${productOrderInstance?.address}</td>
			<input type="hidden" name="address.id" value="${productOrderInstance?.address?.id}">
		</tr>
		</tbody>
	</table>

	<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
		<tbody>
		<tr>
			<th>
				<label for="orderDate"><g:message code="productOrder.orderDate.label" default="Order Date" /><span class="required-indicator">*</span></label>
			</th>
			<td>${org.apache.commons.lang.time.DateFormatUtils.format(productOrderInstance?.orderDate, "yyyy-MM-dd HH:mm")}</td>
			<input type="hidden" name="orderDate" value="${productOrderInstance?.orderDate}">
		</tr>
		</tbody>
	</table>

	<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
		<tbody>
		<tr>
			<th>
				<label for="paymentStatus"><g:message code="productOrder.paymentStatus.label" default="支付状态" /><span class="required-indicator">*</span></label>
			</th>
			<td><g:select name="paymentStatus" from="${net.xunzhenji.model.PaymentStatus.values()}"
						  optionKey="id" optionValue="name" value="${productOrderInstance.paymentStatus}"/>
			</td>
		</tr>
		</tbody>
	</table>

	<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
		<tbody>
		<tr>
			<th>
				<label for="deliveryStatus"><g:message code="productOrder.deliveryStatus.label" default="物流状态" /><span class="required-indicator">*</span></label>
			</th>
			<td><g:select name="deliveryStatus" from="${net.xunzhenji.model.DeliveryStatus.values()}"
						  optionKey="id" optionValue="name" value="${productOrderInstance.deliveryStatus}"/>
			</td>
		</tr>
		</tbody>
	</table>




	<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
		<tbody>
		<tr>
			<th>
				<label for="orderDeposit"><g:message code="productOrder.orderDeposit.label" default="Order Deposit" /><span class="required-indicator">*</span></label>
			</th>
			<td><g:field name="orderDeposit" value="${fieldValue(bean: productOrderInstance, field: 'orderDeposit')}" required=""/>元
</td>
		</tr>
		</tbody>
	</table>

	<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
		<tbody>
		<tr>
			<th>
				<label for="orderPrice"><g:message code="productOrder.orderPrice.label" default="Order Price" /><span class="required-indicator">*</span></label>
			</th>
			<td><g:field name="orderPrice" value="${fieldValue(bean: productOrderInstance, field: 'orderPrice')}" required=""/>元
</td>
		</tr>
		</tbody>
	</table>

	<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
		<tbody>
		<tr>
			<th>
				<label for="marketPrice"><g:message code="productOrder.marketPrice.label" default="Market Price" /><span class="required-indicator">*</span></label>
			</th>
			<td><g:field name="marketPrice" value="${fieldValue(bean: productOrderInstance, field: 'marketPrice')}" required=""/>元
			</td>
		</tr>
		</tbody>
	</table>

	<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
		<tbody>
		<tr>
			<th>
				<label for="quantity"><g:message code="productOrder.quantity.label" default="Quantity" /><span class="required-indicator">*</span></label>
			</th>
			<td><g:field name="quantity" type="number" value="${productOrderInstance.quantity}" required=""/>件
			</td>
		</tr>
		</tbody>
	</table>

	<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
		<tbody>
		<tr>
			<th>
				<label for="paymentType"><g:message code="productOrder.paymentType.label" default="Payment Type" /><span class="required-indicator">*</span></label>
			</th>
			<td><g:field name="paymentType" type="number" value="${productOrderInstance.paymentType}" required=""/>
</td>
		</tr>
		</tbody>
	</table>

	<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
		<tbody>
		<tr>
			<th>
				<label><g:message code="productOrder.payments.label" default="Payments" /></label>
			</th>
			<td>
				<g:each in="${net.xunzhenji.mall.ProductOrderPayments.findAllByProductOrder(productOrderInstance)*.payment}" var="payment">
					<div>编号:<g:link controller="payment" action="show" id="${payment.id}">${payment.id}</g:link>, 商户订单号:${payment.prepayId}, 微信支付单号:${payment.outTradeNo}, 状态:${payment.status}</div>
				</g:each>
			</td>
		</tr>
		</tbody>
	</table>




	<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
		<tbody>
		<tr>
			<th>
				<label><g:message code="productOrder.userInfo.label" default="User Info" /><span class="required-indicator">*</span></label>
			</th>
			<td>${userInfo?.name ?: ""} ${productOrderInstance.address?.name ?: ""} ${userInfo?.weChatFans?.nickName ?: ""}</td>
		</tr>
		</tbody>
	</table>

	<div class="grid">
		<span class="col1-3 label">选择货到时间</span>

		<div class="input-group confirm-time-group">
			<g:if test="${deliveryDate && deliveryDate < new Date()-1}">
				<g:formatDate format="yy年MM月dd日" date="${deliveryDate}" />
			</g:if>
			<g:else>
				<g:each in="${deliveryDates}" var="date">
					<div>
						<input type="radio" id="lx_day_${date.date}" name="deliverDate" value="${date.date}" ${date.date == FormatUtil.formatDate(deliveryDate) ? "checked" : ""}>
						<label for="lx_day_${date.date}">${date.date} 周${net.xunzhenji.util.FormatUtil.formatDayInWeek(date.dayInWeek)}</label>
					</div>
				</g:each>
			</g:else>
		</div>
	</div>
