%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%


<%@ page import="net.xunzhenji.shop.ShopProduct" %>
<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="admin">
	<g:set var="entityName" value="${message(code: 'shopProduct.label', default: 'ShopProduct')}"/>
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

<div id="show-shopProduct" class="content scaffold-show" role="main">
	<h1><g:message code="default.show.label" args="[entityName]"/></h1>
	<g:if test="${flash.message}">
		<div class="message" role="status">${flash.message}</div>
	</g:if>
	<ol class="property-list shopProduct">
		<table class="userinfoArea shopProduct" border="0" cellspacing="0" cellpadding="0" width="100%">
			<tbody>

			<g:if test="${shopProductInstance?.defaultPrice}">
				<tr>
					<th><span id="defaultPrice-label" class="property-label"><g:message
							code="shopProduct.defaultPrice.label" default="Default Price"/></span></th>

					<td><span class="property-value" aria-labelledby="defaultPrice-label"><g:fieldValue
							bean="${shopProductInstance}" field="defaultPrice"/></span></td>

				</tr>
			</g:if>

			<g:if test="${shopProductInstance?.name}">
				<tr>
					<th><span id="name-label" class="property-label"><g:message code="shopProduct.name.label"
																				default="Name"/></span></th>

					<td><span class="property-value" aria-labelledby="name-label"><g:fieldValue
							bean="${shopProductInstance}" field="name"/></span></td>

				</tr>
			</g:if>

			<g:if test="${shopProductInstance?.procurable}">
				<tr>
					<th><span id="procurable-label" class="property-label"><g:message
							code="shopProduct.procurable.label" default="Procurable"/></span></th>

					<td><span class="property-value" aria-labelledby="procurable-label"><g:formatBoolean
							boolean="${shopProductInstance?.procurable}"/></span></td>

				</tr>
			</g:if>

			<g:if test="${shopProductInstance?.quantityUnit}">
				<tr>
					<th><span id="quantityUnit-label" class="property-label"><g:message
							code="shopProduct.quantityUnit.label" default="Quantity Unit"/></span></th>

					<td><span class="property-value" aria-labelledby="quantityUnit-label"><g:fieldValue
							bean="${shopProductInstance}" field="quantityUnit"/></span></td>

				</tr>
			</g:if>

			<g:if test="${shopProductInstance?.saleable}">
				<tr>
					<th><span id="saleable-label" class="property-label"><g:message code="shopProduct.saleable.label"
																					default="Saleable"/></span></th>

					<td><span class="property-value" aria-labelledby="saleable-label"><g:formatBoolean
							boolean="${shopProductInstance?.saleable}"/></span></td>

				</tr>
			</g:if>

			<g:if test="${shopProductInstance?.weightUnit}">
				<tr>
					<th><span id="weightUnit-label" class="property-label"><g:message
							code="shopProduct.weightUnit.label" default="Weight Unit"/></span></th>

					<td><span class="property-value" aria-labelledby="weightUnit-label"><g:fieldValue
							bean="${shopProductInstance}" field="weightUnit"/></span></td>

				</tr>
			</g:if>

	</ol>
	<g:form url="[resource: shopProductInstance, action: 'delete']" method="DELETE">
		<fieldset class="buttons">
			<g:link class="btnGreen left" action="edit" resource="${shopProductInstance}"><g:message
					code="default.button.edit.label" default="Edit"/></g:link>
			<g:actionSubmit class="btnGreen left" action="delete"
							value="${message(code: 'default.button.delete.label', default: 'Delete')}"
							onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
		</fieldset>
	</g:form>
</div>
</body>
</html>
