%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%


<%@ page import="net.xunzhenji.wechat.Template" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'template.label', default: 'Template')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="pageNavigator left">
			<g:link action="create" class='btnGrayS vm bigbtn'><asset:image src="text.png" class="vm" /><g:message code="default.new.label" args="[entityName]" /></g:link>
		</div>
		<div id="list-template" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="list-table"  border="0" cellspacing="0" cellpadding="0" width="100%">
			<thead>
					<tr>

						<g:sortableColumn property="templateIdShort" title="${message(code: 'template.templateIdShort.label', default: 'Template Id Short')}" />

						<g:sortableColumn property="templateContent" title="${message(code: 'template.templateContent.label', default: 'Template Content')}" />
					
						<g:sortableColumn property="templateId" title="${message(code: 'template.templateId.label', default: 'Template Id')}" />

						<th>操作</th>
					</tr>
				</thead>
				<tbody>
				<g:each in="${templateInstanceList}" status="i" var="templateInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

						<td>${fieldValue(bean: templateInstance, field: "templateIdShort")}</td>

						<td>${templateInstance?.templateContent?.replaceAll("\n", "<br>")}</td>
					
						<td>${fieldValue(bean: templateInstance, field: "templateId")}</td>
					
						<td>
							<g:link action="edit" id="${templateInstance.id}">编辑</g:link>
							<g:link action="addToWechat" id="${templateInstance.id}">向微信添加模板</g:link>

						</td>
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${templateInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
