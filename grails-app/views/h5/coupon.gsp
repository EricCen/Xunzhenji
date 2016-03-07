%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%

<%--
  Created by IntelliJ IDEA.
  User: Irene
  Date: 2015/11/3
  Time: 17:40
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-type" content="text/html; charset=utf-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=0">
    <meta name="apple-mobile-web-app-capable" content="yes"/>
    <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>

    <title>${title}</title>
    <asset:stylesheet src="coupon-manifest.css?_=${System.currentTimeMillis()}" />
    <asset:javascript src="wechatpay-manifest.js?_=${System.currentTimeMillis()}" />
</head>
<body style="background-color: #eeeeee;">

<div style="text-align: center;margin: 10px auto;"><h2>${title}</h2></div>

<div class="afToastContainer bc">
    <div class="afToast bubble">
        <div class="message">
            <img class="avatar" src="${refereeFans?.headImgUrl}">
            <div class="bubble" style="margin-right: 20px; border-radius: 5px">
                <div class="plain">${coupon?.bubbleContent}</div>
            </div>
        </div>
    </div>
</div>

<div style="text-align: center;">
    <g:link class="btn btn-green btn-lg" style="margin: 10px; width: 90%" action="acceptCoupon" params="[referee:refereeFans?.openId, couponId: coupon?.id]">收藏这张优惠券</g:link>
</div>

<div class="description">${coupon?.content}</div>

<g:render template="links"/>
<script>
    $(document).ready(function(){
        if("${redirectUrl}"){
            window.location.href = "${redirectUrl}";
            return;
        }
        bindWeChatJsApi(function(){
            var title="${title}";
            var link=window.location.href;
            var imgUrl="${refereeFans?.headImgUrl}";
            var desc="${coupon?.bubbleContent}";

            wx.onMenuShareTimeline({
                title: title,
                link: link,
                imgUrl: imgUrl,
                desc: desc,
                success : function(){
                    ajaxGet(shareToTimelineLink, {});
                },
                cancel : function() {
                    ajaxGet(cancelShareToTimelineLink, {});
                }
            });

            wx.onMenuShareAppMessage({
                title: title,
                link: link,
                imgUrl: imgUrl,
                desc: desc,
                success : function(){
                    ajaxGet(shareToFriendsLink, {});
                },
                cancel : function() {
                    ajaxGet(cancelShareToFriendsLink, {});
                }
            });
        });
    });
</script>
</body>
</html>