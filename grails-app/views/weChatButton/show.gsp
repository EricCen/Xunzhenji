%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%


<%@ page import="net.xunzhenji.wechat.WeChatButton" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'weChatButton.label', default: 'WeChatButton')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="nav" role="navigation">
			<ul>
				<li><g:link class='btnGrayS vm bigbtn' action="index"><asset:image src="text.png" class="vm" /><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class='btnGrayS vm bigbtn' action="create"><asset:image src="text.png" class="vm" /><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-weChatButton" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list weChatButton">
			<table class="userinfoArea weChatButton" border="0" cellspacing="0" cellpadding="0" width="100%">
				<tbody>
			
				<g:if test="${weChatButtonInstance?.key}">
					<tr>
					<th><span id="key-label" class="property-label"><g:message code="weChatButton.key.label" default="Key" /></span></th>
					
						<td><span class="property-value" aria-labelledby="key-label"><g:fieldValue bean="${weChatButtonInstance}" field="key"/></span></td>
					
					</tr>
				</g:if>
			
				<g:if test="${weChatButtonInstance?.url}">
					<tr>
					<th><span id="url-label" class="property-label"><g:message code="weChatButton.url.label" default="Url" /></span></th>
					
						<td><span class="property-value" aria-labelledby="url-label"><g:fieldValue bean="${weChatButtonInstance}" field="url"/></span></td>
					
					</tr>
				</g:if>
			
				<g:if test="${weChatButtonInstance?.mediaId}">
					<tr>
					<th><span id="mediaId-label" class="property-label"><g:message code="weChatButton.mediaId.label" default="Media Id" /></span></th>
					
						<td><span class="property-value" aria-labelledby="mediaId-label"><g:fieldValue bean="${weChatButtonInstance}" field="mediaId"/></span></td>
					
					</tr>
				</g:if>
			
				<g:if test="${weChatButtonInstance?.buttonType}">
					<tr>
					<th><span id="buttonType-label" class="property-label"><g:message code="weChatButton.buttonType.label" default="Button Type" /></span></th>
					
						<td><span class="property-value" aria-labelledby="buttonType-label"><g:fieldValue bean="${weChatButtonInstance}" field="buttonType"/></span></td>
					
					</tr>
				</g:if>
			
				<g:if test="${weChatButtonInstance?.name}">
					<tr>
					<th><span id="name-label" class="property-label"><g:message code="weChatButton.name.label" default="Name" /></span></th>
					
						<td><span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${weChatButtonInstance}" field="name"/></span></td>
					
					</tr>
				</g:if>
			
				<g:if test="${weChatButtonInstance?.buttonEventType}">
					<tr>
					<th><span id="type-label" class="property-label"><g:message code="weChatButton.buttonEventType.label" default="Type" /></span></th>
					
						<td><span class="property-value" aria-labelledby="type-label"><g:fieldValue bean="${weChatButtonInstance}" field="buttonEventType"/></span></td>
					
					</tr>
				</g:if>
			
				<g:if test="${weChatButtonInstance?.weChatMenu}">
					<tr>
					<th><span id="weChatMenu-label" class="property-label"><g:message code="weChatButton.weChatMenu.label" default="We Chat Menu" /></span></th>
					
						<td><span class="property-value" aria-labelledby="weChatMenu-label"><g:link controller="weChatMenu" action="show" id="${weChatButtonInstance?.weChatMenu?.id}">${weChatButtonInstance?.weChatMenu?.encodeAsHTML()}</g:link></span></td>
					
					</tr>
				</g:if>
			
			</ol>
			<g:form url="[resource:weChatButtonInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="btnGreen left" action="edit" resource="${weChatButtonInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="btnGreen left" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
