
%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%

<%@ page import="net.xunzhenji.mall.Batch" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'batch.label', default: 'Batch')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="pageNavigator left">
			<g:link action="create" class='btnGrayS vm bigbtn'><asset:image src="text.png" class="vm" /><g:message code="default.new.label" args="[entityName]" /></g:link>
		</div>
		<div id="list-batch" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="list-table"  border="0" cellspacing="0" cellpadding="0" width="100%">
			<thead>
					<tr>
					
						<g:sortableColumn property="title" title="${message(code: 'default.title.label', default: 'Title')}" />
					
						<th><g:message code="product.label" default="Product" /></th>

                        <g:sortableColumn property="price" title="${message(code: 'batch.price.label', default: 'Price')}" />

                        <g:sortableColumn property="discount" title="${message(code: 'batch.discount.label', default: 'Discount')}" />
					
						<g:sortableColumn property="productionDate" title="${message(code: 'batch.productionDate.label', default: 'Production Date')}" />

						<g:sortableColumn property="display" title="${message(code: 'batch.display.label', default: 'Production Date')}" />

						<th>权重</th>

						<th>操作</th>
					</tr>
				</thead>
				<tbody>
				<g:each in="${batchInstanceList}" status="i" var="batchInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${batchInstance.id}">${fieldValue(bean: batchInstance, field: "title")}</g:link></td>
					
						<td>${fieldValue(bean: batchInstance, field: "product.title")}</td>

                        <td>${fieldValue(bean: batchInstance, field: "price")}</td>

                        <td>${fieldValue(bean: batchInstance, field: "discount")}</td>
					
						<td><g:formatDate date="${batchInstance?.productionDate}" format="yyyy-MM-dd" /></td>

						<td><g:formatBoolean boolean="${batchInstance?.display}" true="是" false="否"/></td>

						<td style="width: 5em;">
							<g:form action="updateProductPageWeight">
								<g:field name="productPageWeight" type="number" style="width: 3em;"
										 value="${batchInstance.productPageWeight}"/>
								<g:hiddenField name="id" value="${batchInstance.id}"/>
								<g:submitButton name="修改"/>
							</g:form>
						</td>

						<td><g:link action="edit" id="${batchInstance.id}">编辑</g:link>
                            <g:link action="updateBatchPrice" id="${batchInstance.id}">跟新批次价格</g:link>
							<g:link action="show" id="${batchInstance.id}">预览</g:link>
						</td>
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${batchInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
