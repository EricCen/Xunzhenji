%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%


<%@ page import="net.xunzhenji.shop.ShopProduct" %>
<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="admin">
	<g:set var="entityName" value="${message(code: 'shopProduct.label', default: 'ShopProduct')}"/>
	<title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<div class="pageNavigator left">
	<g:link action="create" class='btnGrayS vm bigbtn'><asset:image src="text.png" class="vm"/><g:message
			code="default.new.label" args="[entityName]"/></g:link>
</div>

<div id="list-shopProduct" class="content scaffold-list" role="main">
	<h1><g:message code="default.list.label" args="[entityName]"/></h1>
	<g:if test="${flash.message}">
		<div class="message" role="status">${flash.message}</div>
	</g:if>
	<table class="list-table" border="0" cellspacing="0" cellpadding="0" width="100%">
		<thead>
		<tr>

			<g:sortableColumn property="defaultPrice"
							  title="${message(code: 'shopProduct.defaultPrice.label', default: 'Default Price')}"/>

			<g:sortableColumn property="name" title="${message(code: 'shopProduct.name.label', default: 'Name')}"/>

			<g:sortableColumn property="procurable"
							  title="${message(code: 'shopProduct.procurable.label', default: 'Procurable')}"/>

			<g:sortableColumn property="quantityUnit"
							  title="${message(code: 'shopProduct.quantityUnit.label', default: 'Quantity Unit')}"/>

			<g:sortableColumn property="saleable"
							  title="${message(code: 'shopProduct.saleable.label', default: 'Saleable')}"/>

			<g:sortableColumn property="weightUnit"
							  title="${message(code: 'shopProduct.weightUnit.label', default: 'Weight Unit')}"/>

			<th>操作</th>
		</tr>
		</thead>
		<tbody>
		<g:each in="${shopProductInstanceList}" status="i" var="shopProductInstance">
			<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

				<td><g:link action="show"
							id="${shopProductInstance.id}">${fieldValue(bean: shopProductInstance, field: "defaultPrice")}</g:link></td>

				<td>${fieldValue(bean: shopProductInstance, field: "name")}</td>

				<td><g:formatBoolean boolean="${shopProductInstance.procurable}"/></td>

				<td>${fieldValue(bean: shopProductInstance, field: "quantityUnit")}</td>

				<td><g:formatBoolean boolean="${shopProductInstance.saleable}"/></td>

				<td>${fieldValue(bean: shopProductInstance, field: "weightUnit")}</td>

				<td><g:link action="edit" id="${shopProductInstance.id}">编辑</g:link></td>
			</tr>
		</g:each>
		</tbody>
	</table>

	<div class="pagination">
		<g:paginate total="${shopProductInstanceCount ?: 0}"/>
	</div>
</div>
</body>
</html>
