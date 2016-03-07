%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%


<%@ page import="net.xunzhenji.wechat.WeChatMenu" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'weChatMenu.label', default: 'WeChatMenu')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="pageNavigator left">
			<g:if test="${net.xunzhenji.wechat.WeChatMenu.count()==0}">
				<g:link action="create" class='btnGrayS vm bigbtn'><asset:image src="text.png" class="vm" /><g:message code="default.new.label" args="[entityName]" /></g:link>
			</g:if>
			<g:link action="sync" class='btnGrayS vm bigbtn'>从微信同步菜单</g:link>
			<g:link action="upload" class='btnGrayS vm bigbtn'>向微信同步菜单</g:link>
		</div>
		<div id="list-weChatMenu" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="list-table"  border="0" cellspacing="0" cellpadding="0" width="100%">
			<thead>
					<tr>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
				<g:each in="${weChatMenuInstanceList}" status="i" var="weChatMenuInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="edit" id="${weChatMenuInstance.id}">编辑</g:link> </td>
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${weChatMenuInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
