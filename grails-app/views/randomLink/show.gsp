%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%


<%@ page import="net.xunzhenji.promotion.RandomLink" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'randomLink.label', default: 'RandomLink')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="nav" role="navigation">
			<ul>
				<li><g:link class='btnGrayS vm bigbtn' action="index"><asset:image src="text.png" class="vm" /><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class='btnGrayS vm bigbtn' action="create"><asset:image src="text.png" class="vm" /><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-randomLink" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list randomLink">
			<table class="userinfoArea randomLink" border="0" cellspacing="0" cellpadding="0" width="100%">
				<tbody>
			
				<g:if test="${randomLinkInstance?.links}">
					<tr>
					<th><span id="links-label" class="property-label"><g:message code="randomLink.links.label" default="Links" /></span></th>
					
						<g:each in="${randomLinkInstance.links}" var="l">
							<td><span class="property-value" aria-labelledby="links-label"><g:link controller="link" action="show" id="${l.id}">${l?.encodeAsHTML()}</g:link></span></td>
						</g:each>
					
					</tr>
				</g:if>
			
				<g:if test="${randomLinkInstance?.linkCode}">
					<tr>
					<th><span id="link-code-label" class="property-label"><g:message code="randomLink.linkCode.label" default="LinkCode" /></span></th>
					
						<td><span class="property-value" aria-labelledby="link-code-label">${randomLinkInstance.linkCode}</span></td>
					
					</tr>
				</g:if>
			
			</ol>
			<g:form url="[resource:randomLinkInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="btnGreen left" action="edit" resource="${randomLinkInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="btnGreen left" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
