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

<script type="text/html" id="tpl_dlist">
<div class="page">
    <div class="hd">
        <h1 class="page_title"><strong>配送记录表</strong></h1>
    </div>

    <div id="delivery_list"></div>
</div>
</script>

<div id="tpl_delivery_list" style="display: none">
    <div class="flex_cell">
        <div class="weui_cell_primary weui_cells_title">{{date}}</div>
        <div class="weui_cell_ft" style="font-size: 14px;margin-top: .77em; margin-bottom: .3em;">合计{{sum}}斤</div>
    </div>
    {{#deliveries}}
    <div class="weui_cell">
        <div class="weui_cell_bd weui_cell_primary">
            <p>{{shop}}({{product}})</p>
        </div>
        <div class="weui_cell_ft">{{weight}}{{weightUnit}}</div>
    </div>
    {{/deliveries}}
</div>