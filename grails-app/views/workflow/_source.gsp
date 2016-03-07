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

<script type="text/html" id="tpl_source">
<div class="page">
    <div class="hd">
        <h1 class="page_title"><strong>货主信息</strong></h1>
    </div>

    <form id="new_source_form">
        <div class="weui_cells weui_cells_form">
            <div class="weui_cell">
                <div class="weui_cell_hd"><label class="weui_label">姓名</label></div>

                <div class="weui_cell_bd weui_cell_primary">
                    <input class="weui_input" type="text" name="name" placeholder="(必填)例如:汤某某">
                </div>
            </div>

            <div class="weui_cell">
                <div class="weui_cell_hd"><label class="weui_label">电话</label></div>

                <div class="weui_cell_bd weui_cell_primary">
                    <input class="weui_input" type="number" name="phone" pattern="[0-9]*"
                           placeholder="(必填)例如:18888888888">
                </div>
            </div>

            <div class="weui_cell">
                <div class="weui_cell_hd"><label class="weui_label">位置</label></div>

                <div class="weui_cell_bd weui_cell_primary">
                    <input class="weui_input" type="text" name="address" placeholder="(必填)例如:始兴马市镇xx村">
                </div>
            </div>

            <div class="weui_cells weui_cells_form">
                <div class="weui_cell">
                    <div class="weui_cell_bd weui_cell_primary">
                        <textarea class="weui_textarea" placeholder="备注(选填)" rows="2"></textarea>
                    </div>
                </div>
            </div>
        </div>

        <div class="hd spacing">
            <a class="weui_btn weui_btn_primary" href="javascript:;" onclick="addSource()">添加</a>
            <a class='weui_btn weui_btn_default' href='javascript:;' onclick="resetAddSource();">重置</a>
        </div>
    </form>
</div>
</script>