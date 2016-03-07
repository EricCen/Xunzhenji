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

<script type="text/html" id="tpl_mlist">
<div class="page">
    <div class="hd">
        <h1 class="page_title"><strong><span id="add_delivery_date"></span>屠宰记录表</strong></h1>
    </div>

    <div id="manufacture_list"></div>
</div>
</script>

<div id="tpl_manufacture_list" style="display: none">
    {{#manufactures}}
    <div class="weui_cells_title">{{date}}</div>
    <div class="weui_cell">
        <div class="weui_cell_bd weui_cell_primary">
            <p>屠宰数量</p>
        </div>
        <div class="weui_cell_ft">{{quantity}}{{quantityUnit}}</div>
    </div>
    <div class="weui_cell">
        <div class="weui_cell_bd weui_cell_primary">
            <p>肉鸡净重</p>
        </div>
        <div class="weui_cell_ft">{{weight}}{{weightUnit}}</div>
    </div>
    <div class="weui_cell">
        <div class="weui_cell_bd weui_cell_primary">
            <p>出肉率</p>
        </div>
        <div class="weui_cell_ft">{{productionRate}}%</div>
    </div>
    {{/manufactures}}
</div>