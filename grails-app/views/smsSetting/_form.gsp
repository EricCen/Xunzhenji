<%@ page import="net.xunzhenji.SmsSetting" %>



	<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
		<tbody>
		<tr>
			<th>
				<label for="alarmBalance"><g:message code="smsSetting.alarmBalance.label" default="Alarm Balance" /><span class="required-indicator">*</span></label>
			</th>
			<td><g:field name="alarmBalance" type="number" value="${smsSettingInstance.alarmBalance}" required=""/>
</td>
		</tr>
		</tbody>
	</table>

	<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
		<tbody>
		<tr>
			<th>
				<label for="balance"><g:message code="smsSetting.balance.label" default="Balance" /><span class="required-indicator">*</span></label>
			</th>
			<td><g:field name="balance" type="number" value="${smsSettingInstance.balance}" required=""/>
</td>
		</tr>
		</tbody>
	</table>

	<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
		<tbody>
		<tr>
			<th>
				<label for="ipWhiteList"><g:message code="smsSetting.ipWhiteList.label" default="Ip White List" /><span class="required-indicator">*</span></label>
			</th>
			<td><g:textField class="px" name="ipWhiteList" required="" value="${smsSettingInstance?.ipWhiteList}"/>
</td>
		</tr>
		</tbody>
	</table>

	<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
		<tbody>
		<tr>
			<th>
				<label for="apiKey"><g:message code="smsSetting.key.label" default="Key"/><span
						class="required-indicator">*</span></label>
			</th>
			<td><g:textField class="px" name="apiKey" required=""
							 value="${smsSettingInstance?.apiKey}"/>
</td>
		</tr>
		</tbody>
	</table>

