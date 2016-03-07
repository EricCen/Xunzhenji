
<%@ page import="org.apache.tools.ant.util.DateUtils" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="admin"/>
    <title>图文编辑器</title>
    <link rel="stylesheet" href="/kindeditor/themes/default/default.css" />
    <link rel="stylesheet" href="/kindeditor/plugins/code/prettify.css" />
</head>
<body>
<div class="content">
<div class="cLineB"><h4>编辑图文自定义内容</h4><a href="javascript:history.go(-1);"  class="right btnGrayS vm" style="margin-top:-27px" >返回</a></div>

<g:form method="post" action="save" enctype="multipart/form-data">
    <div class="msgWrap form">
        <TABLE class="userinfoArea" border="0" cellSpacing="0" cellPadding="0" width="100%">
            <THEAD>
            <TR>
                <TH style="width:120px" valign="top"><span class="red">*</span><label for="keywords">关键词：</label>
                    <g:hasErrors bean="${image}" field="keywords">
                        <g:eachError bean="${image}" field="keywords">
                            <br/><p style="color: red;"><g:message error="${it}"/></p>
                        </g:eachError>
                    </g:hasErrors>
                </TH>
                <TD><input type="text" class="px" id="keywords" value="${image.keywords?.keyword?.join(" ")}"  name="keywords" style="width:580px;"><br />
                    多个关键词请用空格格开：例如: 美丽&nbsp;漂亮&nbsp;好看<br/>
                </TD>
            </TR>
            <TR>
                <TH valign="top">关键词类型：</TH>
                <TD>
                    <label for="radio2"><input class="radio" id="radio2" type="radio" name="precisions" value="0" ${image.precisions == 0 ? 'checked="checked"' : ""} /> 包含匹配 （当此关键词包含粉丝输入关键词时有效）</label>
                    <br />
                    <label for="radio1"><input id="radio1" class="radio" type="radio" name="precisions" value="1" ${image.precisions == 1 ? 'checked="checked"' : ""} /> 完全匹配  （当此关键词和粉丝输入关键词完全相同时有效）</label>
                </TD>
            </TR>
            </THEAD>
            <TBODY>
            <TR>
                <TH><span class="red">*</span><label for="title">标题：</label>
                    <g:hasErrors bean="${image}" field="title">
                        <g:eachError bean="${image}" field="title">
                            <br/><p style="color: red;"><g:message error="${it}"/></p>
                        </g:eachError>
                    </g:hasErrors></TH>
                <TD><input type="text" class="px" id="title" value="${image.title}"    name="title" style="width:580px;">
                </TD>
            </TR>
            <TR>
                <TH><label for="author">作者：</label></TH>
                <TD><input type="text" class="px" id="author" value="${image.author}" name="author" style="width:580px;"> </TD>
            </TR>

            <TR>
                <TH valign="top"><label for="text">简介：</label></TH>
                <TD><textarea  class="px" id="Hfcontent"     name="digest" style="width:580px;  height:100px">${image.digest}</textarea><br />限制200字内
                </TD>
            </TR>
            <TR>
                <TH valign="top"><label for="classid">文章所属类别：</label></TH>
                <TD>
                    <div id="classname" style="padding:5px;">${image.classification?.name}</div>
                    <g:select name="classid" optionKey="id" value="${image.classification?.id}" from="${net.xunzhenji.Classification.list()}"></g:select>
                    <g:link controller="classification" class="a_upload" style="margin-left:10px;" target="ddd" >添加分类</g:link>
                </TD>
            </TR>
            <TR>
                <TH valign="top"><label for="pic">封面图片地址：</label></TH>
                <TD>
                    <input hidden id="picId"  name="picId" value="${image.pic?.id}" />
                    <img src="${image.pic?.thumbUrl}" id="coverpic" style="max-width: 80px;max-height: 80px" />
                    <a href="###" onclick="upyunPicUpload('picId','coverpic',700,420,'<sec:loggedInUserInfo field="id" />')" class="a_upload">上传</a>
                </TD>
            </TR>
            <input type="hidden" name="id" value="${image.id}" />
            <TR>
                <TH valign="top"><label for="showpic">提示关注、查看原文：</label></TH>
                <TD>
                    隐藏<input class="radio" type="radio" name="isFocus" value="0" ${image.isFocus == 0 ? 'checked="checked"' : ''}/>
                    &nbsp;&nbsp;
                    &nbsp;&nbsp;
                    显示<input class="radio" type="radio" name="isFocus" value="1" ${image.isFocus == 1 ? 'checked="checked"' : ''} />
                    &nbsp;&nbsp;
                    设置隐藏后，编辑器中diy内容中的“关注”和“原文”素材在模板不会显示。（粉丝接收群发不受影响）
                </TD>
            </TR>
            <TR>
                <TH valign="top"><label for="showpic">详细页是否显示封面：</label></TH>
                <TD>
                    &nbsp;&nbsp;&nbsp;
                    是<input class="radio" type="radio" name="showPic" value="1" ${image.showPic == 1 ? 'checked="checked"' : ''} />
                    &nbsp;&nbsp;
                    &nbsp;&nbsp;
                    &nbsp;&nbsp;
                    否<input class="radio" type="radio" name="showPic" value="0" ${image.showPic == 0 ? 'checked="checked"' : ''} />

                </TD>
            </TR>
            <TR>
                <TH valign="top"><span class="red">*</span><label for="info">图文详细页内容：</label>
                    <g:hasErrors bean="${image}" field="content">
                        <g:eachError bean="${image}" field="content">
                            <br/><p style="color: red;"><g:message error="${it}"/></p>
                        </g:eachError>
                    </g:hasErrors>
                </TH>
                <TD><textarea name="content" id="content"  rows="5" style="width:590px;height:360px">${image.content}</textarea></TD>

            </TR>
            <TR>
                <input value="1" name="texttype" type="hidden">
                <TH></TH>
                <TD><input type="submit" value="保存" name="sbmt" class="btnGreen left">
                &nbsp;&nbsp;&nbsp;
                    <g:link action="index" class="btnGray vm">取消</g:link></TD>
            </TR>
            </TBODY>
        </TABLE>

    </div>
</g:form>

</div>

<div class="clr"></div>

<script src="/kindeditor/kindeditor.js" type="text/javascript"></script>
<script src="/kindeditor/lang/zh_CN.js" type="text/javascript"></script>
<script src="/kindeditor/plugins/code/prettify.js" type="text/javascript"></script>
<script src="/artDialog/jquery.artDialog.js?skin=default"></script>
<script src="/artDialog/plugins/iframeTools.js"></script>
<asset:javascript src="upyun.js?${org.apache.commons.lang.time.DateFormatUtils.format(new Date(), "yyyyMMddHHmmss")}" />
<r:script>
    var editor;
    KindEditor.ready(function(K) {
        editor = K.create('#content', {
            filterMode: false,
            resizeType : 1,
            allowPreviewEmoticons : false,
            allowImageUpload : true,
            postParams:{'uid':"<sec:loggedInUserInfo field="id" />"},
            uploadJson : '/upload/fileUpload',
            items : [
                'source','fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
                'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
                'insertunorderedlist', '|', 'emoticons', 'image', 'link', 'music', 'video','diyTool']
        })
    });
</r:script>
</body>
</html>
