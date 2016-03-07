<%@ page import="net.xunzhenji.Server" %>



<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label><g:message code="server.ip.label" default="IP"/><span class="required-indicator">*</span>
            </label>
        </th>
        <td>${serverInstance?.ip}</td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label><g:message code="server.startupTime.label" default="Startup Time"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:formatDate format="yyyy-MM-dd HH:mm:ss" date="${serverInstance?.startupTime}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="refreshAccessToken"><g:message code="server.refreshAccessToken.label"
                                                       default="Refresh Access Token"/></label>
        </th>
        <td><g:checkBox name="refreshAccessToken" value="${serverInstance?.refreshAccessToken}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="refreshBatchPrice"><g:message code="server.refreshBatchPrice.label"
                                                      default="Refresh Batch Price"/></label>
        </th>
        <td><g:checkBox name="refreshBatchPrice" value="${serverInstance?.refreshBatchPrice}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="refreshJsApiTicket"><g:message code="server.refreshJsApiTicket.label"
                                                       default="Refresh Js Api Ticket"/></label>
        </th>
        <td><g:checkBox name="refreshJsApiTicket" value="${serverInstance?.refreshJsApiTicket}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="remindPayment"><g:message code="server.remindPayment.label" default="Remind Payment"/></label>
        </th>
        <td><g:checkBox name="remindPayment" value="${serverInstance?.remindPayment}"/>
        </td>
    </tr>
    </tbody>
</table>


