%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%


<%@ page import="net.xunzhenji.promotion.Link" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'link.label', default: 'Link')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="nav" role="navigation">
			<ul>
				<li><g:link class='btnGrayS vm bigbtn' action="index"><asset:image src="text.png" class="vm" /><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class='btnGrayS vm bigbtn' action="create"><asset:image src="text.png" class="vm" /><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-link" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list link">
			<table class="userinfoArea link" border="0" cellspacing="0" cellpadding="0" width="100%">
				<tbody>

				<g:if test="${linkInstance?.title}">
					<tr>
						<th><span id="title-label" class="property-label"><g:message code="default.title.label" default="Title" /></span></th>

						<td><span class="property-value" aria-labelledby="title-label"><g:fieldValue bean="${linkInstance}" field="title"/></span></td>

					</tr>
				</g:if>

				<g:if test="${linkInstance?.tinyCode}">
					<tr>
					<th><span id="tinyCode-label" class="property-label"><g:message code="link.tinyCode.label" default="Tiny Code" /></span></th>
					
						<td><span class="property-value" aria-labelledby="tinyCode-label"><g:fieldValue bean="${linkInstance}" field="tinyCode"/></span></td>
					
					</tr>
				</g:if>
			
				<g:if test="${linkInstance?.url}">
					<tr>
					<th><span id="url-label" class="property-label"><g:message code="link.url.label" default="Url" /></span></th>
					
						<td><span class="property-value" aria-labelledby="url-label"><g:fieldValue bean="${linkInstance}" field="url"/></span></td>
					
					</tr>
				</g:if>
			
			</ol>
			<g:form url="[resource:linkInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="btnGreen left" action="edit" resource="${linkInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="btnGreen left" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
