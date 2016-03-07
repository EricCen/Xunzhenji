
<%@ page import="net.xunzhenji.datacollect.FansLocation" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'fansLocation.label', default: 'FansLocation')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="pageNavigator left">
			<g:link action="create" class='btnGrayS vm bigbtn'><asset:image src="text.png" class="vm" /><g:message code="default.new.label" args="[entityName]" /></g:link>
		</div>
		<div id="list-fansLocation" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="list-table"  border="0" cellspacing="0" cellpadding="0" width="100%">
			<thead>
					<tr>
					
						<g:sortableColumn property="openId" title="${message(code: 'fansLocation.openId.label', default: 'Open Id')}" />
					
						<g:sortableColumn property="createTime" title="${message(code: 'fansLocation.createTime.label', default: 'Create Time')}" />
					
						<g:sortableColumn property="latitude" title="${message(code: 'fansLocation.latitude.label', default: 'Latitude')}" />
					
						<g:sortableColumn property="locationPrecision" title="${message(code: 'fansLocation.locationPrecision.label', default: 'Location Precision')}" />
					
						<g:sortableColumn property="longitude" title="${message(code: 'fansLocation.longitude.label', default: 'Longitude')}" />
					