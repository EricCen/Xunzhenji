%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%


<%@ page import="net.xunzhenji.Server" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'server.label', default: 'Server')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="nav" role="navigation">
			<ul>
				<li><g:link class='btnGrayS vm bigbtn' action="index"><asset:image src="text.png" class="vm" /><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class='btnGrayS vm bigbtn' action="create"><asset:image src="text.png" class="vm" /><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-server" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list server">
			<table class="userinfoArea server" border="0" cellspacing="0" cellpadding="0" width="100%">
				<tbody>
			
				<g:if test="${serverInstance?.ip}">
					<tr>
					<th><span id="ip-label" class="property-label"><g:message code="server.ip.label" default="Ip" /></span></th>
					
						<td><span class="property-value" aria-labelledby="ip-label"><g:fieldValue bean="${serverInstance}" field="ip"/></span></td>
					
					</tr>
				</g:if>
			
				<g:if test="${serverInstance?.refreshAccessToken}">
					<tr>
					<th><span id="refreshAccessToken-label" class="property-label"><g:message code="server.refreshAccessToken.label" default="Refresh Access Token" /></span></th>
					
						<td><span class="property-value" aria-labelledby="refreshAccessToken-label"><g:formatBoolean boolean="${serverInstance?.refreshAccessToken}" /></span></td>
					
					</tr>
				</g:if>
			
				<g:if test="${serverInstance?.refreshBatchPrice}">
					<tr>
					<th><span id="refreshBatchPrice-label" class="property-label"><g:message code="server.refreshBatchPrice.label" default="Refresh Batch Price" /></span></th>
					
						<td><span class="property-value" aria-labelledby="refreshBatchPrice-label"><g:formatBoolean boolean="${serverInstance?.refreshBatchPrice}" /></span></td>
					
					</tr>
				</g:if>
			
				<g:if test="${serverInstance?.refreshJsApiTicket}">
					<tr>
					<th><span id="refreshJsApiTicket-label" class="property-label"><g:message code="server.refreshJsApiTicket.label" default="Refresh Js Api Ticket" /></span></th>
					
						<td><span class="property-value" aria-labelledby="refreshJsApiTicket-label"><g:formatBoolean boolean="${serverInstance?.refreshJsApiTicket}" /></span></td>
					
					</tr>
				</g:if>
			
				<g:if test="${serverInstance?.remindPayment}">
					<tr>
					<th><span id="remindPayment-label" class="property-label"><g:message code="server.remindPayment.label" default="Remind Payment" /></span></th>
					
						<td><span class="property-value" aria-labelledby="remindPayment-label"><g:formatBoolean boolean="${serverInstance?.remindPayment}" /></span></td>
					
					</tr>
				</g:if>
			
				<g:if test="${serverInstance?.startupTime}">
					<tr>
					<th><span id="startupTime-label" class="property-label"><g:message code="server.startupTime.label" default="Startup Time" /></span></th>
					
						<td><span class="property-value" aria-labelledby="startupTime-label"><g:formatDate format="yyyy-MM-dd HH:mm:ss" date="${serverInstance?.startupTime}" /></span></td>
					
					</tr>
				</g:if>
			
			</ol>
			<g:form url="[resource:serverInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="btnGreen left" action="edit" resource="${serverInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="btnGreen left" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
