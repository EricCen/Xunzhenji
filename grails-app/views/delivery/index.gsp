
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
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="pageNavigator left">
			<g:link action="create" class='btnGrayS vm bigbtn'><asset:image src="text.png" class="vm" /><g:message code="default.new.label" args="[entityName]" /></g:link>
			<g:link action="list" class='btnGrayS vm bigbtn'><asset:image src="text.png" class="vm" />按日期列表</g:link>
			<g:link action="removeUselessDelivery" class='btnGrayS vm bigbtn'><asset:image src="text.png" class="vm" />删除空发货记录</g:link>
		</div>
		<div id="list-delivery" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="list-table"  border="0" cellspacing="0" cellpadding="0" width="100%">
			<thead>
					<tr>
						<g:sortableColumn property="targetDeliveryDate" title="${message(code: 'delivery.targetDeliveryDate.label', default: 'Delivery Date')}" />
						<th><g:message code="batch.label" default="批次" /></th>
						<th><g:message code="delivery.deliveryCode.label" default="运单号" /></th>
						<th><g:message code="default.address.label" default="地址" /></th>
						<th><g:message code="delivery.receiver.label" default="收货人" /></th>
						<th>订单数量</th>
						<th>有效</th>
					</tr>
				</thead>
				<tbody>
				<g:each in="${deliveryInstanceList}" status="i" var="deliveryInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
						<td><g:link action="show" id="${deliveryInstance.id}"><g:formatDate format="yyyy-MM-dd E" date="${deliveryInstance.targetDeliveryDate}" /></g:link></td>
						<td>${deliveryInstance?.batch?.product?.title} - ${deliveryInstance?.batch?.title}</td>
						<td>${fieldValue(bean: deliveryInstance, field: "deliveryCode")}</td>
						<td>${deliveryInstance?.address?.toString()}</td>
						<td>${deliveryInstance?.address?.name}</td>
						<td>${deliveryInstance.orders()? deliveryInstance.orders()?.sum{it.quantity} : 0}</td>
						<td><g:formatBoolean true="有效" false="无效" boolean="${deliveryInstance.enable}"/></td>
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${deliveryInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
