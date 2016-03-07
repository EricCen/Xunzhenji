<%@ page import="org.apache.commons.lang.time.DateFormatUtils" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="admin"/>
    <title>图文列表</title>
</head>
<body>
    <div class="content">
        <div class="cLineB">
            <h4 class="left">自定义回复信息</h4>
            <div class="clr"></div>
        </div>
        <div class="cLine">
            <div class="pageNavigator left">
                <g:link controller="text" action="add" title='新增文本自定义回复' class='btnGrayS vm bigbtn'><asset:image src="text.png" class="vm" />新增文本自定义回复</g:link>　
                <g:link controller="image" action="add" title='新增文本自定义回复' class='btnGrayS vm bigbtn'><asset:image src="text.png" class="vm" />新增图文自定义回复</g:link>
            </div>
            <div style="float:right;line-height:30px;">
                <form action="#" method="post">
                    <input type="text" placeholder="请输入标题搜索词" value="" class="px" name="search" />
                    <button class="btnGrayS" style="height: 29px;">搜索</button>
                </form>
            </div>

            <div class="clr" style="height:20px;"></div>
            <div style="background:#fefbe4;border:1px solid #f3ecb9;color:#993300;padding:10px;margin-bottom:5px;font-size:12px;">温馨提示：修改排序时，首先填写好当前页面每篇文章的排序数值，点击“排序”按钮后整页统一保存。</div>
        </div>
        <div class="msgWrap">
            <TABLE class="list-table" border="0" cellSpacing="0" cellPadding="0" width="100%">
                <THEAD>
                <TR valign="top">
                    <TH class="answer">标题</TH>
                    <TH class="keywords">关键词</TH>

                    <TH  class="category" >分类</TH>
                    <TH class="time"><button class="btnGrayS" onclick="$('#sortform').submit()" >排序</button></TH>
                    <TH class="time">封面</TH>
                    <TH class="time">时间</TH>
                    <TH class="edit norightborder">操作</TH>
                </TR>
                </THEAD>
                <TBODY>
                <TR></TR>

                <form action="" method="post" id="sortform">
                    <g:each var="vo" in="${images}" >
                        <tr>
                            <td><div class="answer_text">${vo.title}</div></td>
                            <td>${vo.keywords?.keyword?.join(" ")}</td>
                            <td>${vo.classification?.name}</td>
                            <td>
                                <input type="number" style="border:1px solid #c9c9c9;-webkit-border-radius: 3px;-moz-border-radius: 3px;border-radius: 3px;" class="usort" name="usort{$vo.id}" value="{$vo.usort}" />
                            </td>
                            <td><g:if test="${vo.pic ? vo.pic.url : vo.thumbUrl}"><img
                                    src="${vo.pic ? vo.pic.url : vo.thumbUrl}"></g:if></td>
                            <td>${ org.apache.commons.lang.time.DateFormatUtils.format(vo.dateCreated, "yyyy-MM-dd")}</td>

                            <td class="norightborder">
                                <g:link controller="image" action="edit" id="${vo.id}" title="编辑图文自定义回复">编辑</g:link>
                                <g:link action="delete" id="${vo.id}">删除</g:link>
                            </td>

                        </tr>
                    </g:each>

                <input type="hidden" name="token" value="{pigcms:$_SESSION['token']}" />
                </form>
                </TBODY>
            </TABLE>
            <style>
            .usort {
                width:45px;
                height:23px;
            }
            </style>
            <script>
                function checkvotethis() {
                    var aa=document.getElementsByName('del_id[]');
                    var mnum = aa.length;
                    j=0;
                    for(i=0;i<mnum;i++){
                        if(aa[i].checked){
                            j++;
                        }
                    }
                    if(j>0) {
                        document.getElementById('info').submit();
                    } else {
                        alert('未选中任何文章或回复！')
                    }
                }


            </script>
        </div>
        <div class="cLine">
            <div class="pageNavigator right">
                <g:paginate total="${imageTotal}" />
            </div>
            <div class="clr"></div>
        </div>
    </div>

    <div class="clr"></div>

    <script>
        function checkAll(form, name) {
            for(var i = 0; i < form.elements.length; i++) {
                var e = form.elements[i];
                if(e.name.match(name)) {
                    e.checked = form.elements['chkall'].checked;
                }
            }
        }
    </script>
</body>
</html>
