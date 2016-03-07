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

<script type="text/html" id="tpl_plist">
<div class="page">
    <div class="hd">
        <h1 class="page_title"><strong>采购记录表</strong></h1>
    </div>

    <div id="procurement_list"></div>
</div>
</script>

<div id="tpl_procurement_list" style="display: none">
    <div class="flex_cell">
        <div class="weui_cell_primary weui_cells_title">{{date}}</div>
        <div class="weui_cell_ft" style="font-size: 14px;margin-top: .77em; margin-bottom: .3em;">合计{{sum}}元</div>
    </div>
    {{#procurements}}
    <div class="weui_cell">
        <div class="weui_cell_bd weui_cell_primary">
            <p>{{product}}</p>
        </div>
        <div class="weui_cell_ft">{{quantity}}{{quantityUnit}}{{weight}}{{weightUnit}}</div>
    </div>
    <div class="weui_cell">
        <div class="weui_cell_bd weui_cell_primary">
            <p>单价</p>
        </div>
        <div class="weui_cell_ft">{{price}}元</div>
    </div>
    <div class="weui_cell">
        <div class="weui_cell_bd weui_cell_primary">
            <p>平均重量</p>
        </div>
        <div class="weui_cell_ft">{{avgWeight}}{{weightUnit}}</div>
    </div>
    <div class="weui_cell">
        <div class="weui_cell_bd weui_cell_primary">
            <p>货主</p>
        </div>
        <div class="weui_cell_ft">{{source}}</div>
    </div>
    {{/procurements}}
</div>