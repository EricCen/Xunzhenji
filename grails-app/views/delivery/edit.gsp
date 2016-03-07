%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%

<%@ page import="net.xunzhenji.mall.Delivery" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'delivery.label', default: 'Delivery')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="nav" role="navigation">
			<ul>
				<li><g:link class='btnGrayS vm bigbtn' action="index"><asset:image src="text.png" class="vm" /><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link action="list" class='btnGrayS vm bigbtn'><asset:image src="text.png" class="vm" />按日期列表</g:link></li>
				<li><g:link class='btnGrayS vm bigbtn' action="updateProcessing" id="${deliveryInstance.id}">开始发货</g:link></li>
				<li><g:link class='btnGrayS vm bigbtn' action="deliveryCompleted" id="${deliveryInstance.id}">货物已签收</g:link></li>
			</ul>
		</div>
		<div id="edit-delivery" class="content scaffold-edit" role="main">
			<h1><g:message code="default.edit.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${deliveryInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${deliveryInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form url="[resource:deliveryInstance, action:'update']" method="PUT" >
				<g:hiddenField name="version" value="${deliveryInstance?.version}" />
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
				<fieldset class="buttons">
					<g:actionSubmit class="btnGreen left" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
				</fieldset>
			</g:form>
			<div id="route-detail">
				<h1>路由信息</h1>
				<g:each in="${routeInfo}" var="item">
					<div>${item}</div>
				</g:each>
			</div>
		</div>
	</body>
</html>
