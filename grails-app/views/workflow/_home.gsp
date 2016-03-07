%{--
  - Copyright (c) 2016 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%

<%--
  Created by IntelliJ IDEA.
  User: Irene
  Date: 2016-02-12
  Time: 20:39
--%>

<script type="text/html" id="tpl_home">

<div class="page">
    <div class="hd">
        <h1 class="page_title">猪肚鸡工作记录</h1>
    </div>

    <div id="main_table"></div>

    <div id="tpl_main_table" style="display: none">
        <div class="hd">
            <div class="boxer" style="width: 100%;">
                <div class="box-row">
                    <div class="box table_header">
                        <a href="javascript:;" class="btn weui_btn weui_btn_mini weui_btn_default btn_procurement_list"
                           data-id="plist"><strong>采购</strong></a>
                    </div>

                    <div class="box table_header">
                        <a href="javascript:;" class="btn weui_btn weui_btn_mini weui_btn_default btn_manufacture_list"
                           data-id="mlist"><strong>屠宰</strong></a>
                    </div>

                    <div class="box table_header">
                        <a href="javascript:;" class="btn weui_btn weui_btn_mini weui_btn_default btn_delivery_list"
                           data-id="dlist"><strong>配送</strong></a>
                    </div>
                </div>

                {{#data}}
                <div class="box-row">
                    <div class="box bottom_dashed"><!-- 采购 -->
                    {{#procurementTime}}
                        <div class="date">{{procurementTime}}</div>
                        {{/procurementTime}}
                        {{^procurementTime}}
                        {{#date}}
                        <div class="date">{{date}}</div>
                        {{/date}}
                        {{^date}}
                        <div class="date">{{today}}</div>
                        {{/date}}
                        {{/procurementTime}}
                        <div class="procurement_{{id}}"></div>
                        {{#procurements}}
                        <div>{{manufactoryProductName}}{{quantity}}{{manufactoryProductQuantityUnit}},{{weight}}{{manufactoryProductWeightUnit}}</div>
                        {{/procurements}}
                    </div>

                    <div class="box bottom_dashed"><!-- 屠宰 -->
                    {{#manufactureTime}}
                        <div class="date">{{manufactureTime}}</div>
                        {{/manufactureTime}}
                        {{^manufactureTime}}
                        <div class="date">{{today}}</div>
                        {{/manufactureTime}}
                        <div class="manufacture_{{id}}">
                            {{#manufactureTime}}
                            {{#manufacture}}
                            <div>{{deliveryProductName}}{{quantity}}{{manufactoryProductQuantityUnit}},{{outputWeight}}{{manufactoryProductWeightUnit}}</div>
                            {{/manufacture}}
                            {{/manufactureTime}}
                        </div>
                    </div>

                    <div class="box bottom_dashed"><!-- 配送 -->
                    {{#deliveryTime}}
                        <div class="date">{{deliveryTime}}</div>
                        {{/deliveryTime}}
                        {{^deliveryTime}}
                        <div class="date">{{today}}</div>
                        {{/deliveryTime}}
                        <div class="delivery_{{id}}">
                            {{#deliveryTime}}
                            {{#delivery}}
                            <div>{{deliveryProductName}}{{totalWeight}}{{deliveryProductWeightUnit}}</div>
                            {{/delivery}}
                            {{/deliveryTime}}
                        </div>
                    </div>
                </div>

                <div class="box-row">
                    <div class="box top_bottom_transparent">
                        {{#initialManufactureQuantity}}
                        <div>购前存栏{{initialManufactureQuantity}}{{manufactoryProductQuantityUnit}}</div>
                        {{/initialManufactureQuantity}}
                        {{^initialManufactureQuantity}}
                        {{#currentStock}}
                        <div>购前存栏{{manufactureStockQuantity}}{{manufactoryProductQuantityUnit}}</div>
                        {{/currentStock}}
                        {{/initialManufactureQuantity}}
                        {{#procurementTime}}
                        <div>购后存栏{{procuredQuantity}}{{manufactoryProductQuantityUnit}}</div>

                        <div>总毛重:{{manufactureStockWeight}}{{manufactoryProductWeightUnit}}</div>
                        {{/procurementTime}}
                    </div>

                    <div class="box top_bottom_transparent">
                        {{#manufactureTime}}
                        {{#manufacture}}
                        <div>宰后存栏{{manufactureQuantity}}{{manufactoryProductQuantityUnit}}</div>

                        <div>宰前毛重{{inputWeight}}{{manufactoryProductWeightUnit}}</div>

                        <div>出肉率:{{productionRate}}%</div>
                        {{/manufacture}}
                        {{/manufactureTime}}
                    </div>

                    <div class="box top_bottom_transparent">
                        {{#initialDeliveryWeight}}
                        <div>送前库存:{{initialDeliveryWeight}}{{deliveryProductWeightUnit}}</div>
                        {{/initialDeliveryWeight}}
                        {{^initialDeliveryWeight}}
                        {{#currentStock}}
                        <div>送前库存:{{deliveryStockWeight}}{{deliveryProductWeightUnit}}</div>
                        {{/currentStock}}
                        {{/initialDeliveryWeight}}
                        {{#deliveryTime}}
                        {{#delivery}}
                        <div>送后库存:{{stockWeight}}{{deliveryProductWeightUnit}}</div>
                        <div>库存偏差:{{stockMoveWeight}}{{deliveryProductWeightUnit}}</div>
                        <div>出肉率:{{productionRate}}%</div>
                        {{/delivery}}
                        {{/deliveryTime}}
                    </div>
                </div>

                <div class="box-row">
                    <div class="box top_dashed">
                        {{^hideProcurementBtn}}
                        <a href="javascript:;" class="btn weui_btn weui_btn_mini weui_btn_primary"
                           data-id="procurement">采购</a>
                        {{/hideProcurementBtn}}
                    </div>

                    <div class="box top_dashed">
                        {{^hideManufactureBtn}}
                        <a href="javascript:;" class="btn weui_btn weui_btn_mini weui_btn_primary btn_manufacture"
                           data-process-id="{{id}}" data-id="manufacture">屠宰</a>
                        {{/hideManufactureBtn}}
                    </div>

                    <div class="box top_dashed">
                        {{^hideDeliveryBtn}}
                        <a href="javascript:;" class="btn weui_btn weui_btn_mini weui_btn_primary btn_delivery"
                           data-process-id="{{id}}" data-id="delivery">配送</a>
                        {{/hideDeliveryBtn}}
                    </div>
                </div>
                {{/data}}
            </div>
        </div>
    </div>
</div>
</script>
<script>
    var pageData = {
                currentStock: ${currentStock},
                data:${data}
            };
</script>