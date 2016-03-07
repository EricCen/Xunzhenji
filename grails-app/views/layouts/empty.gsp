<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<title>%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%

<g:layoutTitle default="寻真记"/></title>
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no">
		<asset:link rel="shortcut icon" href="favicon.ico" type="image/x-icon"/>
		<asset:link rel="apple-touch-icon" href="apple-touch-icon.png"/>
		<asset:link rel="apple-touch-icon" sizes="114x114" href="apple-touch-icon-retina.png"/>
		<asset:stylesheet href="common.css" />
		<asset:stylesheet href="main.css" />
		<asset:stylesheet href="mobile.css" />
		<asset:stylesheet href="style_2_common.css" />
		<asset:stylesheet href="bootstrap.css"/>
		<asset:stylesheet href="bootstrap-theme.min.css"/>
		<asset:stylesheet href="font-awesome.min.css"/>

		<r:require module="jquery" />
		<g:layoutHead/>
		<r:layoutResources />
	</head>
	<body style="overflow-x: hidden;">
	<g:layoutBody/>
	<asset:javascript src="h5/common.js" />
	<script>
		var jsApiLink = '${createLink(controller: "session", action: "bindWxJsApi")}';
		var locationLink = '${createLink(controller: "location", action: "update")}';

		var userMobile = '${userInfo?.mobile}';
		var userName = '${userInfo?.name}';
		var latitude = ${latitude?latitude:0};
		var longitude = ${longitude?longitude:0};
	</script>
	</body>
</html>
