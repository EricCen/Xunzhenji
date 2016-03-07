%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%

<%@ page import="net.xunzhenji.util.SignUtil" %>
<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<title><g:layoutTitle default="寻真记"/></title>
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no">
		<asset:link rel="shortcut icon" href="favicon.ico" type="image/x-icon"/>
		<asset:link rel="apple-touch-icon" href="apple-touch-icon.png"/>
		<asset:link rel="apple-touch-icon" sizes="114x114" href="apple-touch-icon-retina.png"/>
		<asset:stylesheet href="common.css" />
		<asset:stylesheet href="mobile.css" />
		<asset:stylesheet href="style_2_common.css" />
		<asset:stylesheet href="product.css"/>
		<asset:stylesheet href="trade.css"/>
		<asset:stylesheet href="ms.css"/>
		<asset:stylesheet href="bootstrap.css"/>
		<asset:stylesheet href="bootstrap-theme.min.css"/>
		<asset:stylesheet href="font-awesome.min.css"/>

	<r:require module="jquery" />
	<g:layoutHead/>
		<r:layoutResources/>
</head>
	<body style="overflow-x: hidden;">

	<div class="afui">
		<div id="splashscreen" class='ui-loader heavy'>
			App Framework
			<br>
			<br>    <span class='ui-icon ui-icon-loading spin'></span>
			<h1>Starting app</h1>
		</div>
		<div class="header">
			<a id='menubadge' onclick='af.ui.toggleSideMenu()' class='menuButton'></a>
		</div>
	<div class="guidance wrapper">
		<div class="header">
			<i id='favourite' class="fa fa-heart-o"></i>
		</div>
		<div>
			<g:layoutBody/>
		</div>

		<div class="gConWrap">
			<div class="gNavWrap">
				<div class="my-account">
					<g:if test="${fans?.headImgUrl}">
						<img src="${fans?.headImgUrl}" class="img-circle">
					</g:if>
					<g:else>
						<asset:image class="img-circle" src="profile-400x400.png" />
					</g:else>
					<div class="user-info">
						<h4>${fans?.nickName ? fans?.nickName : (userInfo?.name ? userInfo?.name : "未登陆")}</h4>
						<div class="user-mobile">${userInfo?.mobile}</div>
					</div>
				</div>
				<ul class="gNav">
					<li>
						<h4><a href="#" class="active">首页</a></h4>
					</li>
					<li>
						<h4><a href="#" class="active">订单</a></h4>
					</li>
					<li>
						<h4><a href="#" class="active">收藏</a></h4>
					</li>
					<li>
						<h4><a href="#" class="active">账号</a></h4>
					</li>
					<li>
						<h4><a href="#" class="active">关于</a></h4>
					</li>
					<li>
						<h4><a href="#" class="active">建议</a></h4>
					</li>
				</ul>
				<i id="getMenu" class="fa fa-bars"></i>
			</div>
		</div>
	</div>
	</div>
	<g:if test="${!userInfo || !userInfo.mobile || !userInfo.name}">
		<g:render template="/h5/userInfo" />
	</g:if>
	</div>
	<!-- For scripts -->
	<asset:javascript src="bootstrap.min.js" />
	<asset:javascript src="jquery.lazyload.js" />

	<script type="text/javascript">
		$(function () {
			var reload = function () {
				if ($(window).width() < 766) {//手机端菜单
					$('#getMenu').off('click').on('click', function () {
						$('.gConWrap').toggleClass('open');
					});
					$('.gCon').off('click').on('click', function () {
						$('.gConWrap').removeClass('open');
					});
				}

				if ($(document).scrollTop() > $('.nav').outerHeight()) {
					if ($('.gNavWrap').outerHeight() > $(window).height() - $('.nav').outerHeight()) {
						$('.gNavWrap').css({'height': $(window).height() - $('.nav').outerHeight()});
					}
				} else {
					$('.gNavWrap').css({});
				}
			}
			reload();
			$(window).scroll(function () {
				//.gNav 高度
				var navH = $('.gNav').outerHeight() + 16;
				var footOffTop = $(document).height() - $('.globalFooter').outerHeight() - $('.nav').outerHeight();
				var curBottom = $(document).scrollTop() + $(window).height();
				reload();
				if (curBottom > footOffTop) {
					$('.gNavWrap').css({
						'max-height': footOffTop - $(document).scrollTop()
					});
				} else {
					$('.gNavWrap').css({
						'max-height': navH
					});
				}
			});
		});
	</script>
	<script type="text/javascript" charset="utf-8" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
	<asset:javascript src="h5/common.js" />
	<script>
		var jsApiLink = '${createLink(controller: "session", action: "bindWxJsApi")}';
		var locationLink = '${createLink(controller: "location", action: "update")}';

		var userMobile = '${userInfo?.mobile}';
		var userName = '${userInfo?.name}';
		var latitude = ${latitude?latitude:0};
		var longitude = ${longitude?longitude:0};
	</script>
	<r:layoutResources />
	</body>
</html>
