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
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="pageNavigator left">
			<g:link action="create" class='btnGrayS vm bigbtn'><asset:image src="text.png" class="vm" /><g:message code="default.new.label" args="[entityName]" /></g:link>
		</div>
		<div id="list-alipayContext" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="list-table"  border="0" cellspacing="0" cellpadding="0" width="100%">
			<thead>
					<tr>
					
						<g:sortableColumn property="inputCharset" title="${message(code: 'alipayContext.inputCharset.label', default: 'Input Charset')}" />
					
						<g:sortableColumn property="key" title="${message(code: 'alipayContext.key.label', default: 'Key')}" />
					
						<g:sortableColumn property="notifyUrl" title="${message(code: 'alipayContext.notifyUrl.label', default: 'Notify Url')}" />
					
						<g:sortableColumn property="partner" title="${message(code: 'alipayContext.partner.label', default: 'Partner')}" />
					
						<g:sortableColumn property="paymentType" title="${message(code: 'alipayContext.paymentType.label', default: 'Payment Type')}" />
					
						<g:sortableColumn property="returnUrl" title="${message(code: 'alipayContext.returnUrl.label', default: 'Return Url')}" />
					
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
				<g:each in="${alipayContextInstanceList}" status="i" var="alipayContextInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${alipayContextInstance.id}">${fieldValue(bean: alipayContextInstance, field: "inputCharset")}</g:link></td>
					
						<td>${fieldValue(bean: alipayContextInstance, field: "key")}</td>
					
						<td>${fieldValue(bean: alipayContextInstance, field: "notifyUrl")}</td>
					
						<td>${fieldValue(bean: alipayContextInstance, field: "partner")}</td>
					
						<td>${fieldValue(bean: alipayContextInstance, field: "paymentType")}</td>
					
						<td>${fieldValue(bean: alipayContextInstance, field: "returnUrl")}</td>
					
						<td><g:link action="edit" id="${alipayContextInstance.id}">编辑</g:link> </td>
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${alipayContextInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
