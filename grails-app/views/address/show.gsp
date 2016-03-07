%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%


<%@ page import="net.xunzhenji.mall.Address" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="admin">
    <g:set var="entityName" value="${message(code: 'address.label', default: 'Address')}"/>
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

<div id="show-address" class="content scaffold-show" role="main">
    <h1><g:message code="default.show.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <ol class="property-list address">
        <table class="userinfoArea address" border="0" cellspacing="0" cellpadding="0" width="100%">
            <tbody>

            <g:if test="${addressInstance?.name}">
                <tr>
                    <th><span id="name-label" class="property-label"><g:message code="address.name.label"
                                                                                default="Name"/></span></th>

                    <td><span class="property-value" aria-labelledby="name-label"><g:fieldValue
                            bean="${addressInstance}" field="name"/></span></td>

                </tr>
            </g:if>

            <g:if test="${addressInstance?.phone}">
                <tr>
                    <th><span id="phone-label" class="property-label"><g:message code="address.phone.label"
                                                                                 default="Phone"/></span></th>

                    <td><span class="property-value" aria-labelledby="phone-label"><g:fieldValue
                            bean="${addressInstance}" field="phone"/></span></td>

                </tr>
            </g:if>

            <g:if test="${addressInstance?.city}">
                <tr>
                    <th><span id="city-label" class="property-label"><g:message code="address.city.label"
                                                                                default="City"/></span></th>

                    <td><span class="property-value" aria-labelledby="city-label"><g:link controller="city"
                                                                                          action="show"
                                                                                          id="${addressInstance?.city?.id}">${addressInstance?.city?.encodeAsHTML()}</g:link></span>
                    </td>

                </tr>
            </g:if>

            <g:if test="${addressInstance?.district}">
                <tr>
                    <th><span id="district-label" class="property-label"><g:message code="address.district.label"
                                                                                    default="District"/></span></th>

                    <td><span class="property-value" aria-labelledby="district-label"><g:link controller="district"
                                                                                              action="show"
                                                                                              id="${addressInstance?.district?.id}">${addressInstance?.district?.encodeAsHTML()}</g:link></span>
                    </td>

                </tr>
            </g:if>

            <g:if test="${addressInstance?.street}">
                <tr>
                    <th><span id="street-label" class="property-label"><g:message code="address.street.label"
                                                                                  default="Street"/></span></th>

                    <td><span class="property-value" aria-labelledby="street-label"><g:fieldValue
                            bean="${addressInstance}" field="street"/></span></td>

                </tr>
            </g:if>

            <g:if test="${addressInstance?.address}">
                <tr>
                    <th><span id="address-label" class="property-label"><g:message code="address.address.label"
                                                                                   default="Address"/></span></th>

                    <td><span class="property-value" aria-labelledby="address-label"><g:fieldValue
                            bean="${addressInstance}" field="address"/></span></td>

                </tr>
            </g:if>



            <g:if test="${addressInstance?.disable}">
                <tr>
                    <th><span id="disable-label" class="property-label"><g:message code="address.disable.label"
                                                                                   default="Disable"/></span></th>

                    <td><span class="property-value" aria-labelledby="disable-label"><g:formatBoolean
                            boolean="${addressInstance?.disable}"/></span></td>

                </tr>
            </g:if>



            <g:if test="${addressInstance?.isDefault}">
                <tr>
                    <th><span id="isDefault-label" class="property-label"><g:message code="address.isDefault.label"
                                                                                     default="Is Default"/></span></th>

                    <td><span class="property-value" aria-labelledby="isDefault-label"><g:formatBoolean
                            boolean="${addressInstance?.isDefault}"/></span></td>

                </tr>
            </g:if>

            <g:if test="${addressInstance?.latitude}">
                <tr>
                    <th><span id="latitude-label" class="property-label"><g:message code="address.latitude.label"
                                                                                    default="Latitude"/></span></th>

                    <td><span class="property-value" aria-labelledby="latitude-label"><g:fieldValue
                            bean="${addressInstance}" field="latitude"/></span></td>

                </tr>
            </g:if>

            <g:if test="${addressInstance?.longitude}">
                <tr>
                    <th><span id="longitude-label" class="property-label"><g:message code="address.longitude.label"
                                                                                     default="Longitude"/></span></th>

                    <td><span class="property-value" aria-labelledby="longitude-label"><g:fieldValue
                            bean="${addressInstance}" field="longitude"/></span></td>

                </tr>
            </g:if>

            <g:if test="${addressInstance?.userInfo}">
                <tr>
                    <th><span id="userInfo-label" class="property-label"><g:message code="userInfo.label"
                                                                                    default="User Info"/></span></th>

                    <td><span class="property-value" aria-labelledby="userInfo-label"><g:link controller="userInfo"
                                                                                              action="show"
                                                                                              id="${addressInstance?.userInfo?.id}">${addressInstance?.userInfo?.encodeAsHTML()}</g:link></span>
                    </td>

                </tr>
            </g:if>

    </ol>
    <g:form url="[resource: addressInstance, action: 'delete']" method="DELETE">
        <fieldset class="buttons">
            <g:link class="btnGreen left" action="edit" resource="${addressInstance}"><g:message
                    code="default.button.edit.label" default="Edit"/></g:link>
            <g:actionSubmit class="btnGreen left" action="delete"
                            value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                            onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
        </fieldset>
    </g:form>
</div>
</body>
</html>
