%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%

<%@ page import="net.xunzhenji.mall.ProductOrder" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'productOrder.label', default: 'ProductOrder')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="nav" role="navigation">
			<ul>
				<li><g:link class='btnGrayS vm bigbtn' action="index"><asset:image src="text.png" class="vm" /><g:message code="default.list.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="edit-productOrder" class="content scaffold-edit" role="main">
			<h1><g:message code="default.edit.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${productOrderInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${productOrderInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form url="[resource:productOrderInstance, action:'update']" method="PUT" >
				<g:hiddenField name="version" value="${productOrderInstance?.version}" />
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
				<fieldset class="buttons">
					<g:actionSubmit class="btnGreen left" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
					<g:link class="btnGreen left" action="refundDeposit" id="${productOrderInstance?.id}"><g:message code="productOrder.refundDeposit.label" default="退订金" /></g:link>
					<g:link class="btnGreen left" action="refundFullPrice" id="${productOrderInstance?.id}"><g:message code="productOrder.refundFullPrice.label" default="退全款" /></g:link>
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
