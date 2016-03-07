<%--
  Created by IntelliJ IDEA.
  User: Kevin
  Date: 2015/5/21
  Time: 16:53
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="admin"/>
    <title>分组管理</title>
    <asset:stylesheet href="cymain.css" />
</head>
<body>
<div class="content">

    <div class="cLineB">
        <h4 class="left">分组管理</h4>
        <div class="clr"></div>
    </div>
    <div class="cLineD">

    </div>
    <div class="cLine">
        <div class="ftip" style="margin:0 auto">
            认证公众号才能使用，微信接口不支持删除分组操作，所以添加的时请谨慎操作，如需删除请到公众平台删除，本系统会与公众平台同步
        </div>
    </div>

    <div class="cLine">
        <div class="pageNavigator left">
            <g:link action="edit" class="btnGrayS vm bigbtn"><asset:image src="text.png" class="vm" />添加</g:link>
            &nbsp;
            &nbsp;
            <g:link action="syncGroup" class="btnGrayS vm bigbtn"><asset:image src="text.png" class="vm" />同步</g:link>
        </div>
        <div class="clr"></div>
    </div>
    <div class="msgWrap">
        <form method="post" action="" id="info">
            <input name="delall" type="hidden" value="del">
            <input name="wxid" type="hidden" value="gh_423dwjkewad">
            <table class="list-table" border="0" cellspacing="0" cellpadding="0" width="100%">
                <thead>
                <tr>
                    <th class="select">编号</th>
                    <th>公众平台中编号</th>
                    <th>名称 </th>
                    <th>粉丝量 </th>
                    <th>简介</th>
                    <th class="norightborder">操作</th>
                </tr>
                </thead>
                <tbody>
                    <g:each in="${weChatGroups}" var="item">
                    <tr>
                        <td>${item.id}</td>
                        <td>${item.wechatGroupId}</td>
                        <td><g:link action="show" id="${item.id}">${item.name}</g:link></td>
                        <td>${item.fansCount}</td>
                        <td>${item.description}</td>
                        <td class="norightborder">
                            <g:link action="edit" id="${item.id}">修改</g:link>
                        </td>
                    </tr>
                    </g:each>
                <tr>
                </tr>
                </tbody>
            </table>
        </form>
    </div>
</div>
</body>
</html>