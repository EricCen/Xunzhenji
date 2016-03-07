%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%


<%@ page import="net.xunzhenji.wechat.Media" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="admin">
    <g:set var="entityName" value="${message(code: 'media.label', default: 'Media')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>
<div class="nav" role="navigation">
    <ul>
        <li><g:link class='btnGrayS vm bigbtn' action="index"><asset:image src="text.png" class="vm"/><g:message
                code="default.list.label" args="[entityName]"/></g:link></li>
        <li><g:link class='btnGrayS vm bigbtn' action="create"><asset:image src="text.png" class="vm"/><g:message
                code="default.new.label" args="[entityName]"/></g:link></li>
        <li><g:link class='btnGrayS vm bigbtn' action="syncSingleMedia" id="${mediaInstance.mediaId}">
            <asset:image src="text.png" class="vm"/>同步素材</g:link></li>
        <li><g:link class='btnGrayS vm bigbtn' action="sendToAllActiveUser" id="${mediaInstance.mediaId}">
            <asset:image src="text.png" class="vm"/>发送给所有互动粉丝</g:link></li>
    </ul>
</div>

<div id="show-media" class="content scaffold-show" role="main">
    <h1><g:message code="default.show.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <ol class="property-list media">
        <table class="userinfoArea media" border="0" cellspacing="0" cellpadding="0" width="100%">
            <tbody>

            <g:if test="${mediaInstance?.type}">
                <tr>
                    <th><span id="type-label" class="property-label"><g:message code="media.type.label"
                                                                                default="Type"/></span></th>

                    <td><span class="property-value" aria-labelledby="type-label"><g:fieldValue bean="${mediaInstance}"
                                                                                                field="type"/></span>
                    </td>

                </tr>
            </g:if>

            <g:if test="${mediaInstance?.title}">
                <tr>
                    <th><span id="title-label" class="property-label"><g:message code="media.title.label"
                                                                                 default="Title"/></span></th>

                    <td><span class="property-value" aria-labelledby="title-label"><g:fieldValue bean="${mediaInstance}"
                                                                                                 field="title"/></span>
                    </td>

                </tr>
            </g:if>

            <g:if test="${mediaInstance?.introduction}">
                <tr>
                    <th><span id="introduction-label" class="property-label"><g:message code="media.introduction.label"
                                                                                        default="Introduction"/></span>
                    </th>

                    <td><span class="property-value" aria-labelledby="introduction-label"><g:fieldValue
                            bean="${mediaInstance}" field="introduction"/></span></td>

                </tr>
            </g:if>

            <g:if test="${mediaInstance?.mediaId}">
                <tr>
                    <th><span id="mediaId-label" class="property-label"><g:message code="media.mediaId.label"
                                                                                   default="Media Id"/></span></th>

                    <td><span class="property-value" aria-labelledby="mediaId-label"><g:fieldValue
                            bean="${mediaInstance}" field="mediaId"/></span></td>

                </tr>
            </g:if>

            <g:if test="${mediaInstance?.weChatCreatedAt}">
                <tr>
                    <th><span id="weChatCreatedAt-label" class="property-label"><g:message
                            code="media.weChatCreatedAt.label" default="We Chat Created At"/></span></th>

                    <td><span class="property-value" aria-labelledby="weChatCreatedAt-label"><g:formatDate
                            format="yyyy-MM-dd HH:mm:ss" date="${mediaInstance?.weChatCreatedAt}"/></span></td>

                </tr>
            </g:if>

            <g:if test="${mediaInstance?.host}">
                <tr>
                    <th><span id="host-label" class="property-label"><g:message code="media.host.label"
                                                                                default="Host"/></span></th>

                    <td><span class="property-value" aria-labelledby="host-label"><g:fieldValue bean="${mediaInstance}"
                                                                                                field="host"/></span>
                    </td>

                </tr>
            </g:if>

            <g:if test="${mediaInstance?.path}">
                <tr>
                    <th><span id="path-label" class="property-label"><g:message code="media.path.label"
                                                                                default="Path"/></span></th>

                    <td><span class="property-value" aria-labelledby="path-label"><g:fieldValue bean="${mediaInstance}"
                                                                                                field="path"/></span>
                    </td>

                </tr>
            </g:if>

            <g:if test="${mediaInstance?.thumbUrl}">
                <tr>
                    <th><span id="thumbUrl-label" class="property-label"><g:message code="media.thumbUrl.label"
                                                                                    default="Thumb Url"/></span></th>

                    <td><span class="property-value" aria-labelledby="thumbUrl-label"><g:fieldValue
                            bean="${mediaInstance}" field="thumbUrl"/></span></td>

                </tr>
            </g:if>

            <g:if test="${mediaInstance?.url}">
                <tr>
                    <th><span id="url-label" class="property-label"><g:message code="media.url.label"
                                                                               default="Url"/></span></th>

                    <td><span class="property-value" aria-labelledby="url-label"><g:fieldValue bean="${mediaInstance}"
                                                                                               field="url"/></span></td>

                </tr>
            </g:if>

            <g:if test="${mediaInstance?.fileName}">
                <tr>
                    <th><span id="fileName-label" class="property-label"><g:message code="media.fileName.label"
                                                                                    default="File Name"/></span></th>

                    <td><span class="property-value" aria-labelledby="fileName-label"><g:fieldValue
                            bean="${mediaInstance}" field="fileName"/></span></td>

                </tr>
            </g:if>

            <g:if test="${mediaInstance?.uploadName}">
                <tr>
                    <th><span id="uploadName-label" class="property-label"><g:message code="media.uploadName.label"
                                                                                      default="Upload Name"/></span>
                    </th>

                    <td><span class="property-value" aria-labelledby="uploadName-label"><g:fieldValue
                            bean="${mediaInstance}" field="uploadName"/></span></td>

                </tr>
            </g:if>

            <g:if test="${mediaInstance?.size}">
                <tr>
                    <th><span id="size-label" class="property-label"><g:message code="media.size.label"
                                                                                default="Size"/></span></th>

                    <td><span class="property-value" aria-labelledby="size-label"><g:fieldValue bean="${mediaInstance}"
                                                                                                field="size"/></span>
                    </td>

                </tr>
            </g:if>

            <g:if test="${mediaInstance?.status}">
                <tr>
                    <th><span id="status-label" class="property-label"><g:message code="media.status.label"
                                                                                  default="Status"/></span></th>

                    <td><span class="property-value" aria-labelledby="status-label"><g:fieldValue
                            bean="${mediaInstance}" field="status"/></span></td>

                </tr>
            </g:if>

            <g:if test="${mediaInstance?.weChatContext}">
                <tr>
                    <th><span id="weChatContext-label" class="property-label"><g:message
                            code="media.weChatContext.label" default="We Chat Context"/></span></th>

                    <td><span class="property-value" aria-labelledby="weChatContext-label"><g:link
                            controller="weChatContext" action="show"
                            id="${mediaInstance?.weChatContext?.id}">${mediaInstance?.weChatContext?.encodeAsHTML()}</g:link></span>
                    </td>

                </tr>
            </g:if>

    </ol>
    <g:form url="[resource: mediaInstance, action: 'delete']" method="DELETE">
        <fieldset class="buttons">
            <g:link class="btnGreen left" action="edit" resource="${mediaInstance}"><g:message
                    code="default.button.edit.label" default="Edit"/></g:link>
            <g:actionSubmit class="btnGreen left" action="delete"
                            value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                            onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
        </fieldset>
    </g:form>
</div>
</body>
</html>
