%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%

<%@ page import="net.xunzhenji.mall.Comment" %>



	<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
		<tbody>
		<tr>
			<th>
				<label for="comment"><g:message code="comment.comment.label" default="Comment" /><span class="required-indicator">*</span></label>
			</th>
			<td><g:textField name="comment" required="" value="${commentInstance?.comment}"/>
</td>
		</tr>
		</tbody>
	</table>

	<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
		<tbody>
		<tr>
			<th>
				<label for="userInfo"><g:message code="comment.userInfo.label" default="User Info" /><span class="required-indicator">*</span></label>
			</th>
			<td><g:select id="userInfo" name="userInfo.id" from="${net.xunzhenji.mall.UserInfo.list()}" optionKey="id" required="" value="${commentInstance?.userInfo?.id}" class="many-to-one"/>
</td>
		</tr>
		</tbody>
	</table>

