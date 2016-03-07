%{--
  - Copyright (c) 2016 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%

<%--
  Created by IntelliJ IDEA.
  User: Irene
  Date: 2016-02-12
  Time: 20:43
--%>

<script type="text/html" id="tpl_delivery">
<div class="page">
    <div class="hd">
        <h1 class="page_title"><strong><span id="add_delivery_date"></span>配送记录</strong></h1>
    </div>

    <form id="new_delivery_form">
        <g:each in="${shops}" var="shop">
            <div class="weui_cell">
                <div class="weui_cell_hd"><label class="weui_label">${shop?.name}</label></div>

                <div class="weui_cell_bd weui_cell_primary">
                    <input class="weui_input" type="number" name="shopWeight_${shop.id}" pattern="[0-9]*"
                           placeholder="(必填)签单时的重量">
                </div>
            </div>
        </g:each>

        <div class="weui_cells weui_cells_form">

            <div class="weui_cell">
                <div class="weui_cell_hd"><label class="weui_label">送后库存</label></div>

                <div class="weui_cell_bd weui_cell_primary">
                    <input class="weui_input" type="number" name="stockWeight" pattern="[0-9]*"
                           placeholder="(必填)送货后的库存重量，不含鸡胗">
                </div>
            </div>
            <input type="hidden" name="processId" id="delivery-process-id">
        </div>

        <div class="hd spacing">
            <a href="javascript:;" class="weui_btn weui_btn_primary" onclick="addShopDelivery()">确定</a>
            <a class='weui_btn weui_btn_default' href='javascript:;' onclick="resetAddShopDelivery();">重置</a>
        </div>
    </form>
</div>

</script>