<%@ page import="net.xunzhenji.wechat.WeChatImage; net.xunzhenji.wechat.Media" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'media.label', default: 'Media')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="pageNavigator left">
			<g:link controller="media" action="sync" title='同步素材' class='btnGrayS vm bigbtn'><asset:image src="text.png" class="vm" />同步素材</g:link>　
		</div>
		<div id="list-media" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="list-table"  border="0" cellspacing="0" cellpadding="0" width="100%">
			<thead>
					<tr>
						<th>${message(code: 'media.mediaId.label', default: 'MediaId')}</th>
						<th>${message(code: 'media.title.label', default: 'Title')}</th>
						<th>${message(code: 'media.type.label', default: 'Type')}</th>
				        <th>${message(code: 'media.weChatCreatedAt.label', default: 'WeChat Created At')}</th>
						<th>${message(code: 'media.fileName.label', default: 'File Name')}</th>
						<th>图片</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
				<g:each in="${mediaInstanceList}" status="i" var="mediaInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
						<td><g:link action="show"
									id="${mediaInstance.id}">${fieldValue(bean: mediaInstance, field: "mediaId")}</g:link></td>
						<td>${fieldValue(bean: mediaInstance, field: "title")}</td>
						<td>${fieldValue(bean: mediaInstance, field: "type")}</td>
						<td><g:formatDate format="yyyy-MM-dd HH:mm:ss" date="${mediaInstance.weChatCreatedAt}" /></td>
						<td>${fieldValue(bean: mediaInstance, field: "fileName")}</td>
						<td><g:if test="${mediaInstance.url}"><img width="50px" src="${mediaInstance.url}"></g:if></td>
						<td><g:link action="delete" id="${mediaInstance.id}">删除</g:link></td>
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${mediaInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
