
<%@ page import="net.xunzhenji.mall.Product" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'product.label', default: 'Product')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="pageNavigator left">
			<g:link action="create" class='btnGrayS vm bigbtn'><asset:image src="text.png" class="vm" /><g:message code="default.new.label" args="[entityName]" /></g:link>
		</div>
		<div id="list-product" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="list-table"  border="0" cellspacing="0" cellpadding="0" width="100%">
			<thead>
					<tr>
						<g:sortableColumn property="title" title="${message(code: 'default.title.label', default: '标题')}" />
						<g:sortableColumn property="category.name" title="${message(code: 'category.label', default: '商品分类')}" />
						<g:sortableColumn property="price" title="${message(code: 'product.price.label', default: '价格')}" />
						<g:sortableColumn property="weight" title="${message(code: 'product.weight.label', default: '重量')}" />
						<g:sortableColumn property="origin" title="${message(code: 'product.origin.label', default: '产地')}" />
						<g:sortableColumn property="extraPeriod" title="${message(code: 'product.extraPeriod.label', default: '保质期')}" />
						<g:sortableColumn property="quantityInStore" title="${message(code: 'product.quantityInStore.label', default: '库存')}" />
						<g:sortableColumn property="homePageWeight" style="width: 5em;"
										  title="${message(code: 'product.homePageWeight.label', default: '首页权重 负数不显示')}"/>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
				<g:each in="${productInstanceList}" status="i" var="productInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
						<td><g:link action="show" id="${productInstance.id}">${fieldValue(bean: productInstance, field: "title")}</g:link></td>
						<td>${productInstance.category?.name}</td>
						<td>￥${fieldValue(bean: productInstance, field: "price")}</td>
						<td>${fieldValue(bean: productInstance, field: "weight")}g</td>
						<td>${fieldValue(bean: productInstance, field: "origin")}</td>
						<td>${fieldValue(bean: productInstance, field: "extraPeriod")}天</td>
						<td>${fieldValue(bean: productInstance, field: "quantityInStore")}</td>
						<td style="width: 5em;">
							<g:form action="updateHomePageWeight">
								<g:field name="homePageWeight" type="number" style="width: 3em;"
										 value="${productInstance.homePageWeight}"/>
								<g:hiddenField name="id" value="${productInstance.id}"/>
								<g:submitButton name="修改" />
							</g:form>
						</td>
						<td><g:link action="edit" id="${productInstance.id}">编辑</g:link>
						<g:link action="show" id="${productInstance.id}">预览</g:link>
						</td>
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${productInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
