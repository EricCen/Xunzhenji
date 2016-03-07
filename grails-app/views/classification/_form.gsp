<%@ page import="net.xunzhenji.Classification" %>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
<tbody>
<tr>
	<th>
		<label for="name">
			<g:message code="default.name.label" default="Name" />
			<span class="required-indicator">*</span>
		</label>
	</th>
	<td><g:textField class="px" name="name" required="" value="${classificationInstance?.name}" style="width:580px;"/></td>
</tr>
<tr>
	<th>
		<label for="introduction">
			<g:message code="default.introduction.label" default="Introduction" />
		</label>
	</th>
	<td><g:textArea class="px" name="introduction" value="${classificationInstance?.introduction}" style="width:580px;height:100px"/></td>
</tr>
</tbody>
</table>