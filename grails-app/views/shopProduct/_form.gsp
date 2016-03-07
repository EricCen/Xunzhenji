<%@ page import="net.xunzhenji.shop.ShopProduct" %>



<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
	<tbody>
	<tr>
		<th>
			<label for="defaultPrice"><g:message code="shopProduct.defaultPrice.label" default="Default Price"/><span
					class="required-indicator">*</span></label>
		</th>
		<td><g:field name="defaultPrice" value="${fieldValue(bean: shopProductInstance, field: 'defaultPrice')}"
					 required=""/>
		</td>
	</tr>
	</tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
	<tbody>
	<tr>
		<th>
			<label for="name"><g:message code="shopProduct.name.label" default="Name"/><span
					class="required-indicator">*</span></label>
		</th>
		<td><g:textField class="px" name="name" required="" value="${shopProductInstance?.name}"/>
		</td>
	</tr>
	</tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
	<tbody>
	<tr>
		<th>
			<label for="procurable"><g:message code="shopProduct.procurable.label" default="Procurable"/></label>
		</th>
		<td><g:checkBox name="procurable" value="${shopProductInstance?.procurable}"/>
		</td>
	</tr>
	</tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
	<tbody>
	<tr>
		<th>
			<label for="quantityUnit"><g:message code="shopProduct.quantityUnit.label" default="Quantity Unit"/><span
					class="required-indicator">*</span></label>
		</th>
		<td><g:select name="quantityUnit" from="${net.xunzhenji.shop.ProductUnit?.values()}"
					  keys="${net.xunzhenji.shop.ProductUnit.values()*.name()}" required=""
					  value="${shopProductInstance?.quantityUnit?.name()}"/>
		</td>
	</tr>
	</tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
	<tbody>
	<tr>
		<th>
			<label for="saleable"><g:message code="shopProduct.saleable.label" default="Saleable"/></label>
		</th>
		<td><g:checkBox name="saleable" value="${shopProductInstance?.saleable}"/>
		</td>
	</tr>
	</tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
	<tbody>
	<tr>
		<th>
			<label for="weightUnit"><g:message code="shopProduct.weightUnit.label" default="Weight Unit"/><span
					class="required-indicator">*</span></label>
		</th>
		<td><g:select name="weightUnit" from="${net.xunzhenji.shop.ProductUnit?.values()}"
					  keys="${net.xunzhenji.shop.ProductUnit.values()*.name()}" required=""
					  value="${shopProductInstance?.weightUnit?.name()}"/>
		</td>
	</tr>
	</tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
	<tbody>
	<tr>
		<th>
			<label for="defaultWareHouse"><g:message code="shopProduct.defaultWareHouse.label"
													 default="Default WareHouse"/><span
					class="required-indicator">*</span></label>
		</th>
		<td><g:select name="defaultWareHouse" from="${net.xunzhenji.shop.Warehouse.list()}" optionKey="id" required=""
					  optionValue="name"/>
		</td>
	</tr>
	</tbody>
</table>
