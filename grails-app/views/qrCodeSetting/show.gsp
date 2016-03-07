%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%


<%@ page import="net.xunzhenji.QrCodeSetting" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'qrCodeSetting.label', default: 'QrCodeSetting')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="nav" role="navigation">
			<ul>
				<li><g:link class='btnGrayS vm bigbtn' action="index"><asset:image src="text.png" class="vm" /><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class='btnGrayS vm bigbtn' action="create"><asset:image src="text.png" class="vm" /><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-qrCodeSetting" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="userinfoArea qrCodeSetting" border="0" cellspacing="0" cellpadding="0" width="100%">
				<tbody>

				<g:if test="${qrCodeSettingInstance?.title}">
					<tr>
						<th><span id="title-label" class="property-label"><g:message code="default.title.label" default="标题" /></span></th>

						<td><span class="property-value" aria-labelledby="title-label">${qrCodeSettingInstance?.title}</span></td>

					</tr>
				</g:if>

				<g:if test="${qrCodeSettingInstance?.batch}">
					<tr>
						<th><span id="batch-label" class="property-label"><g:message code="batch.label" default="Batch" /></span></th>

						<td><span class="property-value" aria-labelledby="batch-label"><g:link controller="batch" action="show" id="${qrCodeSettingInstance?.batch?.id}">${qrCodeSettingInstance?.batch?.encodeAsHTML()}</g:link></span></td>

					</tr>
				</g:if>

				<g:if test="${qrCodeSettingInstance?.variable}">
					<tr>
					<th><span id="variable-label" class="property-label"><g:message code="qrCodeSetting.variable.label" default="Variable" /></span></th>
					
						<td><span class="property-value" aria-labelledby="variable-label"><g:fieldValue bean="${qrCodeSettingInstance}" field="variable"/></span></td>
					
					</tr>
				</g:if>
			
				<g:if test="${qrCodeSettingInstance?.qrCodes}">
					<tr>
						<th><span id="qrCodes-label" class="property-label"><g:message code="qrCodeSetting.label"
																					   default="Qr Codes"/></span></th>
						<td>
						<g:each in="${qrCodeSettingInstance.qrCodes}" var="q">
							<span class="property-value" aria-labelledby="qrCodes-label">
								编号:${q?.qrCodeId}, 创建时间:<g:formatDate format="yyMMdd HH:mm:ss" date="${q.dateCreated}"/></span><br>
						</g:each>
						</td>
					</tr>
				</g:if>

				<g:if test="${fans}">
					<tr>
						<th><span id="fans-label" class="property-label">录入人微信</span></th>
						<td>
							<g:each in="${fans}" var="f">
								<span class="property-value"
									  aria-labelledby="qrCodes-label">${f?.nickName}</span> - ${f?.openId} <br>
							</g:each>
						</td>
					</tr>
				</g:if>
				</tbody>
			</table>
			<g:form url="[resource:qrCodeSettingInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="btnGreen left" action="edit" resource="${qrCodeSettingInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="btnGreen left" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
