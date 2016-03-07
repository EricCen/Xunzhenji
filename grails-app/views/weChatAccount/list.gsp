<%--
  Created by IntelliJ IDEA.
  User: Kevin
  Date: 2015/5/11
  Time: 21:34
--%>

<%@ page contentType="text/html;charset=UTF-8" %>

<head>
    <meta name="layout" content="admin"/>
    <title></title>
</head>

<div class="content">
    <div class="pageNavigator left">
        <g:link action="edit" title='添加公众号' class='btnGrayS vm bigbtn'><asset:image src="text.png" class="vm" />添加公众号</g:link>　
    </div>
    <TABLE class="list-table" border="0" cellSpacing="0" cellPadding="0" width="100%">
        <THEAD>
        <TR>
            <TH>公众号名称</TH>
            <TH>创建时间</TH>
            <TH>请求数</TH>
            <TH>用户数</TH>
            <TH>操作</TH>
        </TR>
        </THEAD>
        <TBODY>
        <TR></TR>
        <g:each in="${weChatContexts}" var="weChatContext">
            <TR>
                <TD><p><a href="" title="点击进入功能管理"><img src="${weChatContext.headerPic}" width="40" height="40"></a></p><p>${weChatContext.name}</p></TD>
                <TD><p>创建时间:${org.apache.commons.lang.time.DateFormatUtils.format(weChatContext.dateCreated, "yyyy-MM-dd")}</p></Td>
                <TD><p>总请求数:</p></TD>
                <TD><p>用户数:</p></TD>
                <TD class="norightborder">
                    <g:link action="edit" id="${weChatContext.id}">编辑</g:link>
                    <g:link action="delete" id="${weChatContext.id}">删除</g:link>
                    <g:link action="enter" id="${weChatContext.id}">功能管理</g:link>
                    <a onclick="showApiInfo({pigcms:$vo.id},'{pigcms:$vo.wxname}')" href="###" class="btnGreens" >API接口</a>
                </TD>
            </TR>
        </g:each>

        </TBODY>
    </TABLE>

</div>
<br>
<div class="cLine">
    <div class="pageNavigator right">
        <div class="pages"></div>
    </div>
    <div class="clr"></div>
</div>
<div class="clr"></div>
