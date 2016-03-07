%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%


<%@ page import="net.xunzhenji.vendor.SfSetting" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'sfSetting.label', default: 'SfSetting')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="pageNavigator left">
			<g:link action="create" class='btnGrayS vm bigbtn'><asset:image src="text.png" class="vm" /><g:message code="default.new.label" args="[entityName]" /></g:link>
		</div>
		<div id="list-sfSetting" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="list-table"  border="0" cellspacing="0" cellpadding="0" width="100%">
			<thead>
					<tr>

						<g:sortableColumn property="checkword" title="${message(code: 'sfSetting.serverAddress.label', default: '服务器地址')}" />

						<g:sortableColumn property="checkword" title="${message(code: 'sfSetting.checkword.label', default: 'Checkword')}" />
					
						<g:sortableColumn property="clientCode" title="${message(code: 'sfSetting.clientCode.label', default: 'Client Code')}" />
					
						<g:sortableColumn property="custId" title="${message(code: 'sfSetting.custId.label', default: 'Cust Id')}" />
					
						<g:sortableColumn property="expressType" title="${message(code: 'sfSetting.expressType.label', default: 'Express Type')}" />
					
						<g:sortableColumn property="fromAddress" title="${message(code: 'sfSetting.fromAddress.label', default: 'From Address')}" />
					
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
				<g:each in="${sfSettingInstanceList}" status="i" var="sfSettingInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${sfSettingInstance.id}">${fieldValue(bean: sfSettingInstance, field: "serverAddress")}</g:link></td>
					
						<td>${fieldValue(bean: sfSettingInstance, field: "checkword")}</td>
					
						<td>${fieldValue(bean: sfSettingInstance, field: "clientCode")}</td>
					
						<td>${fieldValue(bean: sfSettingInstance, field: "custId")}</td>
					
						<td>${fieldValue(bean: sfSettingInstance, field: "expressType")}</td>
					
						<td>${fieldValue(bean: sfSettingInstance, field: "fromAddress")}</td>
					
						<td><g:link action="edit" id="${sfSettingInstance.id}">编辑</g:link> </td>
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${sfSettingInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
