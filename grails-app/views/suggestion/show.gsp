
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
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="nav" role="navigation">
			<ul>
				<li><g:link class='btnGrayS vm bigbtn' action="index"><asset:image src="text.png" class="vm" /><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class='btnGrayS vm bigbtn' action="create"><asset:image src="text.png" class="vm" /><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-suggestion" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list suggestion">
			<table class="userinfoArea suggestion" border="0" cellspacing="0" cellpadding="0" width="100%">
				<tbody>
			
				%{--<g:if test="${suggestionInstance?.userInfo}">--}%
					%{--<tr>--}%
					%{--<th><span id="userInfo-label" class="property-label"><g:message code="suggestion.userInfo.label" default="User Info" /></span></th>--}%
					%{----}%
						%{--<td><span class="property-value" aria-labelledby="userInfo-label"><g:link controller="userInfo" action="show" id="${suggestionInstance?.userInfo?.id}">${suggestionInstance?.userInfo?.encodeAsHTML()}</g:link></span></td>--}%
					%{----}%
					%{--</tr>--}%
				%{--</g:if>--}%
			
				<g:if test="${suggestionInstance?.content}">
					<tr>
					<th><span id="content-label" class="property-label"><g:message code="default.content.label" default="Content" /></span></th>
					
						<td><span class="property-value" aria-labelledby="content-label"><g:fieldValue bean="${suggestionInstance}" field="content"/></span></td>
					
					</tr>
				</g:if>
			
				<g:if test="${suggestionInstance?.dateCreated}">
					<tr>
					<th><span id="summary-label" class="property-label"><g:message code="default.dateCreated.label" default="dateCreated" /></span></th>
					
						<td><span class="property-value" aria-labelledby="summary-label"><g:fieldValue bean="${suggestionInstance}" field="content"/></span></td>
					
					</tr>
				</g:if>

				<g:if test="${suggestionInstance?.reply}">
					<tr>
						<th><span id="reply-label" class="property-label"><g:message code="suggestion.reply.label" default="reply" /></span></th>

						<td><span class="property-value" aria-labelledby="reply-label"><g:fieldValue bean="${suggestionInstance}" field="reply"/></span></td>

					</tr>
				</g:if>

				<g:if test="${suggestionInstance?.replyDate}">
					<tr>
						<th><span id="replyDate-label" class="property-label"><g:message code="suggestion.replyDate.label" default="replyDate" /></span></th>

						<td><span class="property-value" aria-labelledby="reply-label"><g:fieldValue bean="${suggestionInstance}" field="replyDate"/></span></td>

					</tr>
				</g:if>
			
			</ol>
			<g:form url="[resource:suggestionInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="btnGreen left" action="edit" resource="${suggestionInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="btnGreen left" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
