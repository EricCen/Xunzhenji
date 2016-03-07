<%--
  Created by IntelliJ IDEA.
  User: Kevin
  Date: 2015/5/8
  Time: 23:53
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="admin"/>
    <title>多图文回复</title>
    <link rel="stylesheet" type="text/css" href="/css/cymain.css" />
    <style>
    .title_list {
        list-style-type:circle;

    }
    .title_list li {
        height:23px;
        line-height:23px;
    }
    </style>
</head>

<body>
<div class="content">

    <div class="cLineB">
        <h4 class="left">多图文回复</h4>
        <div class="clr"></div>
    </div>

    <div class="msgWrap form">
        <ul id="tags" style="width:100%">
            <li>
                <g:link action="index">添加多图文回复</g:link>
            </li>
            <li class="selectTag">
                <g:link action="list">多图文回复列表</g:link>
            </li>

            <div class="clr" style="height:1px;background:#eee;margin-bottom:20px;"></div>
        </ul>
    </div>
    <table class="ListProduct" border="0" cellSpacing="0" cellPadding="0" width="100%">
        <thead>
        <tr>
            <th>编号</th>
            <th>关键词</th>
            <th>绑定图文消息标题</th>
            <th>操作</th>
        </tr>
        </thead>
        <g:each var="item" in="${multiImages}">
            <tr valign="top">
                <td>${item.id}</td>
                <td>${item.keywords?.join(" ")}</td>
                <td>
                    <ul class="title_list">
                        <assign name="title" value="$list['title']" />
                        <g:each var="image" in="${item.images}">
                            <li>${image.title} &nbsp;<g:link controller="image" action="edit" id="${image.id}" style="color:rgb(30, 137, 253)">编辑</g:link></li>
                        </g:each>
                    </ul>

                </td>
                <td><a href="javascript:drop_confirm('您确定要删除吗?', '${createLink(action: "delete", id: item.id)}')">删除</a></td>
            </tr>
        </g:each>
    </table>
</div>

<div class="clr"></div>

<script src="/artDialog/jquery.artDialog.js?skin=default"></script>
<script src="/artDialog/plugins/iframeTools.js"></script>
<script src="/js/upyun.js"></script>
<script src="/js/common.js"></script>

</body>
</html>