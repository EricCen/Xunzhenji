%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%


<%@ page import="net.xunzhenji.wechat.WeChatFans" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="admin">
    <g:set var="entityName" value="${message(code: 'weChatFans.label', default: 'WeChatFans')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>
<div class="nav" role="navigation">
    <ul>
        <li><g:link class='btnGrayS vm bigbtn' action="index"><asset:image src="text.png" class="vm"/><g:message
                code="default.list.label" args="[entityName]"/></g:link></li>
        <li><g:link class='btnGrayS vm bigbtn' action="create"><asset:image src="text.png" class="vm"/><g:message
                code="default.new.label" args="[entityName]"/></g:link></li>
    </ul>
</div>

<div id="show-weChatFans" class="content scaffold-show" role="main">
    <h1><g:message code="default.show.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <ol class="property-list weChatFans">
        <table class="userinfoArea weChatFans" border="0" cellspacing="0" cellpadding="0" width="100%">
            <tbody>

            <g:if test="${weChatFansInstance?.nickName}">
                <tr>
                    <th><span id="nickName-label" class="property-label"><g:message code="weChatFans.nickName.label"
                                                                                    default="Nick Name"/></span></th>

                    <td><span class="property-value" aria-labelledby="nickName-label"><g:fieldValue
                            bean="${weChatFansInstance}" field="nickName"/></span></td>

                </tr>
            </g:if>

            <g:if test="${weChatFansInstance?.userInfo}">
                <tr>
                    <th><span id="userInfo-label" class="property-label"><g:message code="weChatFans.userInfo.label"
                                                                                    default="User Info"/></span></th>

                    <td><span class="property-value" aria-labelledby="userInfo-label"><g:link controller="userInfo"
                                                                                              action="show"
                                                                                              id="${weChatFansInstance?.userInfo?.id}">${weChatFansInstance?.userInfo?.encodeAsHTML()}</g:link></span>
                    </td>

                </tr>
            </g:if>

            <g:if test="${weChatFansInstance?.headImgUrl}">
                <tr>
                    <th><span id="headImgUrl-label" class="property-label">
                        <g:message code="weChatFans.headImgUrl.label" default="Head Img Url"/></span>
                    </th>

                    <td>
                        <span class="property-value" aria-labelledby="headImgUrl-label">
                            <img src="${weChatFansInstance?.headImgUrl}" width="150px">
                        </span>
                    </td>
                </tr>
            </g:if>

            <g:if test="${weChatFansInstance?.openId}">
                <tr>
                    <th><span id="openId-label" class="property-label"><g:message code="weChatFans.openId.label"
                                                                                  default="Open Id"/></span></th>

                    <td><span class="property-value" aria-labelledby="openId-label"><g:fieldValue
                            bean="${weChatFansInstance}" field="openId"/></span></td>

                </tr>
            </g:if>

            <g:if test="${weChatFansInstance?.unionId}">
                <tr>
                    <th><span id="unionId-label" class="property-label"><g:message code="weChatFans.unionId.label"
                                                                                   default="Union Id"/></span></th>

                    <td><span class="property-value" aria-labelledby="unionId-label"><g:fieldValue
                            bean="${weChatFansInstance}" field="unionId"/></span></td>

                </tr>
            </g:if>

            <g:if test="${weChatFansInstance?.city}">
                <tr>
                    <th><span id="city-label" class="property-label"><g:message code="weChatFans.city.label"
                                                                                default="City"/></span></th>

                    <td><span class="property-value" aria-labelledby="city-label"><g:fieldValue
                            bean="${weChatFansInstance}" field="city"/></span></td>

                </tr>
            </g:if>

            <g:if test="${weChatFansInstance?.country}">
                <tr>
                    <th><span id="country-label" class="property-label"><g:message code="weChatFans.country.label"
                                                                                   default="Country"/></span></th>

                    <td><span class="property-value" aria-labelledby="country-label"><g:fieldValue
                            bean="${weChatFansInstance}" field="country"/></span></td>

                </tr>
            </g:if>

            <g:if test="${weChatFansInstance?.province}">
                <tr>
                    <th><span id="province-label" class="property-label"><g:message code="weChatFans.province.label"
                                                                                    default="Province"/></span></th>

                    <td><span class="property-value" aria-labelledby="province-label"><g:fieldValue
                            bean="${weChatFansInstance}" field="province"/></span></td>

                </tr>
            </g:if>

            <g:if test="${weChatFansInstance?.language}">
                <tr>
                    <th><span id="language-label" class="property-label"><g:message code="weChatFans.language.label"
                                                                                    default="Language"/></span></th>

                    <td><span class="property-value" aria-labelledby="language-label"><g:fieldValue
                            bean="${weChatFansInstance}" field="language"/></span></td>

                </tr>
            </g:if>

            <g:if test="${weChatFansInstance?.remark}">
                <tr>
                    <th><span id="remark-label" class="property-label"><g:message code="weChatFans.remark.label"
                                                                                  default="Remark"/></span></th>

                    <td><span class="property-value" aria-labelledby="remark-label"><g:fieldValue
                            bean="${weChatFansInstance}" field="remark"/></span></td>

                </tr>
            </g:if>

            <g:if test="${weChatFansInstance?.weChatGroup}">
                <tr>
                    <th><span id="weChatGroup-label" class="property-label"><g:message
                            code="weChatFans.weChatGroup.label" default="We Chat Group"/></span></th>

                    <td><span class="property-value" aria-labelledby="weChatGroup-label"><g:link
                            controller="weChatGroup" action="show"
                            id="${weChatFansInstance?.weChatGroup?.id}">${weChatFansInstance?.weChatGroup?.encodeAsHTML()}</g:link></span>
                    </td>

                </tr>
            </g:if>

            <g:if test="${weChatFansInstance?.expiresIn}">
                <tr>
                    <th><span id="expiresIn-label" class="property-label"><g:message code="weChatFans.expiresIn.label"
                                                                                     default="Expires In"/></span></th>

                    <td><span class="property-value" aria-labelledby="expiresIn-label"><g:formatDate
                            format="yyyy-MM-dd HH:mm:ss" date="${weChatFansInstance?.expiresIn}"/></span></td>

                </tr>
            </g:if>

            <g:if test="${weChatFansInstance?.scope}">
                <tr>
                    <th><span id="scope-label" class="property-label"><g:message code="weChatFans.scope.label"
                                                                                 default="Scope"/></span></th>

                    <td><span class="property-value" aria-labelledby="scope-label"><g:fieldValue
                            bean="${weChatFansInstance}" field="scope"/></span></td>

                </tr>
            </g:if>

            <g:if test="${weChatFansInstance?.shareToFriendsCount}">
                <tr>
                    <th><span id="shareToFriendsCount-label" class="property-label"><g:message
                            code="weChatFans.shareToFriendsCount.label" default="Share To Friends Count"/></span></th>

                    <td><span class="property-value" aria-labelledby="shareToFriendsCount-label"><g:fieldValue
                            bean="${weChatFansInstance}" field="shareToFriendsCount"/></span></td>

                </tr>
            </g:if>

            <g:if test="${weChatFansInstance?.shareToTimelineCount}">
                <tr>
                    <th><span id="shareToTimelineCount-label" class="property-label"><g:message
                            code="weChatFans.shareToTimelineCount.label" default="Share To Timeline Count"/></span></th>

                    <td><span class="property-value" aria-labelledby="shareToTimelineCount-label"><g:fieldValue
                            bean="${weChatFansInstance}" field="shareToTimelineCount"/></span></td>

                </tr>
            </g:if>

            <g:if test="${weChatFansInstance?.visitCount}">
                <tr>
                    <th><span id="visitCount-label" class="property-label"><g:message code="weChatFans.visitCount.label"
                                                                                      default="Visit Count"/></span>
                    </th>

                    <td><span class="property-value" aria-labelledby="visitCount-label"><g:fieldValue
                            bean="${weChatFansInstance}" field="visitCount"/></span></td>

                </tr>
            </g:if>

            <g:if test="${weChatFansInstance?.subscribe}">
                <tr>
                    <th><span id="subscribe-label" class="property-label"><g:message code="weChatFans.subscribe.label"
                                                                                     default="Subscribe"/></span></th>

                    <td><span class="property-value" aria-labelledby="subscribe-label">
                        ${weChatFansInstance?.subscribe ? "是" : "否"}
                    </span></td>

                </tr>
            </g:if>

            <g:if test="${weChatFansInstance?.subscribeTime}">
                <tr>
                    <th><span id="subscribeTime-label" class="property-label"><g:message
                            code="weChatFans.subscribeTime.label" default="Subscribe Time"/></span></th>

                    <td>
                        <span class="property-value" aria-labelledby="subscribeTime-label">
                            <g:formatDate format="yyyy-MM-dd HH:mm:ss"
                                          date="${new Date(weChatFansInstance.subscribeTime * 1000)}"/>
                        </span>
                    </td>
                </tr>
            </g:if>

            <g:if test="${weChatFansInstance?.unsubscribeTime}">
                <tr>
                    <th><span id="unsubscribeTime-label" class="property-label"><g:message
                            code="weChatFans.unsubscribeTime.label" default="Unsubscribe Time"/></span></th>

                    <td><span class="property-value" aria-labelledby="unsubscribeTime-label"><g:formatDate
                            format="yyyy-MM-dd HH:mm:ss" date="${weChatFansInstance?.unsubscribeTime}"/></span></td>

                </tr>
            </g:if>

            <g:if test="${weChatFansInstance?.lastActivityTime}">
                <tr>
                    <th><span id="lastActivityTime-label" class="property-label"><g:message
                            code="weChatFans.lastActivityTime.label" default="Last Activity Time"/></span></th>

                    <td><span class="property-value" aria-labelledby="lastActivityTime-label"><g:formatDate
                            format="yyyy-MM-dd HH:mm:ss" date="${weChatFansInstance?.lastActivityTime}"/></span></td>

                </tr>
            </g:if>

            <g:if test="${weChatFansInstance?.dateCreated}">
                <tr>
                    <th><span id="dateCreated-label" class="property-label"><g:message
                            code="default.dateCreated.label" default="Date Created"/></span></th>

                    <td><span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate
                            format="yyyy-MM-dd HH:mm:ss" date="${weChatFansInstance?.dateCreated}"/></span></td>

                </tr>
            </g:if>

            <g:if test="${weChatFansInstance?.fansLocation}">
                <tr>
                    <th><span id="fansLocation-label" class="property-label"><g:message
                            code="weChatFans.fansLocation.label" default="Fans Location"/></span></th>

                    <td>
                        <g:each in="${weChatFansInstance.fansLocation.sort { a, b -> b.createTime <=> a.createTime }}"
                                var="f">
                            <span class="property-value" aria-labelledby="fansLocation-label"><g:link
                                    controller="fansLocation" action="show"
                                    id="${f.id}">${f?.encodeAsHTML()}</g:link></span><br>
                        </g:each>
                    </td>
                </tr>
            </g:if>

            <g:if test="${weChatFansInstance?.sex}">
                <tr>
                    <th><span id="sex-label" class="property-label"><g:message code="weChatFans.sex.label"
                                                                               default="Sex"/></span></th>

                    <td><span class="property-value" aria-labelledby="sex-label">
                        ${weChatFansInstance?.sex == 1 ? "男" : weChatFansInstance?.sex == 2 ? "女" : "未知"}</span>
                    </td>
                </tr>
            </g:if>
            </tbody>
        </table>
    </ol>
    <g:form url="[resource: weChatFansInstance, action: 'delete']" method="DELETE">
        <fieldset class="buttons">
            <g:link class="btnGreen left" action="edit" resource="${weChatFansInstance}"><g:message
                    code="default.button.edit.label" default="Edit"/></g:link>
            <g:actionSubmit class="btnGreen left" action="delete"
                            value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                            onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
        </fieldset>
    </g:form>
</div>

<div class="content scaffold-show">
    <h1>发送信息</h1>
    <g:form action="sendTextMsg">
        <table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
            <tbody>
            <tr>
                <th>
                    <label for="text">发送消息</label>
                </th>
                <td><g:textArea rows="4" class="px" name="text"/>
                </td>
            </tr>
            </tbody>
        </table>
        <input type="hidden" name="openId" value="${weChatFansInstance.openId}"/>
        <input type="hidden" name="id" value="${weChatFansInstance.id}"/>
        <g:submitButton name="发送" class="btnGreen left"/>
    </g:form>
    <g:form action="sendMediaMsg">
        <table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
            <tbody>
            <tr>
                <th>
                    <label for="text">类型</label>
                </th>
                <td><g:textField class="px" name="msgType"/>
                </td>
            </tr>
            <tr>
                <th>
                    <label for="text">Media Id</label>
                </th>
                <td><g:textField class="px" name="mediaId"/>
                </td>
            </tr>
            </tbody>
        </table>
        <input type="hidden" name="openId" value="${weChatFansInstance.openId}"/>
        <input type="hidden" name="id" value="${weChatFansInstance.id}"/>
        <g:submitButton name="发送" class="btnGreen left"/>
    </g:form>
</div>
</body>
</html>
