%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%


<%@ page import="net.xunzhenji.mall.LxGroup" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'lxGroup.label', default: 'LxGroup')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="pageNavigator left">
			<g:link action="create" class='btnGrayS vm bigbtn'><asset:image src="text.png" class="vm" /><g:message code="default.new.label" args="[entityName]" /></g:link>
		</div>
		<div id="list-lxGroup" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="list-table"  border="0" cellspacing="0" cellpadding="0" width="100%">
			<thead>
					<tr>
                        <g:sortableColumn property="groupName" title="${message(code: 'lxGroup.groupName.label', default: 'Group Name')}" />
                        <th><g:message code="lxGroup.organizer.label" default="Organizer" /></th>
                        <th>微信号</th>
                        <g:sortableColumn property="deliverable" title="${message(code: 'lxGroup.deliverable.label', default: 'Deliverable')}" />
						<th><g:message code="lxGroup.address.label" default="Address" /></th>
						<g:sortableColumn property="phone" title="${message(code: 'lxGroup.phone.label', default: 'Phone')}" />
                        <g:sortableColumn property="dateCreated" title="${message(code: 'default.dateCreated.label', default: 'Date Created')}" />
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
				<g:each in="${lxGroupInstanceList}" status="i" var="lxGroupInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
						<td><g:link action="show" id="${lxGroupInstance.id}">${fieldValue(bean: lxGroupInstance, field: "groupName")}</g:link></td>
                        <td>${fieldValue(bean: lxGroupInstance, field: "organizer")}</td>
                        <td>${lxGroupInstance.wechatAccount}</td>
						<td><g:formatBoolean false="否" true="是" boolean="${lxGroupInstance.deliverable}" /></td>
						<td>${fieldValue(bean: lxGroupInstance, field: "address")}</td>
						<td>${fieldValue(bean: lxGroupInstance, field: "phone")}</td>
                        <td><g:formatDate format="yyyy-MM-dd HH:mm:ss" date="${lxGroupInstance.dateCreated}" /></td>
						<td><g:link action="edit" id="${lxGroupInstance.id}">编辑</g:link>
						<a href="#" onclick="createDeliveryList('${createLink(controller: "lxGroup", action: "createOneMonthDelivery", id: lxGroupInstance.id)}');">生产发货清单</a>
						</td>
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${lxGroupInstanceCount ?: 0}" />
			</div>
		</div>

	<script>
		function createDeliveryList(url){
			$.get(url);
		}
	</script>
	</body>
</html>
