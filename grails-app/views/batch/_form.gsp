<%@ page import="net.xunzhenji.mall.Batch" %>
<asset:stylesheet href="upload.css"/>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="product"><g:message code="product.label" default="Product"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:select id="product" name="product.id" from="${net.xunzhenji.mall.Product.list()}" optionKey="id"
                      required="" optionValue="title" value="${batchInstance?.product?.id}" class="many-to-one"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="title"><g:message code="default.title.label" default="Title"/>(不能带空格、"+"、"%40")</label>
        </th>
        <td><g:textField name="title" class="px" value="${batchInstance?.title}"/></td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="productionDate"><g:message code="batch.productionDate.label" default="上市时间"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:datePicker name="productionDate" precision="day" value="${batchInstance?.productionDate}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="paymentDate"><g:message code="batch.paymentDate.label" default="支付时间"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:datePicker name="paymentDate" precision="day" value="${batchInstance?.paymentDate}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="birthday"><g:message code="batch.birthday.label" default="出生时间"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:datePicker name="birthday" precision="day" value="${batchInstance?.birthday}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="soldDeadline"><g:message code="batch.soldDeadline.label" default="截至销售时间"/></label>
        </th>
        <td><g:datePicker name="soldDeadline" precision="day" value="${batchInstance?.soldDeadline}"/>
        </td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="price"><g:message code="batch.price.label" default="价格"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:textField name="price" class="px" value="${batchInstance?.price}"/></td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="discount"><g:message code="batch.discount.label" default="折扣"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:textField name="discount" class="px"
                         value="${batchInstance?.discount ? batchInstance?.discount * 100 : 0}"/>%</td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="calcDiscount"><g:message code="batch.calcDiscount.label" default="计算折扣"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:checkBox name="calcDiscount" value="${batchInstance?.calcDiscount? true : false}"/></td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="batchState"><g:message code="batch.batchState.label" default="批次状态"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:select id="batchState" name="batchState" from="${net.xunzhenji.mall.Batch.BatchState.values()}" optionKey="state"
                      required="" optionValue="description" value="${batchInstance?.batchState}"/></td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="cost"><g:message code="batch.cost.label" default="成本"/><span class="required-indicator">*</span>
            </label>
        </th>
        <td><g:textField name="cost" class="px"
                         value="${fieldValue(bean: batchInstance, field: 'cost')}" required=""/>元</td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="unitAllowance"><g:message code="batch.unitAllowance.label" default="补贴"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:textField name="unitAllowance" class="px"
                         value="${fieldValue(bean: batchInstance, field: 'unitAllowance')}" required=""/>元</td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="quantityInStore"><g:message code="batch.quantityInStore.label" default="库存"/><span
                    class="required-indicator">*</span></label>
        </th>
        <td><g:textField name="quantityInStore" class="px"
                         value="${fieldValue(bean: batchInstance, field: 'quantityInStore')}" required=""/></td>
    </tr>
    </tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
    <tr>
        <th>
            <label for="display"><g:message code="batch.display.label" default="显示批次"/>
                <span class="required-indicator">*</span></label>
        </th>
        <td><g:checkBox name="display" value="${batchInstance?.display? true : false}"/></td>
    </tr>
    </tbody>
</table>