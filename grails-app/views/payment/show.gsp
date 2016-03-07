%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%


<%@ page import="net.xunzhenji.mall.Payment" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'payment.label', default: 'Payment')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="nav" role="navigation">
			<ul>
				<li><g:link class='btnGrayS vm bigbtn' action="index"><asset:image src="text.png" class="vm" /><g:message code="default.list.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-payment" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list payment">
			<table class="userinfoArea payment" border="0" cellspacing="0" cellpadding="0" width="100%">
				<tbody>
			
				<g:if test="${paymentInstance?.prepayId}">
					<tr>
					<th><span id="prepayId-label" class="property-label"><g:message code="payment.prepayId.label" default="Prepay Id" /></span></th>
					
						<td><span class="property-value" aria-labelledby="prepayId-label"><g:fieldValue bean="${paymentInstance}" field="prepayId"/></span></td>
					
					</tr>
				</g:if>
			
				<g:if test="${paymentInstance?.timeEnd}">
					<tr>
					<th><span id="timeEnd-label" class="property-label"><g:message code="payment.timeEnd.label" default="Time End" /></span></th>
					
						<td><span class="property-value" aria-labelledby="timeEnd-label"><g:formatDate format="yyyy-MM-dd HH:mm:ss" date="${paymentInstance?.timeEnd}" /></span></td>
					
					</tr>
				</g:if>
			
				<g:if test="${paymentInstance?.transactionId}">
					<tr>
					<th><span id="transactionId-label" class="property-label"><g:message code="payment.transactionId.label" default="Transaction Id" /></span></th>
					
						<td><span class="property-value" aria-labelledby="transactionId-label"><g:fieldValue bean="${paymentInstance}" field="transactionId"/></span></td>
					
					</tr>
				</g:if>
			
				<g:if test="${paymentInstance?.cashFee}">
					<tr>
					<th><span id="cashFee-label" class="property-label"><g:message code="payment.cashFee.label" default="Cash Fee" /></span></th>
					
						<td><span class="property-value" aria-labelledby="cashFee-label"><g:fieldValue bean="${paymentInstance}" field="cashFee"/></span></td>
					
					</tr>
				</g:if>
			
				<g:if test="${paymentInstance?.balanceAmount}">
					<tr>
					<th><span id="balanceAmount-label" class="property-label"><g:message code="payment.balanceAmount.label" default="Balance Amount" /></span></th>
					
						<td><span class="property-value" aria-labelledby="balanceAmount-label"><g:fieldValue bean="${paymentInstance}" field="balanceAmount"/></span></td>
					
					</tr>
				</g:if>
			
				<g:if test="${paymentInstance?.errCode}">
					<tr>
					<th><span id="errCode-label" class="property-label"><g:message code="payment.errCode.label" default="Err Code" /></span></th>
					
						<td><span class="property-value" aria-labelledby="errCode-label"><g:fieldValue bean="${paymentInstance}" field="errCode"/></span></td>
					
					</tr>
				</g:if>
			
				<g:if test="${paymentInstance?.errCodeDes}">
					<tr>
					<th><span id="errCodeDes-label" class="property-label"><g:message code="payment.errCodeDes.label" default="Err Code Des" /></span></th>
					
						<td><span class="property-value" aria-labelledby="errCodeDes-label"><g:fieldValue bean="${paymentInstance}" field="errCodeDes"/></span></td>
					
					</tr>
				</g:if>
			
				<g:if test="${paymentInstance?.resultCode}">
					<tr>
					<th><span id="resultCode-label" class="property-label"><g:message code="payment.resultCode.label" default="Result Code" /></span></th>
					
						<td><span class="property-value" aria-labelledby="resultCode-label"><g:fieldValue bean="${paymentInstance}" field="resultCode"/></span></td>
					
					</tr>
				</g:if>
			
				<g:if test="${paymentInstance?.isSubscribe}">
					<tr>
					<th><span id="isSubscribe-label" class="property-label"><g:message code="payment.isSubscribe.label" default="Is Subscribe" /></span></th>
					
						<td><span class="property-value" aria-labelledby="isSubscribe-label"><g:fieldValue bean="${paymentInstance}" field="isSubscribe"/></span></td>
					
					</tr>
				</g:if>
			
				<g:if test="${paymentInstance?.tradeType}">
					<tr>
					<th><span id="tradeType-label" class="property-label"><g:message code="payment.tradeType.label" default="Trade Type" /></span></th>
					
						<td><span class="property-value" aria-labelledby="tradeType-label"><g:fieldValue bean="${paymentInstance}" field="tradeType"/></span></td>
					
					</tr>
				</g:if>
			
				<g:if test="${paymentInstance?.bankType}">
					<tr>
					<th><span id="bankType-label" class="property-label"><g:message code="payment.bankType.label" default="Bank Type" /></span></th>
					
						<td><span class="property-value" aria-labelledby="bankType-label"><g:fieldValue bean="${paymentInstance}" field="bankType"/></span></td>
					
					</tr>
				</g:if>
			
				<g:if test="${paymentInstance?.openid}">
					<tr>
					<th><span id="openid-label" class="property-label"><g:message code="payment.openid.label" default="Openid" /></span></th>
					
						<td><span class="property-value" aria-labelledby="openid-label"><g:fieldValue bean="${paymentInstance}" field="openid"/></span></td>
					
					</tr>
				</g:if>
			
				<g:if test="${paymentInstance?.amount}">
					<tr>
					<th><span id="amount-label" class="property-label"><g:message code="payment.amount.label" default="Amount" /></span></th>
					
						<td><span class="property-value" aria-labelledby="amount-label"><g:fieldValue bean="${paymentInstance}" field="amount"/></span></td>
					
					</tr>
				</g:if>
			
				<g:if test="${paymentInstance?.cashFlowDirection}">
					<tr>
					<th><span id="cashFlowDirection-label" class="property-label"><g:message code="payment.cashFlowDirection.label" default="Cash Flow Direction" /></span></th>
					
						<td><span class="property-value" aria-labelledby="cashFlowDirection-label"><g:fieldValue bean="${paymentInstance}" field="cashFlowDirection"/></span></td>
					
					</tr>
				</g:if>
			
				<g:if test="${paymentInstance?.dateCreated}">
					<tr>
					<th><span id="dateCreated-label" class="property-label"><g:message code="payment.dateCreated.label" default="Date Created" /></span></th>
					
						<td><span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate format="yyyy-MM-dd HH:mm:ss" date="${paymentInstance?.dateCreated}" /></span></td>
					
					</tr>
				</g:if>
			
				<g:if test="${paymentInstance?.outTradeNo}">
					<tr>
					<th><span id="outTradeNo-label" class="property-label"><g:message code="payment.outTradeNo.label" default="Out Trade No" /></span></th>
					
						<td><span class="property-value" aria-labelledby="outTradeNo-label"><g:fieldValue bean="${paymentInstance}" field="outTradeNo"/></span></td>
					
					</tr>
				</g:if>
			
				<g:if test="${paymentInstance?.status}">
					<tr>
					<th><span id="status-label" class="property-label"><g:message code="payment.status.label" default="Status" /></span></th>
					
						<td><span class="property-value" aria-labelledby="status-label"><g:fieldValue bean="${paymentInstance}" field="status"/></span></td>
					
					</tr>
				</g:if>
			
				<g:if test="${paymentInstance?.type}">
					<tr>
					<th><span id="type-label" class="property-label"><g:message code="payment.type.label" default="Type" /></span></th>
					
						<td><span class="property-value" aria-labelledby="type-label"><g:fieldValue bean="${paymentInstance}" field="type"/></span></td>
					
					</tr>
				</g:if>
			
			</ol>
			<g:form url="[resource:paymentInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="btnGreen left" action="edit" resource="${paymentInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
