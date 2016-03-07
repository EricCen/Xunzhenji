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
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<div id="list-userInfo" class="content scaffold-list" role="main">
			<h1>客户管理</h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<div class="panel panel-default">
				<div class="panel-heading">客户访问统计</div>

				<div class="userinfoArea panel-body" border="0" cellspacing="0" cellpadding="0" width="100%">
					<div class="tr grid">
						<div class="th col20">独立访客(UV)</div>

						<div class="td col15">${fansCount}</div>

						<div class="th col20">访问量(PV)</div>

						<div class="td col15">${visitCount}</div>

						<div class="th col20">下单数量</div>

						<div class="td col15">${orderCount}</div>
					</div>
					<div class="tr grid">
						<div class="th col20">发送朋友次数</div>

						<div class="td col15">${fansSendToFriendsCount}</div>

						<div class="th col20">分享朋友圈次数</div>

						<div class="td col15">${fansShareToTimelineCount}</div>

						<div class="th col20">关注数量</div>

						<div class="td col15">${subscribeCount}</div>
					</div>
				</div>
			</div>

			<div class="panel panel-default">
				<div class="panel-heading">客户搜索</div>
				<div class="panel-body">
					<div class="searchbar left">
						<div class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
							<g:form>
								<div class="tr grid">
									<div class="th col10">${message(code: 'userInfo.name.label', default: '姓名')}</div>

									<div class="td col5"><input id="name" name="name" class="txt" value="${name}"></div>

									<div class="th col10">${message(code: 'default.mobile.label', default: '手机')}</div>

									<div class="td col5"><input type="text" id="mobile" name="mobile" class="txt" value="${mobile}"></div>
								</div>

								<div class="tr">

									<div class="th col10">OpenId</div>

									<div class="td col5"><input type="text" id="openId" name="openId" class="txt" value="${openId}"></div>

									<div class="th col10">ID</div>

									<div class="td col5"><input id="userId" name="userId" class="txt" value="${id}"></div>

									<div class="td">
										<g:submitButton name="查询" class="btnGreen"></g:submitButton>
									</div>
								</div>
							</g:form>
						</div>
					</div>

					<table class="list-table" border="0" cellspacing="0" cellpadding="0" width="100%">
						<thead>
						<tr>
							<th>编号</th>
							<th><g:message code="userInfo.headImage.label" default="头像"/></th>

							<g:sortableColumn property="name"
											  title="${message(code: 'userInfo.name.label', default: '姓名')}"/>

							<g:sortableColumn property="mobile"
											  title="${message(code: 'default.mobile.label', default: '手机')}"/>

							<th><g:message code="userInfo.weChatName.label" default="微信昵称"/></th>

							<th>OpenID</th>

							<th><g:message code="userInfo.subscribe.label" default="关注公众号"/></th>

							<th>发送给朋友次数</th>

							<th>分享朋友圈次数</th>

							<th>访问微商城次数</th>

							<th>操作</th>
						</tr>
						</thead>
						<tbody>
						<g:each in="${userInfoInstanceList}" status="i" var="userInfoInstance">
							<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
								<td>${fieldValue(bean: userInfoInstance, field: "id")}</td>
								<td>
									<g:if test="${userInfoInstance?.weChatFans?.headImgUrl}">
										<img style="max-width: 50px" src="${userInfoInstance?.weChatFans?.headImgUrl}"/>
									</g:if>
									<g:else>
										<asset:image style="max-width: 50px" src="profile.png"/>
									</g:else>
								</td>

								<td>${fieldValue(bean: userInfoInstance, field: "name")}</td>

								<td>${fieldValue(bean: userInfoInstance, field: "mobile")}</td>

								<td>${userInfoInstance?.weChatFans?.nickName}</td>

								<td>${userInfoInstance?.weChatFans?.openId}</td>

								<td>${userInfoInstance?.weChatFans?.subscribe ? "是" : "否"}</td>

								<td>${userInfoInstance?.weChatFans?.shareToFriendsCount}</td>

								<td>${userInfoInstance?.weChatFans?.shareToTimelineCount}</td>

								<td>${userInfoInstance?.weChatFans?.visitCount}</td>

								<td><g:link action="edit" id="${userInfoInstance.id}">编辑</g:link><br>
									<g:link action="show" id="${userInfoInstance.id}">详情</g:link><br>
									<g:form action="sendCoupon">
										<g:hiddenField name="openId" value="${userInfoInstance?.weChatFans?.openId}"/>
										<g:select name="stockId"
												  from="${net.xunzhenji.wechat.WeChatCoupon.allValidCoupon()}"
												  optionKey="stockId" optionValue="name"/>
										<g:submitButton name="发优惠券"/>
									</g:form>
								</td>
							</tr>
						</g:each>
						</tbody>
					</table>

					<div class="pagination">
						<g:paginate total="${userInfoInstanceCount ?: 0}"/>
						<span>共${userInfoInstanceCount ?: 0}行</span>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>
