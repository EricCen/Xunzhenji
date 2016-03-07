%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%

<%@ page import="net.xunzhenji.mall.Suggestion" %>



	<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
		<tbody>
		<tr>
			<th>
				<label for="userInfo"><g:message code="userInfo.label" default="User Info" /></label>
			</th>
			%{--<td><g:select id="userInfo" name="userInfo.id" from="${net.xunzhenji.mall.UserInfo.list()}" optionKey="id" value="${suggestionInstance?.userInfo?.id}" class="many-to-one" noSelection="['null': '']"/>--}%
</td>
		</tr>
		</tbody>
	</table>

	<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
		<tbody>
		<tr>
			<th>
				<label for="content"><g:message code="default.content.label" default="Content" /><span class="required-indicator">*</span></label>
			</th>
			<td><g:textField name="content" required="" value="${suggestionInstance?.content}"/>
</td>
		</tr>
		</tbody>
	</table>

	<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
		<tbody>
		<tr>
			<th>
				<label for="summary"><g:message code="suggestion.summary.label" default="dateCreated" /><span class="required-indicator">*</span></label>
			</th>
			<td><g:textField name="summary" required="" value="${suggestionInstance?.dateCreated}"/>
</td>
		</tr>
		</tbody>
	</table>

	<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
		<tbody>
		<tr>
			<th>
				<label for="reply"><g:message code="suggestion.summary.reply" default="回复" /></label>
			</th>
			<td><g:textField name="reply" required="" value="${suggestionInstance?.reply}"/>
			</td>
		</tr>
		</tbody>
	</table>


