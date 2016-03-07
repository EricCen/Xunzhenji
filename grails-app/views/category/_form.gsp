<%@ page import="net.xunzhenji.mall.Category" %>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="name"><g:message code="default.name.label" default="Name"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:textField name="name" required="" class="px" value="${categoryInstance?.name}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="introduction"><g:message code="default.introduction.label" default="Introduction"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:textArea rows="4" name="introduction" required="" class="px" style="width:580px;height:auto" value="${categoryInstance?.introduction}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="fileupload-container-logo">LOGO</label>
        </th>
        <td>
            <div class="form-ele fileupload-container" id="fileupload-container-logo">
                <g:each in="${categoryInstance.logo}" var="logo">
                    <div class="uploaded-img">
                        <img style="max-width:200px;" src="${logo.thumbUrl}" data-url="${logo.deleteUrl}" id="${logo.id}">
                    </div>
                </g:each>
                <div class="fileupload-block" for="fileupload" style="display:none">
                    <p>拖拽图片放在此处上传</p>
                    <span>或者</span>
                    <span>点击此处上传</span>
                </div>
            </div>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="name"><g:message code="category.deliverDaysInWeek.label" default="发货时间"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td>
            <div>
                <% def weeks=[
                        [index: 2, name: "一"],
                        [index: 3, name: "二"],
                        [index: 4, name: "三"],
                        [index: 5, name: "四"],
                        [index: 6, name: "五"],
                        [index: 7, name: "六"],
                        [index: 1, name: "日"],
                ] %>
                <g:each in="${weeks}" var="week" >
                    <input type="checkbox" id="check_${week.index}" name="deliverDaysInWeek_${week.index}"
                        ${categoryInstance.deliverDaysInWeek?.indexOf(week.index as String) >=0 ? "checked" : ""}/>
                    <label for="check_${week.index}">周${week.name}</label>
                    <br>
                </g:each>
            </div>
        </td>
    </tr>
    </tbody>
</table>

<asset:javascript src="jquery.iframe-transport.js" />
<asset:javascript src="jquery.fileupload.js" />
<asset:javascript src="utilities.js" />
<script>
    $(document).ready(function(e) {
        initFileUpload('fileupload-container-logo', 'logo', 1);
    });
</script>