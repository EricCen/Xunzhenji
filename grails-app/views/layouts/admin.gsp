<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<title><g:layoutTitle default="微信服务平台"/></title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<asset:link rel="shortcut icon" href="favicon.ico" type="image/x-icon"/>
		<asset:link rel="apple-touch-icon" href="apple-touch-icon.png"/>
		<asset:link rel="apple-touch-icon" sizes="114x114" href="apple-touch-icon-retina.png"/>
		<asset:stylesheet href="admin-manifest.css" />

		%{--<r:require module="jquery" />--}%
		%{--<r:require module="jquery-ui" />--}%
		%{--<r:require module="bootstrap" />--}%

		<g:layoutHead/>
		<r:layoutResources />
		<asset:javascript src="admin-manifest.js"/>
	</head>
	<body id="nv_member">
		<div class="contentmanage">
			<div class="developer">
				<div class="tableContent">
					<g:render template="/adminNav"/>
					<g:layoutBody/>
				</div> <!-- tableContent end -->
			</div>  <!-- developer end -->
		</div>  <!-- contentmanage end -->
		<div class="footer" role="contentinfo"></div>
		<r:layoutResources />
	</body>
</html>
