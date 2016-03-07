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
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="nav" role="navigation">
			<ul>
				<li><g:link class='btnGrayS vm bigbtn' action="index"><asset:image src="text.png" class="vm" /><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class='btnGrayS vm bigbtn' action="create"><asset:image src="text.png" class="vm" /><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-sfSetting" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list sfSetting">
			<table class="userinfoArea sfSetting" border="0" cellspacing="0" cellpadding="0" width="100%">
				<tbody>
			
				<g:if test="${sfSettingInstance?.addedServiceCode}">
					<tr>
					<th><span id="addedServiceCode-label" class="property-label"><g:message code="sfSetting.addedServiceCode.label" default="Added Service Code" /></span></th>
					
						<td><span class="property-value" aria-labelledby="addedServiceCode-label"><g:fieldValue bean="${sfSettingInstance}" field="addedServiceCode"/></span></td>
					
					</tr>
				</g:if>
			
				<g:if test="${sfSettingInstance?.checkword}">
					<tr>
					<th><span id="checkword-label" class="property-label"><g:message code="sfSetting.checkword.label" default="Checkword" /></span></th>
					
						<td><span class="property-value" aria-labelledby="checkword-label"><g:fieldValue bean="${sfSettingInstance}" field="checkword"/></span></td>
					
					</tr>
				</g:if>
			
				<g:if test="${sfSettingInstance?.clientCode}">
					<tr>
					<th><span id="clientCode-label" class="property-label"><g:message code="sfSetting.clientCode.label" default="Client Code" /></span></th>
					
						<td><span class="property-value" aria-labelledby="clientCode-label"><g:fieldValue bean="${sfSettingInstance}" field="clientCode"/></span></td>
					
					</tr>
				</g:if>
			
				<g:if test="${sfSettingInstance?.custId}">
					<tr>
					<th><span id="custId-label" class="property-label"><g:message code="sfSetting.custId.label" default="Cust Id" /></span></th>
					
						<td><span class="property-value" aria-labelledby="custId-label"><g:fieldValue bean="${sfSettingInstance}" field="custId"/></span></td>
					
					</tr>
				</g:if>
			
				<g:if test="${sfSettingInstance?.expressType}">
					<tr>
					<th><span id="expressType-label" class="property-label"><g:message code="sfSetting.expressType.label" default="Express Type" /></span></th>
					
						<td><span class="property-value" aria-labelledby="expressType-label"><g:fieldValue bean="${sfSettingInstance}" field="expressType"/></span></td>
					
					</tr>
				</g:if>
			
				<g:if test="${sfSettingInstance?.fromAddress}">
					<tr>
					<th><span id="fromAddress-label" class="property-label"><g:message code="sfSetting.fromAddress.label" default="From Address" /></span></th>
					
						<td><span class="property-value" aria-labelledby="fromAddress-label"><g:fieldValue bean="${sfSettingInstance}" field="fromAddress"/></span></td>
					
					</tr>
				</g:if>
			
				<g:if test="${sfSettingInstance?.fromCompany}">
					<tr>
					<th><span id="fromCompany-label" class="property-label"><g:message code="sfSetting.fromCompany.label" default="From Company" /></span></th>
					
						<td><span class="property-value" aria-labelledby="fromCompany-label"><g:fieldValue bean="${sfSettingInstance}" field="fromCompany"/></span></td>
					
					</tr>
				</g:if>
			
				<g:if test="${sfSettingInstance?.fromContact}">
					<tr>
					<th><span id="fromContact-label" class="property-label"><g:message code="sfSetting.fromContact.label" default="From Contract" /></span></th>
					
						<td><span class="property-value" aria-labelledby="fromContact-label"><g:fieldValue bean="${sfSettingInstance}" field="fromContact"/></span></td>
					
					</tr>
				</g:if>
			
				<g:if test="${sfSettingInstance?.fromTel}">
					<tr>
					<th><span id="fromTel-label" class="property-label"><g:message code="sfSetting.fromTel.label" default="From Tel" /></span></th>
					
						<td><span class="property-value" aria-labelledby="fromTel-label"><g:fieldValue bean="${sfSettingInstance}" field="fromTel"/></span></td>
					
					</tr>
				</g:if>
			
				<g:if test="${sfSettingInstance?.payMethod}">
					<tr>
					<th><span id="payMethod-label" class="property-label"><g:message code="sfSetting.payMethod.label" default="Pay Method" /></span></th>
					
						<td><span class="property-value" aria-labelledby="payMethod-label"><g:fieldValue bean="${sfSettingInstance}" field="payMethod"/></span></td>
					
					</tr>
				</g:if>
			
				<g:if test="${sfSettingInstance?.shipperCode}">
					<tr>
					<th><span id="shipperCode-label" class="property-label"><g:message code="sfSetting.shipperCode.label" default="Shipper Code" /></span></th>
					
						<td><span class="property-value" aria-labelledby="shipperCode-label"><g:fieldValue bean="${sfSettingInstance}" field="shipperCode"/></span></td>
					
					</tr>
				</g:if>
			
			</ol>
			<g:form url="[resource:sfSettingInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="btnGreen left" action="edit" resource="${sfSettingInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="btnGreen left" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
