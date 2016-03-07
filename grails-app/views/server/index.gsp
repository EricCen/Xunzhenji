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
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="pageNavigator left">
			<g:link action="create" class='btnGrayS vm bigbtn'><asset:image src="text.png" class="vm" /><g:message code="default.new.label" args="[entityName]" /></g:link>
		</div>
		<div id="list-server" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="list-table"  border="0" cellspacing="0" cellpadding="0" width="100%">
			<thead>
					<tr>
					
						<g:sortableColumn property="ip" title="${message(code: 'server.ip.label', default: 'Ip')}" />

						<g:sortableColumn property="startupTime" title="${message(code: 'server.startupTime.label', default: 'Startup Time')}" />

						<th>运行时间</th>

						<g:sortableColumn property="refreshAccessToken" title="${message(code: 'server.refreshAccessToken.label', default: 'Refresh Access Token')}" />
					
						<g:sortableColumn property="refreshBatchPrice" title="${message(code: 'server.refreshBatchPrice.label', default: 'Refresh Batch Price')}" />
					
						<g:sortableColumn property="refreshJsApiTicket" title="${message(code: 'server.refreshJsApiTicket.label', default: 'Refresh Js Api Ticket')}" />
					
						<g:sortableColumn property="remindPayment" title="${message(code: 'server.remindPayment.label', default: 'Remind Payment')}" />

						<th>操作</th>
					</tr>
				</thead>
				<tbody>
				<g:each in="${serverInstanceList}" status="i" var="serverInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${serverInstance.id}">${fieldValue(bean: serverInstance, field: "ip")}</g:link></td>

						<td><g:formatDate format="yyyy-MM-dd HH:mm:ss" date="${serverInstance.startupTime}" /></td>

						<td>${(new Date().getTime() - serverInstance.startupTime.getTime())/3600000}小时</td>
					
						<td><g:formatBoolean true="是" false="否" boolean="${serverInstance.refreshAccessToken}" /></td>
					
						<td><g:formatBoolean true="是" false="否" boolean="${serverInstance.refreshBatchPrice}" /></td>
					
						<td><g:formatBoolean true="是" false="否" boolean="${serverInstance.refreshJsApiTicket}" /></td>
					
						<td><g:formatBoolean true="是" false="否" boolean="${serverInstance.remindPayment}" /></td>
					
						<td><g:link action="edit" id="${serverInstance.id}">编辑</g:link> </td>
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${serverInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
