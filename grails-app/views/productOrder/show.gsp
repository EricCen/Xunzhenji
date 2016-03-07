
%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%

<%@ page import="net.xunzhenji.model.DeliveryStatus; net.xunzhenji.mall.ProductOrder" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'productOrder.label', default: 'ProductOrder')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="nav" role="navigation">
			<ul>
				<li><g:link class='btnGrayS vm bigbtn' action="index"><asset:image src="text.png" class="vm" /><g:message code="default.list.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-productOrder" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list productOrder">
			<table class="userinfoArea productOrder" border="0" cellspacing="0" cellpadding="0" width="100%">
				<tbody>
				<g:if test="${productOrderInstance?.product}">
					<tr>
						<th><span id="product-label" class="property-label"><g:message code="product.label" default="商品" /></span></th>

						<td><span class="property-value" aria-labelledby="product-label"><g:link controller="product" action="show" id="${productOrderInstance?.product?.id}">${productOrderInstance?.product?.encodeAsHTML()}</g:link></span></td>

					</tr>
				</g:if>

				<g:if test="${productOrderInstance?.address}">
					<tr>
					<th><span id="address-label" class="property-label"><g:message code="productOrder.address.label" default="Address" /></span></th>
					
						<td><span class="property-value" aria-labelledby="address-label"><g:link controller="address" action="show" id="${productOrderInstance?.address?.id}">${productOrderInstance?.address?.encodeAsHTML()}</g:link></span></td>
					
					</tr>
				</g:if>
			
				<g:if test="${productOrderInstance?.batch}">
					<tr>
					<th><span id="batch-label" class="property-label"><g:message code="batch.label" default="Batch" /></span></th>
					
						<td><span class="property-value" aria-labelledby="batch-label"><g:link controller="batch" action="show" id="${productOrderInstance?.batch?.id}">${productOrderInstance?.batch?.encodeAsHTML()}</g:link></span></td>
					
					</tr>
				</g:if>

				<g:if test="${productOrderInstance?.userInfo}">
					<tr>
						<th><span id="userInfo-label" class="property-label"><g:message code="productOrder.userInfo.label" default="User Info" /></span></th>

						<td><span class="property-value" aria-labelledby="userInfo-label"><g:link controller="userInfo" action="show" id="${productOrderInstance?.userInfo?.id}">${productOrderInstance?.userInfo?.encodeAsHTML()}</g:link></span></td>

					</tr>
				</g:if>

				<g:if test="${productOrderInstance?.quantity}">
					<tr>
						<th><span id="quantity-label" class="property-label"><g:message code="productOrder.quantity.label" default="Quantity" /></span></th>

						<td><span class="property-value" aria-labelledby="quantity-label"><g:fieldValue bean="${productOrderInstance}" field="quantity"/></span></td>

					</tr>
				</g:if>

				<g:if test="${productOrderInstance?.marketPrice}">
					<tr>
					<th><span id="marketPrice-label" class="property-label"><g:message code="productOrder.marketPrice.label" default="Market Price" /></span></th>
					
						<td><span class="property-value" aria-labelledby="marketPrice-label"><g:fieldValue bean="${productOrderInstance}" field="marketPrice"/></span></td>
					
					</tr>
				</g:if>
				<g:if test="${productOrderInstance?.orderPrice}">
					<tr>
						<th><span id="orderPrice-label" class="property-label"><g:message code="productOrder.orderPrice.label" default="Order Price" /></span></th>

						<td><span class="property-value" aria-labelledby="orderPrice-label"><g:fieldValue bean="${productOrderInstance}" field="orderPrice"/></span></td>

					</tr>
				</g:if>
			
				<g:if test="${productOrderInstance?.orderDeposit}">
					<tr>
					<th><span id="orderDeposit-label" class="property-label"><g:message code="productOrder.orderDeposit.label" default="Order Deposit" /></span></th>
					
						<td><span class="property-value" aria-labelledby="orderDeposit-label"><g:fieldValue bean="${productOrderInstance}" field="orderDeposit"/></span></td>
					
					</tr>
				</g:if>
			
				<g:if test="${productOrderInstance?.paymentStatus}">
					<tr>
					<th><span id="paymentStatus-label" class="property-label"><g:message code="productOrder.paymentStatus.label" default="Payment Status" /></span></th>
					
						<td><span class="property-value" aria-labelledby="paymentStatus-label">${net.xunzhenji.model.PaymentStatus.valueOf(productOrderInstance.paymentStatus).name}</span></td>
					
					</tr>
				</g:if>

				<g:if test="${productOrderInstance?.deliveryStatus}">
					<tr>
						<th><span id="deliveryStatus-label" class="property-label"><g:message code="productOrder.deliveryStatus.label" default="Delivery Status" /></span></th>

						<td>
							<span class="property-value" aria-labelledby="deliveryStatus-label">${net.xunzhenji.model.DeliveryStatus.valueOf(productOrderInstance.deliveryStatus).name}</span></td>

					</tr>
				</g:if>

				<g:if test="${productOrderInstance?.paymentType}">
					<tr>
					<th><span id="paymentType-label" class="property-label"><g:message code="productOrder.paymentType.label" default="Payment Type" /></span></th>
					
						<td><span class="property-value" aria-labelledby="paymentType-label"><g:fieldValue bean="${productOrderInstance}" field="paymentType"/></span></td>
					
					</tr>
				</g:if>

				<g:if test="${productOrderInstance?.payments()}">
					<tr>
						<th><span id="payments-label" class="property-label"><g:message code="productOrder.payments.label" default="Payments" /></span></th>


						<td>
						<g:each in="${productOrderInstance.payments()}" var="p">
							<span class="property-value" aria-labelledby="payments-label"><g:link controller="payment"
																								  action="show"
																								  id="${p.id}">${p?.encodeAsHTML()}</g:link></span> <br>
						</g:each>
						</td>
					</tr>
				</g:if>

				<g:if test="${productOrderInstance?.orderDate}">
					<tr>
						<th><span id="orderDate-label" class="property-label"><g:message code="productOrder.orderDate.label" default="Order Date" /></span></th>

						<td><span class="property-value" aria-labelledby="orderDate-label"><g:formatDate format="yyyy-MM-dd HH:mm:ss" date="${productOrderInstance?.orderDate}" /></span></td>

					</tr>
				</g:if>

				<g:if test="${userInfo}">
					<tr>
						<th><span class="property-label"><g:message code="productOrder.userInfo.label"
																	default="客户"/></span></th>

						<td><span class="property-value"
								  aria-labelledby="userInfo-label"><g:link controller="userInfo"
																		   id="${userInfo?.id}">${userInfo?.name ?: ""} ${productOrderInstance.address?.name ?: ""} ${userInfo?.weChatFans?.nickName ?: ""}</g:link></span>
						</td>

					</tr>
				</g:if>

			</ol>
			<g:form url="[resource:productOrderInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="btnGreen left" action="edit" resource="${productOrderInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="btnGreen left" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
