%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%


<%@ page import="net.xunzhenji.mall.CouponTemplate" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'coupon.label', default: 'Coupon')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="pageNavigator left">
			<g:link action="create" class='btnGrayS vm bigbtn'><asset:image src="text.png" class="vm" /><g:message code="default.new.label" args="[entityName]" /></g:link>
		</div>
		<div id="list-coupon" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="list-table"  border="0" cellspacing="0" cellpadding="0" width="100%">
			<thead>
					<tr>
						<g:sortableColumn property="title" title="${message(code: 'default.title.label', default: 'Title')}" />
						<th><g:message code="product.label" default="Product" /></th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
				<g:each in="${couponInstanceList}" status="i" var="couponInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${couponInstance.id}">${fieldValue(bean: couponInstance, field: "title")}</g:link></td>
					
						<td>${fieldValue(bean: couponInstance, field: "product")}</td>
					
						<td><g:link action="edit" id="${couponInstance.id}">编辑</g:link> </td>
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${couponInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
