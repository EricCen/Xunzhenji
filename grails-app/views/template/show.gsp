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
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="nav" role="navigation">
			<ul>
				<li><g:link class='btnGrayS vm bigbtn' action="index"><asset:image src="text.png" class="vm" /><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class='btnGrayS vm bigbtn' action="create"><asset:image src="text.png" class="vm" /><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-template" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list template">
			<table class="userinfoArea template" border="0" cellspacing="0" cellpadding="0" width="100%">
				<tbody>

				<g:if test="${templateInstance?.name}">
					<tr>
						<th><span id="name-label" class="property-label"><g:message code="default.name.label" default="Template Id Short" /></span></th>

						<td><span class="property-value" aria-labelledby="templateIdShort-label"><g:fieldValue bean="${templateInstance}" field="name"/></span></td>

					</tr>
				</g:if>

				<g:if test="${templateInstance?.templateIdShort}">
					<tr>
						<th><span id="templateIdShort-label" class="property-label"><g:message code="template.templateIdShort.label" default="Template Id Short" /></span></th>

						<td><span class="property-value" aria-labelledby="templateIdShort-label"><g:fieldValue bean="${templateInstance}" field="templateIdShort"/></span></td>

					</tr>
				</g:if>

				<g:if test="${templateInstance?.templateContent}">
					<tr>
					<th>
						<span id="templateContent-label" class="property-label">
							<g:message code="template.templateContent.label" default="Template Content" />
						</span>
					</th>
					
						<td>
							${templateInstance?.templateContent?.replaceAll("\n", "<br>")}
						</td>
					
					</tr>
				</g:if>
			
				<g:if test="${templateInstance?.templateId}">
					<tr>
						<th><span id="templateId-label" class="property-label"><g:message code="template.templateId.label" default="Template Id" /></span></th>
					
						<td><span class="property-value" aria-labelledby="templateId-label"><g:fieldValue bean="${templateInstance}" field="templateId"/></span></td>
					
					</tr>
				</g:if>

			
			</ol>
			<g:form url="[resource:templateInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="btnGreen left" action="edit" resource="${templateInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>

					<g:actionSubmit class="btnGreen left" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>

		<div>
			<g:form action="send" method="POST" >
				<input type="hidden" name="id" value="${templateInstance.id}">
				<table>
					<tbody>
					<tr>
						<th><label for="templateJson">模板对象</label></th>
						<td><g:textArea rows="5" style="width:580px;border: ridge;" name="templateJson" required=""
										value="${templateInstance?.templateJson}"/>
						</td>
					</tr>
					<tr>
						<th><label for="openId">OpenId</label></th>
						<td><g:textField class="px" name="openId" placeholder="openId"/></td>
					</tr>
					<tr>
						<th><label for="url">URL</label></th>
						<td><g:textField class="px" name="url" placeholder="URL"/></td>
					</tr>
					</tbody>
				</table>
				<g:actionSubmit class="btnGreen left" action="send" value="发送测试消息" />
			</g:form>
		</div>
	</body>
</html>
