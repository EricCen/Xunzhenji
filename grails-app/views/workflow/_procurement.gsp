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

<script type="text/html" id="tpl_procurement">
<div class="page">
    <div class="hd">
        <h1 class="page_title"><strong><span id="add_procurement_date"></span>采购记录</strong></h1>
    </div>

    <form id="new_procurement_form">
        <div class="weui_cells weui_cells_form">

            <div class="weui_cell">
                <div class="weui_cell_hd"><label class="weui_label">日期</label></div>

                <div class="weui_cell_bd weui_cell_primary">
                    <input class="weui_input" type="date" name="date"
                           value="${new Date().clearTime().format("yyyy-MM-dd")}">
                </div>
            </div>

            <div class="weui_cell weui_cell_select weui_select_after">
                <div class="weui_cell_hd">货源</div>

                <div class="weui_cell_bd weui_cell_primary">
                    <select class="weui_select" id="p_source" name="source.id" onchange="selectSource(this);">
                        <option value="" disabled selected>选择货主</option>
                        <g:each in="${sources}" var="source">
                            <option value="${source.id}">${source.name}</option>
                        </g:each>
                        <option value="create">新增</option>
                    </select>
                </div>
            </div>

            <div class="weui_cell">
                <div class="weui_cell_hd"><label class="weui_label">毛鸡数量</label></div>

                <div class="weui_cell_bd weui_cell_primary">
                    <input class="weui_input" type="number" name="quantity" pattern="[0-9]*" placeholder="(必填)例如:100只">
                </div>
            </div>

            <div class="weui_cell">
                <div class="weui_cell_hd"><label class="weui_label">单价</label></div>

                <div class="weui_cell_bd weui_cell_primary">
                    <input class="weui_input" type="number" name="price" pattern="[0-9]*" placeholder="(必填)例如:8.5元">
                </div>
            </div>

            <div class="weui_cell">
                <div class="weui_cell_hd"><label class="weui_label">总毛重</label></div>

                <div class="weui_cell_bd weui_cell_primary">
                    <input class="weui_input" type="number" name="weight" pattern="[0-9]*" placeholder="(必填)例如:500斤">
                </div>
            </div>

            <div class="weui_cell">
                <div class="weui_cell_hd"><label class="weui_label">预计存栏</label></div>

                <div class="weui_cell_bd weui_cell_primary">
                    <input class="weui_input" type="number" name="quantityLeft" pattern="[0-9]*"
                           placeholder="(选填)例如:100只">
                </div>
            </div>
        </div>

        <div class="hd spacing">
            <a href="javascript:;" class="weui_btn weui_btn_primary" onclick="addProcurement();">添加</a>
            <a class='weui_btn weui_btn_default' href='javascript:;' onclick="resetAddProcurement();">重置</a>
        </div>
    </form>
</div>
</script>