<%@ page import="net.xunzhenji.promotion.RandomLink" %>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
	<tbody>
	<tr>
		<th>
			<label for="linkCode"><g:message code="randomLink.linkCode.label" default="Link Code"/><span
					class="required-indicator">*</span></label>
		</th>
		<td><g:textField class="px" name="linkCode" required="" value="${randomLinkInstance?.linkCode}"/>
		</td>
	</tr>
	</tbody>
</table>


	<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
		<tbody>
		<tr>
			<th>
				<label for="links"><g:message code="randomLink.links.label" default="Links" /></label>
			</th>
			<td><g:select name="links" from="${net.xunzhenji.promotion.Link.list()}" multiple="multiple" optionKey="id" size="5" value="${randomLinkInstance?.links*.id}" class="many-to-many"/>
</td>
		</tr>
		</tbody>
	</table>


