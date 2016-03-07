%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%
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
		<asset:stylesheet href="payment.css" />
		<asset:stylesheet href="font-awesome.min.css"/>

		<asset:javascript src="jquery-2.1.1.min.js" />
		<g:layoutHead/>
		<r:layoutResources />
	</head>
	<body style="overflow-x: hidden;">
	<g:layoutBody/>
	<asset:javascript src="h5/common.js" />
	<asset:javascript src="h5/address.js" />
	<asset:javascript src="h5/payment.js" />

	<script>
		var jsApiLink = '${createLink(controller: "session", action: "bindWxJsApi")}';
		var initSessionLink = '${createLink(controller: "session", action: "initSession")}';

		var userMobile = '${userInfo?.mobile}';
		var userName = '${userInfo?.name}';
	</script>
	</body>
</html>
