<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main"/>
		<title>${homePage?.title}</title>
		<asset:stylesheet src="jquery.bxslider.css"/>
		<style>
		#product_list {height:278px;margin-bottom:20px;overflow:hidden}
		#product_list .mt h2{padding-right:228px;}
		#product_list .mt .extra{height:18px;padding-right:25px;margin-top:8px;background:url(http://misc.360buyimg.com/product/home/1.0.0/css/i/homebg.png) -310px -5px no-repeat}
		#product_list .mt .extra:hover{background-position:-310px -29px}
		#product_list:hover .spacer i{-webkit-animation:guess-slide 1s .5s;-moz-animation:guess-slide 1s .5s;animation:guess-slide 1s .5s}
		#product_list .mc{height:232px;border:1px solid #ededed;border-top:0;overflow:visible}
		#product_list ul{height:210px;padding-top:20px;overflow:hidden}
		#product_list li{float:left;width:197px;overflow:hidden;padding-bottom:15px}
		#product_list li.fore1 .p-info{border-left:none}
		#product_list .p-img{text-align:center;margin-bottom:10px}
		#product_list .p-info{padding:0 36px;border-left:1px solid #e6e6e6}
		#product_list .p-name{height:36px;margin-bottom:6px}
		#product_list .p-price{color:#b51d1a;font-size:18px}
		#product_list .p-price i{font-size:14px}
		#product_list .spacer{position:relative;height:1px;line-height:0;font-size:0;background-color:#d1d1d1}
		#product_list .spacer i{width:365px;height:5px;overflow:hidden;position:absolute;right:-1px;top:-2px;background:#b72323 url(http://misc.360buyimg.com/product/home/1.0.0/css/i/homebg.png) no-repeat 0 -124px}
		.root61 #product_list li{width:201px}
		</style>
	</head>
	<body>
		<div>
			<ul class="bxslider">
				<g:each in="${homePage?.images}" var="image">
					<li><img src="${image.url}" style="min-width: 100%"/></li>
				</g:each>
			</ul>
		</div>

	<div id="product_list" class="m">
		<div class="mt"><h2>推荐商品</h2></div>

		<div class="mc"><div class="spacer"><i></i></div>
			<ul>
				<g:each in="${products}" var="product">
				<li class="fore1" clstag="h|keycount|2015|12b1">
					<div class="p-img">
						<g:link controller="h5" action="home" fragment="#product_${product.id}">
							<img data-lazy-img="done" width="130" height="130" title="${product.title}"
								 src="${product.banner?.thumbUrl}">
						</g:link>
					</div>
					<div class="p-info">
						<div class="p-name">
							<g:link controller="h5" action="product" id="${product.id}">${product.title}</g:link>
						</div>
						<div class="p-price" data-lazyload-fn="done"><i>¥</i>${product.price}</div>
					</div>
				</li>
				</g:each>
			</ul>
	</div>
		</div>
	</div>
		<div id="content">
			${homePage.content}
		</div>

	<div class="p-copyright" style="height: 20px;font-size: 12px;line-height: 20px;text-align: center;">
		©2015 寻真记 粤ICP备15049765号-1
	</div>
		<asset:javascript src="jquery.bxslider.js"/>
		<script>
			$('.bxslider').bxSlider({
				auto: true,
				pager:false,
				infiniteLoop:true,
				adaptiveHeight: true
			});
		</script>
	</body>
</html>
