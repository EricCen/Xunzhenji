
%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%

<%@ page import="net.xunzhenji.mall.Suggestion" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'suggestion.label', default: 'Suggestion')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="pageNavigator left">
			<g:link action="create" class='btnGrayS vm bigbtn'><asset:image src="text.png" class="vm" /><g:message code="default.new.label" args="[entityName]" /></g:link>
		</div>
		<div id="list-suggestion" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="list-table"  border="0" cellspacing="0" cellpadding="0" width="100%">
			<thead>
					<tr>
					
						<th><g:message code="suggestion.wechat" default="用户" /></th>
					
						<g:sortableColumn property="content" title="${message(code: 'suggestion.content.label', default: '建议内容')}" />
						<g:sortableColumn property="summary" title="${message(code: 'suggestion.summary.label', default: '时间')}" />
						<g:sortableColumn property="reply" title="${message(code: 'suggestion.reply.label', default: '回复')}" />
						<g:sortableColumn property="replyDate" title="${message(code: 'suggestion.replyDate.label', default: '回复时间')}" />

						<th>操作</th>
					</tr>
				</thead>
				<tbody>
				<g:each in="${suggestionInstanceList}" status="i" var="suggestionInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${suggestionInstance.id}">${fieldValue(bean: suggestionInstance, field: "weChatFans")}</g:link></td>
						<td>${fieldValue(bean: suggestionInstance, field: "content")}</td>
						<td>${fieldValue(bean: suggestionInstance, field: "dateCreated")}</td>
						<td>${fieldValue(bean: suggestionInstance, field: "reply")}</td>
						<td>${fieldValue(bean: suggestionInstance, field: "replyDate")}</td>
					
						<td><g:link action="edit" id="${suggestionInstance.id}">编辑</g:link> </td>
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${suggestionInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
