<%@ page import="net.xunzhenji.promotion.Link" %>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
	<tbody>
	<tr>
		<th>
			<label for="title"><g:message code="default.title.label" default="Tiny Code" /></label>
		</th>
		<td><g:textField class="px" name="title" value="${linkInstance?.title}"/>
		</td>
	</tr>
	</tbody>
</table>

	<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
		<tbody>
		<tr>
			<th>
				<label for="tinyCode"><g:message code="link.tinyCode.label" default="Tiny Code" /><span class="required-indicator">*</span></label>
			</th>
			<td><g:textField class="px" name="tinyCode" required="" value="${linkInstance?.tinyCode}"/>
</td>
		</tr>
		</tbody>
	</table>

	<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
		<tbody>
		<tr>
			<th>
				<label for="url"><g:message code="link.url.label" default="Url" /><span class="required-indicator">*</span></label>
			</th>
			<td><g:textField class="px" name="url" required="" value="${linkInstance?.url}"/>
</td>
		</tr>
		</tbody>
	</table>

