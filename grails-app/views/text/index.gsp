<%@ page import="org.apache.commons.lang.time.DateFormatUtils" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="admin"/>
    <title>图文列表</title>
</head>
<body>
    <div class="content">
        <div class="cLine">
            <div class="pageNavigator left">
                <g:link controller="text" action="add" title='新增文本自定义回复' class='btnGrayS vm bigbtn'><asset:image src="text.png" class="vm" />新增文本自定义回复</g:link>　
                <g:link controller="image" action="add" title='新增文本自定义回复' class='btnGrayS vm bigbtn'><asset:image src="text.png" class="vm" />新增图文自定义回复</g:link>
            </div>

            <div class="clr"></div>
        </div>
        <div class="msgWrap">
            <form method="post"  action="index.php?ac=importtxt&amp;id=9379&amp;wxid=gh_858dwjkeww5" id="info" >
                <input name="delall"  type="hidden" value="del" />
                <input name="wxid"  type="hidden" value="gh_858dwjkeww5" />
                <TABLE class="list-table" border="0" cellSpacing="0" cellPadding="0" width="100%">
                    <THEAD>
                    <TR>
                        <TH >编号</TH>
                        <TH class="keywords">关键词</TH>
                        <TH class="answer">回答</TH>
                        <TH  class="category" >匹配类型</TH>
                        <TH class="time">浏览次数</TH>
                        <TH class="time">时间</TH>

                        <TH class="edit norightborder">操作</TH>
                    </TR>
                    </THEAD>
                    <TBODY>
                    <TR>
                    </TR>
                    <g:each var="text" status="i" in="${texts}">
                        <tr>
                            <td> ${i}</td>
                            <td>${text.keywords?.keyword?.join(" ")}</td>
                            <td><div class="answer_text">${text.text}</div></td>
                            <td>${text.precisions == 1 ? "完全匹配" : "模糊匹配"}</td>
                            <td>${text.click}</td>
                            <td>${DateFormatUtils.format(text.dateCreated, "yyyy-MM-dd")}</td>
                            <td class="norightborder">
                                <g:link action="edit" id="${text.id}" title="编辑文本">编辑</g:link>
                                <g:link action="delete" id="${text.id}">删除</g:link>
                            </td>

                        </tr>
                    </g:each>

                    </TBODY>
                </TABLE>
            </form>
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
                <g:paginate total="${textTotal}" />
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
