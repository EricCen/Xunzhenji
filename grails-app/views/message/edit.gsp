<%--
  Created by IntelliJ IDEA.
  User: Kevin
  Date: 2015/5/21
  Time: 15:56
--%>

<%@ page import="net.xunzhenji.wechat.SendMessage" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="admin"/>
    <title>添加群发消息</title>
    <asset:stylesheet href="appmsg.css" />
    <style>
    a.a_upload, a.a_choose {
        border: 1px solid #3d810c;
        box-shadow: 0 1px #CCCCCC;
        -moz-box-shadow: 0 1px #CCCCCC;
        -webkit-box-shadow: 0 1px #CCCCCC;
        cursor: pointer;
        display: inline-block;
        text-align: center;
        vertical-align: bottom;
        overflow: visible;
        border-radius: 3px;
        -moz-border-radius: 3px;
        -webkit-border-radius: 3px;
        vertical-align: middle;
        background-color: #f1f1f1;
        background-image: -webkit-linear-gradient(bottom, #CCC 0%, #E5E5E5 3%, #FFF 97%, #FFF 100%);
        background-image: -moz-linear-gradient(bottom, #CCC 0%, #E5E5E5 3%, #FFF 97%, #FFF 100%);
        background-image: -ms-linear-gradient(bottom, #CCC 0%, #E5E5E5 3%, #FFF 97%, #FFF 100%);
        color: #000;
        border: 1px solid #AAA;
        padding: 2px 8px 2px 8px;
        text-shadow: 0 1px #FFFFFF;
        font-size: 14px;
        line-height: 1.5;
    }

    .pages {
        padding: 3px;
        margin: 3px;
        text-align: center;
    }

    .pages a {
        border: #eee 1px solid;
        padding: 2px 5px;
        margin: 2px;
        color: #036cb4;
        text-decoration: none;
    }

    .pages a:hover {
        border: #999 1px solid;
        color: #666;
    }

    .pages a:active {
        border: #999 1px solid;
        color: #666;
    }

    .pages .current {
        border: #036cb4 1px solid;
        padding: 2px 5px;
        font-weight: bold;
        margin: 2px;
        color: #fff;
        background-color: #036cb4;
    }

    .pages .disabled {
        border: #eee 1px solid;
        padding: 2px 5px;
        margin: 2px;
        color: #ddd;
    }
    </style>
</head>

<body>
<g:form method="post" class="form" action="save" target="_top" enctype="multipart/form-data">
    <div class="content">
        <!--活动开始-->
        <div class="cLineB">
            <h4>设置群发消息</h4><a href="javascript:history.go(-1);"  class="right btnGrayS vm" style="margin-top:-27px" >返回</a>
        </div>

        <div class="msgWrap bgfc">

            <div style="float:left;width:60%;">
                <TABLE class="userinfoArea" style=" margin:0;" border="0" cellSpacing="0" cellPadding="0" width="100%">
                    <TBODY>
                    <tr>
                        <th><span class="red">*</span>群发标题</th>
                        <td><input type="text" class="px"  value="${sendMessage.title}" name="title"> 此标题只做发送类型区分，不会发送给粉丝</td>
                    </tr>
    <TR>
        <th valign="top"><span class="red">*</span>消息类型:</th>
        <TD>
            <input type="radio" value="${net.xunzhenji.wechat.SendMessage.MSG_TYPE_MPNEWS}" name="msgType"
                   class="send_type" ${sendMessage.msgType == SendMessage.MSG_TYPE_MPNEWS ? 'checked' : ''}>图文信息
        &nbsp;&nbsp;&nbsp;&nbsp;
            <input type="radio" value="${net.xunzhenji.wechat.SendMessage.MSG_TYPE_TEXT}" name="msgType"
                   class="send_type" ${sendMessage.sendType == SendMessage.MSG_TYPE_TEXT ? 'checked' : ''}>文本信息
        &nbsp;&nbsp;&nbsp;&nbsp;
        </TD>
    </TR>
                    <TR>
                        <th valign="top"><span class="red">*</span>选择图文消息
                            <g:hasErrors bean="${sendMessage}" field="images">
                                <g:eachError bean="${sendMessage}" field="images">
                                    <br/><p style="color: red;"><g:message error="${it}"/></p>
                                </g:eachError>
                            </g:hasErrors>
                        </th>
                        <TD>
                            <a href="###" onclick="addImgMessage()" class="a_choose">选择图文消息</a>&nbsp;&nbsp;<a href="###" onclick="clearMessage()" class="a_clear">清空重选</a>
                        </TD>
                    </TR>
    <TR>
        <th valign="top"><span class="red">*</span>输入文字
            <g:hasErrors bean="${sendMessage}" field="text">
                <g:eachError bean="${sendMessage}" field="text">
                    <br/>

                    <p style="color: red;"><g:message error="${it}"/></p>
                </g:eachError>
            </g:hasErrors>
        </th>
        <TD>
            <g:textArea name="text" value="${sendMessage.text}"/>
        </TD>
    </TR>
                    <TR>
                        <th valign="top"><span class="red">*</span>消息群发方式:</th>
                        <TD>
                            <input type="radio" value="1" name="sendType" class="send_type" ${sendMessage.sendType == SendMessage.SEND_TYPE_TO_GROUP ? 'checked' : ''}>分组群发
                        &nbsp;&nbsp;&nbsp;&nbsp;
                            <input type="radio" value="2" name="sendType" class="send_type" ${sendMessage.sendType == SendMessage.SEND_TYPE_TO_OPENIDS ? 'checked' : ''}>指定粉丝
                        &nbsp;&nbsp;&nbsp;&nbsp;
                            <input type="radio" value="3" name="sendType" class="send_type" ${sendMessage.sendType == SendMessage.SEND_TYPE_TO_ALL ? 'checked' : ''}>全部粉丝
                        </TD>
                    </tr>
                    <TR class="group_show">
                        <th>请选择分组：</th>
                        <td>
                            <g:if test="${weChatGroups}">
                                <select name="groupId" id="group"  style="width:150px;">
                                    <g:each in="${weChatGroups}" var="weChatGroup">
                                        <option value="${weChatGroup.id}">${weChatGroup.name}</option>
                                    </g:each>
                                </select>
                            </g:if>
                            <g:else>
                                <g:link controller="weChatGroup" action="index">还没有同步公众平台的粉丝分组，点击这里进行分组设置</g:link>
                            </g:else>
                        </td>
                    </TR>

                    <TR style="display:none;" class="fans_show">
                        <th valign="top">请选择粉丝：</th>
                        <td colspan="2">
                            <a href="javascript:void(0);" class="a_choose" id="add_fans">选择粉丝</a>
                            &nbsp;
                            <a href="javascript:void(0);" id="clear_fans">清空</a><br />
                            <textarea name="openid" id="fans_id" class="px"
                                      style="width:250px;height:60px;float:left;">${sendMessage.fans}</textarea>
                        </td>
                    </TR>

                    <tr>
                        <th valign="top"></th>
                        <td>

                            <input type="hidden" class="px" id="imgids" value="${sendMessage.images?.id?.join(',')}" name="imgids" >  <br>
                            <input type="hidden" class="px" id="id" value="${sendMessage.id}" name="id" >  <br>
                            <button type="submit" name="button" class="btnGreen">保存</button>
                            &nbsp;&nbsp;&nbsp;
                            <g:link action="index" class="btnGray vm">取消</g:link>
                        </td>
                    </tr>
                    <tr>
                        <th></th>
                        <td></td>
                    </tr>
                    </TBODY>
                </TABLE>
            </div>
            <div style="float:right;width:40%;">
                <div class="chatPanel" style="width:280px;${(!sendMessage.images || sendMessage.images.size() ==1) ? "" : 'display:none;'}" id="singlenews">
                    <div un="item_1741035" class="chatItem you">
                        <div class="media mediaFullText" id="titledom">
                            <div class="mediaPanel">
                                <div class="mediaHead"><span class="title" id="zbt">${sendMessage.images? sendMessage.images[0]?.title :'图文消息预览'}</span>
                                    <span class="time">${org.apache.commons.lang.time.DateFormatUtils.format(new Date(), 'yyyy-MM-dd')}</span>
                                    <div class="clr"></div>
                                </div>
                                <div class="mediaImg">
                                    <g:if test="${sendMessage.images}"><img id="suicaipic1" src="${sendMessage.images[0]?.pic?.url}"></g:if>
                                    <g:else><asset:image src="message/oid.jpg"/></g:else>
                                </div>
                                <div class="mediaContent mediaContentP">
                                    <p id="zinfo">${sendMessage.images? sendMessage.images[0]?.digest :'消息简介'}</p>
                                </div>
                                <div class="mediaFooter">
                                    <span class="mesgIcon right"></span><span style="line-height:50px;" class="left">查看全文</span>
                                    <div class="clr"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="media_preview_area" id="multinews" ${sendMessage.images?.size() > 1 ? "" : 'style="display:none"'}>
                    <div class="appmsg multi editing">
                        <div id="js_appmsg_preview" class="appmsg_content">
                            <div id="appmsgItem${sendMessage.firstImage()}" data-fileid="" data-id="1" class="js_appmsg_item ">
                                <div class="appmsg_info">
                                    <em class="appmsg_date"></em>
                                </div>
                                <div class="cover_appmsg_item" id="multione"><g:if test="${sendMessage.images?.size() > 1}">
                                    <h4 class="appmsg_title"><a href="javascript:void(0);" onclick="return false;" target="_blank">${sendMessage.firstImage().title}</a></h4>
                                    <div class="appmsg_thumb_wrp">
                                        <img style="border:1px solid #ddd" class="js_appmsg_thumb appmsg_thumb" src="${sendMessage.firstImage().pic?.url}">
                                        <i class="appmsg_thumb default" style="background:url(${sendMessage.firstImage().pic?.url});background-size:100% 100%">&nbsp;</i>
                                    </div>
                                    </g:if>
                                </div>
                            </div>
                            <g:each in="${sendMessage.fromSecondImages()}" var="item">
                            <div id="appmsgItem${item.id}" data-fileid="" data-id="4" class="appmsg_item js_appmsg_item ">
                                <img class="js_appmsg_thumb appmsg_thumb" src="${item.pic.url}">
                                <i class="appmsg_thumb default" style="background:url(${item.pic.url});background-size:100% 100%">&nbsp;</i>
                                <h4 class="appmsg_title"><a onclick="return false;" href="javascript:void(0);" target="_blank">${item.title}</a></h4>
                            </div>
                            </g:each>
                        </div>
                    </div>
                </div>
            </div>
            <div class="clr"></div>
        </div>
</g:form>
<div class="clr"></div>

<script src="/artDialog/jquery.artDialog.js?skin=default"></script>
<script src="/artDialog/plugins/iframeTools.js"></script>
<script>
    $(function(){

        if($('.send_type:checked').val() == 1){
            $('.group_show').css('display','');
            $('.fans_show').css('display','none');
            $('.send_type:eq(0)').attr('checked',true);
        }else if($('.send_type:checked').val() == 2){
            $('.group_show').css('display','none');
            $('.fans_show').css('display','');
            $('.send_type:eq(1)').attr('checked',true);
        }else if($('.send_type:checked').val() == 3){
            $('.group_show').css('display','none');
            $('.fans_show').css('display','none');
            $('.send_type:eq(2)').attr('checked',true);
        }

        $('.send_type').change(function(){
            if($(this).val() == 1){
                $('.group_show').css('display','');
                $('.fans_show').css('display','none');
            }else if($(this).val() == 2){
                $('.group_show').css('display','none');
                $('.fans_show').css('display','');
            }else if($(this).val() == 3){
                $('.group_show').css('display','none');
                $('.fans_show').css('display','none');
            }
        });
        $('#add_fans').click(function(){
            art.dialog.open('/message/addFans',{lock:true,title:'选择粉丝',width:600,height:400,yesText:'关闭',background: '#000',opacity: 0.45});
        });

        $('#clear_fans').click(function(){
            $('#fans_id').val('');
        });
    });


    function addImgMessage(){
        art.dialog.data('titledom', 'titledom');
        art.dialog.data('imgids', 'imgids');
        art.dialog.data('multinews', 'multinews');
        art.dialog.data('singlenews', 'singlenews');

        art.dialog.data('js_appmsg_preview', 'js_appmsg_preview');
        art.dialog.data('multione', 'multione');
        art.dialog.open('/message/addImage',{lock:true,title:'选择图文消息',width:600,height:400,yesText:'关闭',background: '#000',opacity: 0.45});
    }
    function clearMessage(){
        document.getElementById('titledom').innerHTML='';
        document.getElementById('imgids').value='';
        document.getElementById('js_appmsg_preview').innerHTML='<div class="appmsg_info"><em class="appmsg_date"></em></div><div class="cover_appmsg_item" id="multione"></div>';
        document.getElementById('multinews').style.display='none';
        document.getElementById('singlenews').style.display='';
    }
</script>
</body>
</html>