<%--
  Created by IntelliJ IDEA.
  User: Kevin
  Date: 2015/5/27
  Time: 14:27
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>微信公众平台源码,微信机器人源码,微信自动回复源码 PigCms多用户微信营销系统</title>
    <meta http-equiv="MSThemeCompatible" content="Yes" />
    <asset:stylesheet href="style_2_common.css?BPm" />
    <asset:stylesheet href="cymain.css" />
    <asset:stylesheet href="style.css" />
    <g:javascript library="jquery" />
    <r:layoutResources/>
    <style>
    body{line-height:180%;}
    ul.modules li{padding:4px 10px;margin:4px;background:#efefef;float:left;width:27%;}
    ul.modules li div.mleft{float:left;width:40%}
    ul.modules li div.mright{float:right;width:55%;text-align:right;}
    </style>
</head>
<body style="background:#fff;padding:20px 20px;">
<div style="background:#fefbe4;border:1px solid #f3ecb9;color:#993300;padding:10px;margin-bottom:5px;">使用方法：点击对应内容后面的“选中”即可。</div>
<form action="" method="post">
    <input type="" class="px" name="name" placeholder="请输入用户昵称"/>
    <input type="submit" value="搜索" class="btnGrayS"/>
</form>
<table class="ListProduct" border="0" cellSpacing="0" cellPadding="0" width="100%">
    <thead>
    <tr>
        <th>粉丝昵称</th>
        <th>分组名称</th>
        <th style=" width:80px;">操作 <span class="tooltips" ><asset:image src="price_help.png" align="absmiddle" /><span>
            <p>点击“选中”即可</p>
        </span></span>
        </th>
    </tr>
    </thead>
    <tbody>
    <g:if test="${fans}">
        <g:each in="${fans}" var="fan">
            <tr>
                <td>${fan.nickName}</td>
                <td>${fan.weChatGroup?.name}</td>
                <td class="norightborder">
                    <a href="###" onclick="returnHomepage('${fan.openId}')">选中</a>
                </td>
            </tr>
        </g:each>
    </g:if>
    <g:else>
        <tr>
            <td colspan="3" align="center"><a href="javascript:void(0);" target="_blank" style="color:#369">没有找到粉丝信息</a></td>
        </tr>
    </g:else>
    </tbody>
</table>
<div class="footactions" style="padding-left:10px">
    <div class="pages"></div>
</div>

<script src="/artDialog/jquery.artDialog.js?skin=default"></script>
<script src="/artDialog/plugins/iframeTools.js"></script>
<asset:javascript src="common.js" />
<script>
    // 返回数据到主页面
    function returnHomepage(openid){
        var origin = artDialog.open.origin;
        var list = origin.document.getElementById('fans_id').value;
        origin.document.getElementById('fans_id').value = list+openid+',';
        setTimeout("art.dialog.close()", 100 );
    }
</script>
</body>
</html>