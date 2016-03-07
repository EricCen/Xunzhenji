%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%
<div id="producer_${producerInstance.id}" data-title="${producerInstance.name}"
	 thumb-url="${producerInstance.head?.thumbUrl}" desc="${producerInstance.introduction}">
<section class="row">
	<div class="item">
		<div class="item-info">
			<div class="producer-info">
				<img data-original="${producerInstance.head.thumbUrl}" class="img-circle lazy" style="width: auto;margin-top: 10px;"/>
				<div class="producer-name"><h2 class="shop-name">${producerInstance.name}</h2></div>
				<div class="producer-addr">地址:${producerInstance.address}</div>
				<div class="producer-distance"></div>
			</div>

			<div class="share-desc">${producerInstance.introduction}</div>
		</div>
	</div>
</section>

<section class="row">
	<div class="map" style="width: 100%; height: 250px;"></div>
</section>

<section class="row">
	<div class="product-slider">
	<g:each in="${producerInstance.images?.sort{it.order}}" var='image'>
		<div class="img_txt_block">
			<img class="lazy" data-original="${image.mobileUrl}"/>
		</div>
	</g:each>
	</div>
</section>

<script>

	$(document).ready(function(){
		try {
			initMap($.afui.activeDiv, ${producerInstance.latitude}, ${producerInstance.longitude});
		} catch (e) {
		}
		try {
			updateDistance(${producerInstance.latitude}, ${producerInstance.longitude});
		} catch (e) {
		}
		$("#producer_${producerInstance.id}").find("img.lazy").lazyload({
			effect: "fadeIn",
			effectspeed: 500,
			event: "sporty"
		}).trigger("sporty");
	});
</script>
</div>
