%{--
  - Copyright (c) 2016 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%

<%--
  Created by IntelliJ IDEA.
  User: Irene
  Date: 2016-02-12
  Time: 18:59
--%>

<script type="text/html" id="tpl_manufacture">
<div class="page">
    <div class="hd">
        <h1 class="page_title"><strong><span id="add_procurement_date"></span>屠宰</strong></h1>
    </div>

    <form id="new_manufacture_form">
        <div class="weui_cells weui_cells_form">
            <div class="weui_cell">
                <div class="weui_cell_hd"><label class="weui_label">日期</label></div>

                <div class="weui_cell_bd weui_cell_primary">
                    <input class="weui_input" type="date" name="date"
                           value="${new Date().clearTime().format("yyyy-MM-dd")}">
                </div>
            </div>

            <div class="weui_cell">
                <div class="weui_cell_hd"><label class="weui_label">新增存栏</label></div>

                <div class="weui_cell_bd weui_cell_primary">
                    <input class="weui_input" type="number" name="stock_quantity" pattern="[0-9]*"
                           placeholder="(必填)屠宰后剩余的存栏数目?">
                </div>
            </div>

            <div class="weui_cell">
                <div class="weui_cell_hd"><label class="weui_label">屠宰数量</label></div>

                <div class="weui_cell_bd weui_cell_primary">
                    <input class="weui_input" type="number" name="outputQuantity" pattern="[0-9]*"
                           placeholder="(必填)屠宰了多少只?">
                </div>
            </div>

            <div class="weui_cell">
                <div class="weui_cell_hd"><label class="weui_label">宰后净重</label></div>

                <div class="weui_cell_bd weui_cell_primary">
                    <input class="weui_input" type="number" name="outputWeight" pattern="[0-9]*"
                           placeholder="(必填)屠宰后一批发货的总净重?">
                </div>
            </div>

            <input type="hidden" name="processId" id="manufacture-process-id">
        </div>

        <div class="hd spacing">
            <a class="weui_btn weui_btn_primary" href="javascript:;" onclick="addManufacture()">确定</a>
            <a class='weui_btn weui_btn_default' href='javascript:;' onclick="resetAddProcurement();">重置</a>
        </div>
    </form>
</div>
</script>