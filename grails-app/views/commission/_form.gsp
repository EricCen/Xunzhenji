<%@ page import="net.xunzhenji.mall.Commission" %>



	<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
		<tbody>
		<tr>
			<th>
				<label for="amount"><g:message code="default.amount.label" default="金额" /><span class="required-indicator">*</span></label>
			</th>
			<td><g:field name="amount" value="${fieldValue(bean: commissionInstance, field: 'amount')}" required=""/>
</td>
		</tr>
		</tbody>
	</table>

	<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
		<tbody>
		<tr>
			<th>
				<label for="organizer"><g:message code="commission.organizer.label" default="领鲜群主" /><span class="required-indicator">*</span></label>
			</th>
			<td><g:select id="organizer" name="organizer.id" from="${net.xunzhenji.mall.UserInfo.list()}" optionKey="id" required="" value="${commissionInstance?.organizer?.id}" class="many-to-one"/>
</td>
		</tr>
		</tbody>
	</table>

	<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
		<tbody>
		<tr>
			<th>
				<label for="productOrder"><g:message code="productOrder.label" default="订单" /><span class="required-indicator">*</span></label>
			</th>
			<td><g:select id="productOrder" name="productOrder.id" from="${net.xunzhenji.mall.ProductOrder.list()}" optionKey="id" required="" value="${commissionInstance?.productOrder?.id}" class="many-to-one"/>
</td>
		</tr>
		</tbody>
	</table>

	<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
		<tbody>
		<tr>
			<th>
				<label for="state"><g:message code="default.state.label" default="状态" /><span class="required-indicator">*</span></label>
			</th>
			<td><g:field name="state" type="number" value="${commissionInstance.state}" required=""/>
</td>
		</tr>
		</tbody>
	</table>

