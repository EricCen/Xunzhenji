<%@ page import="net.xunzhenji.wechat.Template" %>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
<tbody>
<tr>
    <th>
        <label for="name"><g:message code="default.name.label"
                                                default="名称"/><span
                class="required-indicator">*</span></label>
    </th>
    <td><g:textField class="px" name="name" required=""
                     value="${templateInstance?.name}"/>
    </td>
</tr>
</tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="templateIdShort"><g:message code="template.templateIdShort.label"
                                                    default="编号"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:textField class="px" name="templateIdShort" required=""
                         value="${templateInstance?.templateIdShort}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="topColor">顶部颜色</label>
        </th>
        <td><g:textField class="px" name="topColor" value="${templateInstance?.topColor}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="textColor">文字颜色</label>
        </th>
        <td><g:textField class="px" name="textColor" value="${templateInstance?.textColor}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label><g:message code="template.templateId.label" default="模板"/></label>
        </th>
        <td>${templateInstance?.templateId}</td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="templateContent"><g:message code="template.templateContent.label" default="模板内容(从微信MP平台copy过来)"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:textArea rows="5" style="width:580px;border: ridge;" name="templateContent" required=""
                        value="${templateInstance?.templateContent}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="templateJson"><g:message code="template.templateJson.label" default="模板对象"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:textArea rows="5" style="width:580px;border: ridge;" name="templateJson" required=""
                        value="${templateInstance?.templateJson}"/>
        </td>
    </tr>
    </tbody>
</table>





