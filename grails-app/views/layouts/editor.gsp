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

<g:layoutTitle default="微信服务平台"/></title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<asset:link rel="shortcut icon" href="favicon.ico" type="image/x-icon"/>
		<asset:link rel="apple-touch-icon" href="apple-touch-icon.png"/>
		<asset:link rel="apple-touch-icon" sizes="114x114" href="apple-touch-icon-retina.png"/>
		<asset:stylesheet href="main.css" />
		<asset:stylesheet href="mobile.css" />
		<asset:stylesheet href="style_2_common.css" />


		<r:require module="jquery" />
		<g:layoutHead/>
		<r:layoutResources />
		<g:set var="context" value="${session[net.xunzhenji.util.SessionUtil.SESSION_WECHAT_CONTEXT]}"/>
	</head>
	<body>
		<div class="contentmanage">
		<div class="developer">
		<g:render template="/navigator" model="${[context:context]}"/>
		<g:layoutBody/>
		<g:if test="${context}"></div> <!-- tableContent end --></g:if>
		</div>  <!-- developer end -->
		</div>  <!-- contentmanage end -->
		<div class="footer" role="contentinfo"></div>
		<div id="spinner" class="spinner" style="display:none;"><g:message code="spinner.alt" default="Loading&hellip;"/></div>
		<r:layoutResources />
	</body>
</html>
