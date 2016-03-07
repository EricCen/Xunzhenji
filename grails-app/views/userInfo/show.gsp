%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%


<%@ page import="net.xunzhenji.mall.UserInfo" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'userInfo.label', default: 'UserInfo')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="nav" role="navigation">
			<ul>
				<li><g:link class='btnGrayS vm bigbtn' action="index"><asset:image src="text.png" class="vm" /><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class='btnGrayS vm bigbtn' action="create"><asset:image src="text.png" class="vm" /><g:message code="default.new.label" args="[entityName]" /></g:link></li>
				<g:if test="${userInfoInstance?.weChatFans}">
					<li><g:link class='btnGrayS vm bigbtn' action="show" controller="weChatFans"
								id="${userInfoInstance?.weChatFans?.id}"><asset:image src="text.png"
																					  class="vm"/>查看粉丝</g:link></li>
				</g:if>
			</ul>
		</div>
		<div id="show-userInfo" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list userInfo">
			<table class="userinfoArea userInfo" border="0" cellspacing="0" cellpadding="0" width="100%">
				<tbody>
			
				<g:if test="${userInfoInstance?.name}">
					<tr>
					<th><span id="name-label" class="property-label"><g:message code="userInfo.name.label" default="Name" /></span></th>
					
						<td><span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${userInfoInstance}" field="name"/></span></td>
					
					</tr>
				</g:if>
			
				<g:if test="${userInfoInstance?.mobile}">
					<tr>
					<th><span id="mobile-label" class="property-label"><g:message code="default.mobile.label" default="Mobile" /></span></th>
					
						<td><span class="property-value" aria-labelledby="mobile-label"><g:fieldValue bean="${userInfoInstance}" field="mobile"/></span></td>
					
					</tr>
				</g:if>
			
				<g:if test="${userInfoInstance?.weChatFans}">
					<tr>
					<th><span id="weChatFans-label" class="property-label"><g:message code="userInfo.weChatFans.label" default="We Chat Fans" /></span></th>
					
						<td><span class="property-value" aria-labelledby="weChatFans-label"><g:link controller="weChatFans" action="show" id="${userInfoInstance?.weChatFans?.id}">${userInfoInstance?.weChatFans?.encodeAsHTML()}</g:link></span></td>
					
					</tr>
				</g:if>
			
				<g:if test="${userInfoInstance?.person}">
					<tr>
					<th><span id="person-label" class="property-label"><g:message code="userInfo.person.label" default="Person" /></span></th>
					
						<td><span class="property-value" aria-labelledby="person-label"><g:link controller="person" action="show" id="${userInfoInstance?.person?.id}">${userInfoInstance?.person?.encodeAsHTML()}</g:link></span></td>
					
					</tr>
				</g:if>
				<g:if test="${userInfoInstance?.payments}">
					<tr>
						<th><span id="payments-label" class="property-label"><g:message code="payment.label"
																						default="Payments"/></span></th>
						<td>
						<g:each in="${userInfoInstance.payments}" var="p">
							<span class="property-value" aria-labelledby="payments-label"><g:link
									controller="payment" action="show"
									id="${p.id}">${p?.encodeAsHTML()}</g:link></span><br>
						</g:each>
						</td>
					</tr>
				</g:if>

				<g:if test="${userInfoInstance?.shoppingCart}">
					<tr>
						<th><span id="shoppingCart-label" class="property-label"><g:message code="shoppingCart.label"
																							default="Shopping Cart"/></span>
						</th>

						<td><span class="property-value" aria-labelledby="shoppingCart-label"><g:link
								controller="shoppingCart" action="show"
								id="${userInfoInstance?.shoppingCart?.id}">${userInfoInstance?.shoppingCart?.encodeAsHTML()}</g:link></span>
						</td>

					</tr>
				</g:if>

				<g:if test="${userInfoInstance?.weChatFans?.lastActivityTime}">
					<tr>
						<th><span id="lastActivityTime-label" class="property-label"><g:message
								code="wechatFans.lastActivityTime.label" default="lastActivityTime"/></span></th>

						<td><span class="property-value" aria-labelledby="lastActivityTime-label"><g:formatDate
								format="yyyy-MM-dd HH:mm:ss"
								date="${userInfoInstance?.weChatFans?.lastActivityTime}"/></span></td>

					</tr>
				</g:if>
				<g:if test="${userInfoInstance?.address}">
					<tr>
					<th><span id="address-label" class="property-label"><g:message code="default.address.label" default="Address" /></span></th>
						<td>
						<g:each in="${userInfoInstance.address}" var="a">
							<span class="property-value" aria-labelledby="address-label">
								<g:link controller="address"
										action="show"
										id="${a.id}">${a?.encodeAsHTML()}</g:link>
							</span>
						</g:each>
						</td>
					</tr>
				</g:if>
			
				<g:if test="${userInfoInstance?.orders}">
					<tr>
					<th><span id="orders-label" class="property-label"><g:message code="productOrder.label" default="Orders" /></span></th>
						<td>
						<g:each in="${userInfoInstance.orders}" var="o">
							<span class="property-value" aria-labelledby="orders-label"><g:link
									controller="productOrder" action="show"
									id="${o.id}">${o?.encodeAsHTML()}</g:link></span><br>
						</g:each>
						</td>
					</tr>
				</g:if>
			</ol>
			<g:form url="[resource:userInfoInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="btnGreen left" action="edit" resource="${userInfoInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="btnGreen left" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
