<%@ page import="net.xunzhenji.mall.PromotionCode" %>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
	<tbody>
	<tr>
		<th>
			<label for="title"><g:message code="default.title.label" default="Title" /><span class="required-indicator">*</span></label>
		</th>
		<td><g:textField class="px" name="title" required="" value="${promotionCodeInstance?.title}"/>
		</td>
	</tr>
	</tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
	<tbody>
	<tr>
		<th>
			<label for="description"><g:message code="default.description.label" default="Description" /><span class="required-indicator">*</span></label>
		</th>
		<td><g:textField class="px" name="description" required="" value="${promotionCodeInstance?.description}"/>
		</td>
	</tr>
	</tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
	<tbody>
	<tr>
		<th>
			<label for="code"><g:message code="promotionCode.code.label" default="Code"/><span
					class="required-indicator">*</span></label>
		</th>
		<td><g:textField class="px" name="code" required=""
						 value="${promotionCodeInstance?.code}"/></td>
	</tr>
	</tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
	<tbody>
	<tr>
		<th>
			<label for="discount"><g:message code="promotionCode.discount.label" default="Discount"/></label>
		</th>
		<td><g:textField name="discount" class="px"
						 value="${fieldValue(bean: promotionCodeInstance, field: 'discount')}"/></td>
	</tr>
	</tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
	<tbody>
	<tr>
		<th>
			<label for="price"><g:message code="promotionCode.price.label" default="Price"/></label>
		</th>
		<td><g:textField name="price" class="px"
						 value="${fieldValue(bean: promotionCodeInstance, field: 'price')}"/>
		</td>
	</tr>
	</tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
	<tbody>
	<tr>
		<th>
			<label for="minimumOrder"><g:message code="promotionCode.minimumOrder.label"
												 default="Minimum Order"/></label>
		</th>
		<td><g:textField name="minimumOrder" class="px"
						 value="${fieldValue(bean: promotionCodeInstance, field: 'minimumOrder')}"/>
		</td>
	</tr>
	</tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
	<tbody>
	<tr>
		<th>
			<label for="maximumUsed"><g:message code="promotionCode.maximumUsed.label" default="Maximum Used"/></label>
		</th>
		<td><g:textField name="maximumUsed" class="px"
						 value="${fieldValue(bean: promotionCodeInstance, field: 'maximumUsed')}"/>
		</td>
	</tr>
	</tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
	<tbody>
	<tr>
		<th>
			<label for="usedCount"><g:message code="promotionCode.usedCount.label" default="Used Count"/></label>
		</th>
		<td><g:textField name="usedCount" class="px"
						 value="${fieldValue(bean: promotionCodeInstance, field: 'usedCount')}"/>
		</td>
	</tr>
	</tbody>
</table>


	<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
		<tbody>
		<tr>
			<th>
				<label for="expiredDate"><g:message code="promotionCode.expiredDate.label" default="Expired Date" /><span class="required-indicator">*</span></label>
			</th>
			<td><g:datePicker name="expiredDate" precision="day"  value="${promotionCodeInstance?.expiredDate}"  />
</td>
		</tr>
		</tbody>
	</table>

	<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
		<tbody>
		<tr>
			<th>
				<label for="includeExpress"><g:message code="promotionCode.includeExpress.label" default="Include Express" /></label>
			</th>
			<td><g:checkBox name="includeExpress" value="${promotionCodeInstance?.includeExpress}" />
</td>
		</tr>
		</tbody>
	</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
	<tbody>
	<tr>
		<th>
			<label for="includeExpress"><g:message code="default.address.label" default="Address"/></label>
		</th>
		<td><g:select from="${net.xunzhenji.mall.Address.list()}" name="address"
					  optionKey="id" optionValue="${{ it.name + " " + it.address }}"
					  value="${promotionCodeInstance?.address?.id}" noSelection="['': '无限定地址']"/>
		</td>
	</tr>
	</tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
	<tbody>
	<tr>
		<th>
			<label for="products"><g:message code="product.label" default="Product"/>（按Ctrl多选或取消)</label>
		</th>
		<td>
			<g:select name="products" from="${net.xunzhenji.mall.Product.list()}"
					  multiple="true" optionKey="id" size="5" value="${promotionCodeInstance?.products*.id}"
					  class="many-to-many"/>
		</td>
	</tr>
	</tbody>
</table>

