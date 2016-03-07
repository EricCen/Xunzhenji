%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%


<%@ page import="net.xunzhenji.mall.CouponTemplate" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'coupon.label', default: 'Coupon')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="nav" role="navigation">
			<ul>
				<li><g:link class='btnGrayS vm bigbtn' action="index"><asset:image src="text.png" class="vm" /><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class='btnGrayS vm bigbtn' action="create"><asset:image src="text.png" class="vm" /><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-coupon" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list coupon">
			<table class="userinfoArea coupon" border="0" cellspacing="0" cellpadding="0" width="100%">
				<tbody>
				<g:if test="${couponInstance?.title}">
					<tr>
						<th><span id="title-label" class="property-label"><g:message code="default.title.label" default="Title" /></span></th>

						<td><span class="property-value" aria-labelledby="title-label"><g:fieldValue bean="${couponInstance}" field="title"/></span></td>

					</tr>
				</g:if>

				<g:if test="${couponInstance?.product}">
					<tr>
					<th><span id="product-label" class="property-label"><g:message code="product.label" default="Product" /></span></th>
					
						<td><span class="property-value" aria-labelledby="product-label"><g:link controller="product" action="show" id="${couponInstance?.product?.id}">${couponInstance?.product?.encodeAsHTML()}</g:link></span></td>
					
					</tr>
				</g:if>

				<g:if test="${couponInstance?.bubbleContent}">
					<tr>
						<th><span id="bubbleContent-label" class="property-label"><g:message code="coupon.bubbleContent.label" default="对话内容" /></span></th>

						<td>${couponInstance?.bubbleContent}</td>
					</tr>
				</g:if>

				<g:if test="${couponInstance?.content}">
					<tr>
						<th><span id="content-label" class="property-label"><g:message code="default.content.label" default="Product" /></span></th>

						<td>${couponInstance?.content}</td>
					</tr>
				</g:if>
			</ol>
			<g:form url="[resource:couponInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="btnGreen left" action="edit" resource="${couponInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="btnGreen left" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
