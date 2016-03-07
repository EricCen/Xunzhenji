<%--
  Created by IntelliJ IDEA.
  User: Kevin
  Date: 2015/5/11
  Time: 21:34
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="admin"/>
    <title></title>
</head>

<body>
<div class="content">
    <div class="cLineB"><h4>添加微信公众号</h4></div>
    <g:form method="post" action="save" enctype="multipart/form-data">
        <input type="hidden" name="id" value="${weChatContext.id}">
        <div class="msgWrap">
            <table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
                <thead>
                <tr>
                    <th><span class="red">*</span>公众号名称：</th>
                    <td><input type="text" required="" class="px" name="name" value="${weChatContext.name}" tabindex="1" size="25">
                    </td>
                </tr>
                </thead>

                <tbody>
                    <tr>
                        <th><span class="red">*</span>公众号原始id：</th>
                        <td><input type="text" required="" name="weChatId" value="${weChatContext.weChatId}" onmouseup="this.value=this.value.replace('_430','')" class="px" tabindex="1" size="25">　<span class="red">请认真填写，错了不能修改。</span>比如：gh_423dwjkeww3 <a href="/tpl/static/getoid.htm" target="_blank"><img src="/images/help.png" class="vm helpimg" title="帮助"></a></td>
                    </tr>
                    <tr>
                        <th><span class="red">*</span>微信号：</th>
                        <td><input type="text" required="" name="username" value="${weChatContext.username}" class="px" tabindex="1" size="25">　比如：lentu123 </td>
                    </tr>
                    <tr>
                        <th><span class="red">*</span>商户号：</th>
                        <td><input type="text" required="" name="merchantId" value="${weChatContext.merchantId}"
                                   class="px"
                                   tabindex="1" size="25"></td>
                    </tr>
                <tr>
                    <th><span class="red">*</span>商户Key：</th>
                    <td><input type="text" required="" name="merchantKey" value="${weChatContext.merchantKey}"
                               class="px"
                               tabindex="1" size="25"></td>
                </tr>
                <tr>
                        <th>头像地址（url）:</th>
                        <td><input class="px" name="headerPic" id="pic" value="${weChatContext.headerPic}" size="60">    <script src="/js/upyun.js?2013"></script><a href="###" onclick="upyunPicUpload('pic',200,200,'${weChatContext.id}')" class="a_upload">上传</a> <a href="###" onclick="viewImg('pic')">预览</a></td>
                    </tr>

                    <input type="hidden" name="token" value="<sec:loggedInUserInfo field="id"/>" class="px" tabindex="1" size="40">
                    <tr>
                        <th><span class="red"></span>AppID（公众号）：</th>
                        <td><input type="text" name="appId" value="${weChatContext.appId}" class="px" tabindex="1" size="25">　用于自定义菜单等高级功能，可以不填 </td>
                    </tr>
                    <tr>
                        <th><span class="red"></span>AppSecret：</th>
                        <td><input type="text" name="appSecret" value="${weChatContext.appSecret}" class="px" tabindex="1" size="25">　用于自定义菜单等高级功能，可以不填 </td>
                    </tr>
                    <tr>
                        <th><span class="red"></span>消息加密方式：</th>
                        <td><select id="winxintype" name="encode">
                            <option value="0" ${weChatContext.encode == 0 ? "selected" : ""}>明文模式</option>
                            <option value="1" ${weChatContext.encode == 1 ? "selected" : ""}>兼容模式</option>
                            <option value="2" ${weChatContext.encode == 2 ? "selected" : ""}>安全模式</option>
                        </select>　 </td>
                    </tr>
                    <tr>
                        <th><span class="red"></span>AesEncodingKey：</th>
                        <td><input type="text" name="aesKey" value="${weChatContext.aesKey}" class="px" tabindex="1" size="55">　加密消息的AesEncodingKey </td>
                    </tr>

                    <tr>
                        <th><span class="red"></span>微信号类型：</th>
                        <td><select id="accountType" name="accountType">
                            <option value="1" ${weChatContext.accountType == 1 ? "selected" : ""}>订阅号</option>
                            <option value="2" ${weChatContext.accountType == 2 ? "selected" : ""}>服务号</option>
                            <option value="3" ${weChatContext.accountType == 3 ? "selected" : ""}>认证服务号</option>
                            <option value="4" ${weChatContext.accountType == 4 ? "selected" : ""}>认证订阅号</option>
                        </select>　认证服务号是指每年向微信官方交300元认证费的公众号 </td>
                    </tr>
                    <tr>
                        <th>公众号邮箱：</th>
                        <td><input type="text" required="" class="px" tabindex="1" value="${weChatContext.email}" name="email" size="25"></td>
                    </tr>
                    <tr>
                        <th>粉丝数：</th>
                        <td><input type="text" required="" name="fansCount" value="${weChatContext.fansCount}" class="px" tabindex="1" size="25"></td>
                    </tr>
                <tr>
                    <th></th>
                    <td><button type="submit" class="btnGreen" id="saveSetting">保存</button></td>
                </tr>
                </tbody>
            </table>

        </div>
    </g:form>
</div>

<div class="clr"></div>
</body>
</html>