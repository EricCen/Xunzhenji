<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="admin"/>
    <title>发送消息</title>
    %{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%

<asset:stylesheet href="style.css?id=103" />
    <asset:stylesheet href="style_2_common.css" />
</head>

<body>
<div class="content" >
    <div class="cLineB">
        <h4>消息群发<span class="FAQ"></span></h4>
    </div>
    <div class="cLine">
        <div class="pageNavigator left">
            <g:link action="edit" title="新增群发消息" class="btnGrayS vm bigbtn"><asset:image width="16" class="vm" src="add.png" />新增群发消息</g:link>
        </div>

        <div class="clr"></div>
    </div>
    <div class="ftip" style="margin:0;">只有认证公众号才能使用（其他类型公众号请不要使用第三方群发，否则微信可能会封号）</div>

    <div class="msgWrap form">
        <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
        </g:if>
        <div class="bdrcontent">
            <div id="div_ptype">
                <table class="list-table" border="0" cellSpacing="0" cellPadding="0" width="100%">
                    <thead>
                    <tr>
                        <th style=" width:100px;">标题</th>
                        <th style=" width:80px;">群发类型</th>
                        <th style=" width:100px;" class="norightborder">发送时间</th>
                        <th style=" width:80px;">群发状态</th>
                        <th style=" width:120px;">操作</th>
                    </tr>
                    </thead>
                    <g:each in="${sendMessages}" var="msg">
                        <tr>
                            <td>${msg.title}</td>
                            <td>
                                <g:if test="${msg.sendType==1}">分组群发</g:if>
                                <g:elseif test="${msg.sendType==2}">指定粉丝</g:elseif>
                                <g:else>全部粉丝</g:else>
                            </td>
                            <td>
                                <g:if test="${msg.latestSendTime}">
                                     ${org.apache.commons.lang.time.DateFormatUtils.format(msg.latestSendTime, "yy-MM-dd HH:mm:ss")}
                                </g:if>
                                <g:else>未发送</g:else>
                            </td>
                            <td>
                                <g:if test="${msg.status == 0}"><p style="color:#ff203c;">未发送</p></g:if>
                                <g:elseif test="${msg.status == 1}"><p style="color:#ff9b2d;">已上传</p></g:elseif>
                                <g:elseif test="${msg.status == 2}"><p style="color:#44b549;">发送成功</p></g:elseif>
                                <g:else>发送失败</g:else>
                            </td>
                            <td class="norightborder">
                                <g:link charset="a_oper" action="edit" id="${msg.id}">编辑</g:link>
                                <g:link charset="a_oper" action="send" id="${msg.id}">
                                    <g:if test="${msg.status == 0}">立即发送</g:if>
                                    <g:else>重复发送</g:else>
                                </g:link>
                                <g:link charset="a_oper" action="preview" id="${msg.id}">预览</g:link>
                                <g:link charset="a_oper" action="delete" id="${msg.id}" onclick="javascript:return confirm('确定要删除吗');">删除</g:link>
                            </td>
                        </tr>
                    </g:each>
                </table>
            </div>
        </div>
        <div class="footactions" style="padding-left:10px">
            <div class="pages"></div>
        </div>
    </div>

</div>

<div class="clr"></div>

<script src="/artDialog/jquery.artDialog.js?skin=default"></script>
<script src="/artDialog/plugins/iframeTools.js"></script>
<script>
    function preview(id){
        art.dialog.open('?g=User&m=Message&a=preview&id='+id,{lock:true,title:'群发预览',width:600,height:400,yesText:'关闭',background: '#000',opacity: 0.45});
    }
</script>

</body>
</html>