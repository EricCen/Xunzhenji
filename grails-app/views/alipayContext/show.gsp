%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%


<%@ page import="net.xunzhenji.alipay.AlipayContext" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'alipayContext.label', default: 'AlipayContext')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="nav" role="navigation">
			<ul>
				<li><g:link class='btnGrayS vm bigbtn' action="index"><asset:image src="text.png" class="vm" /><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class='btnGrayS vm bigbtn' action="create"><asset:image src="text.png" class="vm" /><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-alipayContext" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list alipayContext">
			<table class="userinfoArea alipayContext" border="0" cellspacing="0" cellpadding="0" width="100%">
				<tbody>
			
				<g:if test="${alipayContextInstance?.inputCharset}">
					<tr>
					<th><span id="inputCharset-label" class="property-label"><g:message code="alipayContext.inputCharset.label" default="Input Charset" /></span></th>
					
						<td><span class="property-value" aria-labelledby="inputCharset-label"><g:fieldValue bean="${alipayContextInstance}" field="inputCharset"/></span></td>
					
					</tr>
				</g:if>
			
				<g:if test="${alipayContextInstance?.key}">
					<tr>
					<th><span id="key-label" class="property-label"><g:message code="alipayContext.key.label" default="Key" /></span></th>
					
						<td><span class="property-value" aria-labelledby="key-label"><g:fieldValue bean="${alipayContextInstance}" field="key"/></span></td>
					
					</tr>
				</g:if>
			
				<g:if test="${alipayContextInstance?.notifyUrl}">
					<tr>
					<th><span id="notifyUrl-label" class="property-label"><g:message code="alipayContext.notifyUrl.label" default="Notify Url" /></span></th>
					
						<td><span class="property-value" aria-labelledby="notifyUrl-label"><g:fieldValue bean="${alipayContextInstance}" field="notifyUrl"/></span></td>
					
					</tr>
				</g:if>
			
				<g:if test="${alipayContextInstance?.partner}">
					<tr>
					<th><span id="partner-label" class="property-label"><g:message code="alipayContext.partner.label" default="Partner" /></span></th>
					
						<td><span class="property-value" aria-labelledby="partner-label"><g:fieldValue bean="${alipayContextInstance}" field="partner"/></span></td>
					
					</tr>
				</g:if>
			
				<g:if test="${alipayContextInstance?.paymentType}">
					<tr>
					<th><span id="paymentType-label" class="property-label"><g:message code="alipayContext.paymentType.label" default="Payment Type" /></span></th>
					
						<td><span class="property-value" aria-labelledby="paymentType-label"><g:fieldValue bean="${alipayContextInstance}" field="paymentType"/></span></td>
					
					</tr>
				</g:if>
			
				<g:if test="${alipayContextInstance?.returnUrl}">
					<tr>
					<th><span id="returnUrl-label" class="property-label"><g:message code="alipayContext.returnUrl.label" default="Return Url" /></span></th>
					
						<td><span class="property-value" aria-labelledby="returnUrl-label"><g:fieldValue bean="${alipayContextInstance}" field="returnUrl"/></span></td>
					
					</tr>
				</g:if>
			
				<g:if test="${alipayContextInstance?.signType}">
					<tr>
					<th><span id="signType-label" class="property-label"><g:message code="alipayContext.signType.label" default="Sign Type" /></span></th>
					
						<td><span class="property-value" aria-labelledby="signType-label"><g:fieldValue bean="${alipayContextInstance}" field="signType"/></span></td>
					
					</tr>
				</g:if>
			
			</ol>
			<g:form url="[resource:alipayContextInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="btnGreen left" action="edit" resource="${alipayContextInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="btnGreen left" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
