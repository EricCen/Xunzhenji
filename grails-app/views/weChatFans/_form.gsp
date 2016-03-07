<%@ page import="net.xunzhenji.wechat.WeChatFans" %>

<div style="display: flex;flex-flow: row;">
    <section style="margin-right: 10px;">
        <table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
            <tbody>
            <tr>
                <th>
                    <label for="nickName"><g:message code="weChatFans.nickName.label" default="Nick Name"/></label>
                </th>
                <td><g:textField class="px" style="width:300px;" name="nickName"
                                 value="${weChatFansInstance?.nickName}"/>
                </td>
            </tr>
            </tbody>
        </table>

        <div style="display: -webkit-box;">
            <div style="width: 50%;">
                <table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
                    <tbody>
                    <tr>
                        <th>
                            <label><g:message code="weChatFans.userInfo.label" default="User Info"/></label>
                        </th>
                        <td>
                            <g:link action="show" controller="userInfo"
                                    id="${weChatFansInstance?.userInfo?.id}">${weChatFansInstance?.userInfo?.name}</g:link>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>

            <div style="width: 40%; padding-left: 10px;">
                <table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
                    <tbody>
                    <tr>
                        <th>
                            <label><g:message code="weChatFans.sex.label" default="Sex"/></label>
                        </th>
                        <td>${weChatFansInstance.sex == 1 ? "男" : weChatFansInstance.sex == 2 ? "女" : "未知"}
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <div style="display: -webkit-box;">
            <div style="width: 50%;">
                <table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
                    <tbody>
                    <tr>
                        <th>
                            <label><g:message code="weChatFans.country.label" default="Country"/></label>
                        </th>
                        <td>${weChatFansInstance?.country ? weChatFansInstance?.country : "未知"}</td>
                    </tr>
                    </tbody>
                </table>
            </div>

            <div style="width: 40%; padding-left: 10px;">
                <table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
                    <tbody>
                    <tr>
                        <th>
                            <label><g:message code="weChatFans.province.label" default="Province"/></label>
                        </th>
                        <td>${weChatFansInstance?.province ? weChatFansInstance?.province : "未知"}</td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <div style="display: -webkit-box;">
            <div style="width: 50%;">
                <table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
                    <tbody>
                    <tr>
                        <th>
                            <label><g:message code="weChatFans.city.label" default="City"/></label>
                        </th>
                        <td>${weChatFansInstance?.city ? weChatFansInstance?.city : "未知"}</td>
                    </tr>
                    </tbody>
                </table>
            </div>

            <div style="width: 40%; padding-left: 10px;">
                <table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
                    <tbody>
                    <tr>
                        <th>
                            <label><g:message code="weChatFans.language.label" default="Language"/></label>
                        </th>
                        <td>${weChatFansInstance?.language ? weChatFansInstance?.language : "未知"}
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <div style="display: -webkit-box;">
            <div style="width: 50%;">
                <table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
                    <tbody>
                    <tr>
                        <th>
                            <label><g:message code="weChatFans.subscribe.label" default="Subscribe"/><span
                                    class="required-indicator">*</span></label>
                        </th>
                        <td>${weChatFansInstance?.subscribe ? "是" : "否"}
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>

            <div style="width: 40%; padding-left: 10px;">
                <table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
                    <tbody>
                    <tr>
                        <th>
                            <label for="weChatGroup"><g:message code="weChatFans.weChatGroup.label"
                                                                default="We Chat Group"/></label>
                        </th>
                        <td><g:select id="weChatGroup" name="weChatGroup.id"
                                      from="${net.xunzhenji.wechat.WeChatGroup.list()}"
                                      optionKey="id" value="${weChatFansInstance?.weChatGroup?.id}" class="many-to-one"
                                      noSelection="['null': '']"/>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </section>

    <nav style="flex: 2;">
        <img src="${weChatFansInstance?.headImgUrl}" width="200px">
    </nav>
</div>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="remark"><g:message code="weChatFans.remark.label" default="Remark"/></label>
        </th>
        <td><g:textField class="px" name="remark" value="${weChatFansInstance?.remark}"/>
        </td>
    </tr>
    </tbody>
</table>

<div style="display: -webkit-box;">
    <div style="width: 30%;">
        <table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
            <tbody>
            <tr>
                <th>
                    <label for="visitCount"><g:message code="weChatFans.visitCount.label"
                                                       default="Visit Count"/></label>
                </th>
                <td><g:field name="visitCount" type="number" value="${weChatFansInstance.visitCount}"/>
                </td>
            </tr>
            </tbody>
        </table>
    </div>

    <div style="width: 30%; padding-left: 10px;">
        <table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
            <tbody>
            <tr>
                <th>
                    <label for="shareToFriendsCount"><g:message code="weChatFans.shareToFriendsCount.label"
                                                                default="Share To Friends Count"/></label>
                </th>
                <td><g:field name="shareToFriendsCount" type="number"
                             value="${weChatFansInstance.shareToFriendsCount}"/>
                </td>
            </tr>
            </tbody>
        </table>
    </div>

    <div style="width: 30%; padding-left: 10px;">
        <table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
            <tbody>
            <tr>
                <th>
                    <label for="shareToTimelineCount"><g:message code="weChatFans.shareToTimelineCount.label"
                                                                 default="Share To Timeline Count"/></label>
                </th>
                <td><g:field name="shareToTimelineCount" type="number"
                             value="${weChatFansInstance.shareToTimelineCount}"/>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
</div>

<div style="display: -webkit-box;">
    <div style="width: 30%;">
        <table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
            <tbody>
            <tr>
                <th>
                    <label><g:message code="weChatFans.subscribeTime.label" default="Subscribe Time"/><span
                            class="required-indicator">*</span></label>
                </th>
                <td><g:formatDate format="yyyy-MM-dd hh:mm:ss"
                                  date="${new Date((weChatFansInstance.subscribeTime as long) * 1000)}"/></td>
            </tr>
            </tbody>
        </table>
    </div>

    <div style="width: 30%; padding-left: 10px;">
        <table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
            <tbody>
            <tr>
                <th>
                    <label><g:message code="weChatFans.unsubscribeTime.label"
                                      default="Unsubscribe Time"/></label>
                </th>
                <td>
                    <g:if test="${weChatFansInstance.unsubscribeTime}">
                        <g:formatDate format="yyyy-MM-dd hh:mm:ss"
                                      date="${weChatFansInstance.unsubscribeTime}"/>
                    </g:if>
                </td>
            </tr>
            </tbody>
        </table>
    </div>

    <div style="width: 30%; padding-left: 10px;">
        <table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
            <tbody>
            <tr>
                <th>
                    <label><g:message code="weChatFans.lastActivityTime.label"
                                      default="Last Activity Time"/></label>
                </th>
                <td>
                    <g:if test="${weChatFansInstance.lastActivityTime}">
                        <g:formatDate format="yyyy-MM-dd hh:mm:ss"
                                      date="${weChatFansInstance.lastActivityTime}"/>
                    </g:if>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
</div>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="expiresIn"><g:message code="weChatFans.expiresIn.label" default="Expires In"/></label>
        </th>
        <td><g:datePicker name="expiresIn" precision="day" value="${weChatFansInstance?.expiresIn}" default="none"
                          noSelection="['': '']"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="scope"><g:message code="weChatFans.scope.label" default="Scope"/></label>
        </th>
        <td><g:textField class="px" name="scope" value="${weChatFansInstance?.scope}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="openId"><g:message code="weChatFans.openId.label" default="Open Id"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:textField class="px" name="openId" required=""
                         value="${weChatFansInstance?.openId}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="unionId"><g:message code="weChatFans.unionId.label" default="Union Id"/></label>
        </th>
        <td><g:textField class="px" name="unionId" value="${weChatFansInstance?.unionId}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="accessToken"><g:message code="weChatFans.accessToken.label" default="Access Token"/></label>
        </th>
        <td><g:textField class="px" name="accessToken" value="${weChatFansInstance?.accessToken}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="refreshToken"><g:message code="weChatFans.refreshToken.label" default="Refresh Token"/></label>
        </th>
        <td><g:textField class="px" name="refreshToken"
                         value="${weChatFansInstance?.refreshToken}"/>
        </td>
    </tr>
    </tbody>
</table>