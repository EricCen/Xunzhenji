%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%


<%@ page import="net.xunzhenji.mall.PromotionCode" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'promotionCode.label', default: 'PromotionCode')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="pageNavigator left">
			<g:link action="create" class='btnGrayS vm bigbtn'><asset:image src="text.png" class="vm" /><g:message code="default.new.label" args="[entityName]" /></g:link>
		</div>
		<div id="list-promotionCode" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="list-table"  border="0" cellspacing="0" cellpadding="0" width="100%">
			<thead>
					<tr>
						<g:sortableColumn property="title" title="${message(code: 'default.title.label', default: 'Title')}" />
					
						<g:sortableColumn property="description" title="${message(code: 'default.description.label', default: 'Description')}" />

						<g:sortableColumn property="code" title="${message(code: 'promotionCode.code.label', default: 'Code')}" />

						<g:sortableColumn property="discount" title="${message(code: 'promotionCode.discount.label', default: 'Discount')}" />

						<g:sortableColumn property="discount"
										  title="${message(code: 'promotionCode.price.label', default: 'Price')}"/>
					
						<g:sortableColumn property="expiredDate" title="${message(code: 'promotionCode.expiredDate.label', default: 'Expired Date')}" />
					
						<g:sortableColumn property="includeExpress" title="${message(code: 'promotionCode.includeExpress.label', default: 'Include Express')}" />

						<th>操作</th>
					</tr>
				</thead>
				<tbody>
				<g:each in="${promotionCodeInstanceList}" status="i" var="promotionCodeInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

						<td>${fieldValue(bean: promotionCodeInstance, field: "title")}</td>

						<td>${fieldValue(bean: promotionCodeInstance, field: "description")}</td>

						<td><g:link action="show" id="${promotionCodeInstance.id}">${fieldValue(bean: promotionCodeInstance, field: "code")}</g:link></td>
					
						<td>${fieldValue(bean: promotionCodeInstance, field: "discount")}</td>

						<td>${fieldValue(bean: promotionCodeInstance, field: "price")}</td>

						<td><g:formatDate format="yyyy-MM-dd" date="${promotionCodeInstance.expiredDate}"/></td>

						<td><g:formatBoolean true="是" false="否" boolean="${promotionCodeInstance.includeExpress}"/></td>

						<td><g:link action="edit" id="${promotionCodeInstance.id}">编辑</g:link> </td>
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${promotionCodeInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
