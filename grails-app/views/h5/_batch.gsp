%{--
  - Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
  - GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
  --}%

<%@ page import="org.apache.commons.lang.time.DateFormatUtils; net.xunzhenji.util.SessionUtil; net.xunzhenji.mall.Batch; net.xunzhenji.util.FormatUtil; net.xunzhenji.mall.Product" %>

<div id="batch_${batch.id}" data-title="${batch.title}" data-load="loadBatchPanel" class="panel"
	  desc="${batch.productionSimpleDate()}上市的${batch.product.title}">

<section class="row">
	<h3 class="food-title">${batch.title}</h3>
	<h5 class="food-title">${batch.currentState()}</h5>
	<g:if test="${batch.isPresales()}">
		<h5 class="food-title">市场价:<strike class="price stright-thru">${net.xunzhenji.util.FormatUtil.formatPrice(batch.product.price)}</strike></h5>
		<h5 class="food-title">预售价:<strong><span class="price">${net.xunzhenji.util.FormatUtil.formatPrice(batch.price)}</span></strong> (订金:<strong><span class="price">${net.xunzhenji.util.FormatUtil.formatPrice(batch.product?.deposit)}</span></strong>)</h5>
	</g:if>
	<g:else>
		<h5 class="food-title">售价:<span class="price">${net.xunzhenji.util.FormatUtil.formatPrice(batch.currentPrice())}</span></h5>
	</g:else>

	<form id="confirmOrderForm" method="post" action="${createLink(action: "confirmOrder")}">
	<table style="width: 100%">
		<tr>
			<td>
				<g:spinner value="0" tag="${"price=\""+batch.currentPrice()+"\""}" batchId="${batch.id}"/>
			</td>
		</tr>
	</table>
	</form>
</section>
<section class="row">
	<div class="item-title">详细情况 - WHAT</div>
	<div class="content">
	</div>
</section>
<section class="row" >
	<div class="item-title">其他产品 - OTHERS</div>
	<div class="item">
		<ul class="batch-list">
			<g:each in="${net.xunzhenji.mall.Batch.withCriteria {and {eq('product', batch.product) not { eq('id', batch.id) }}}}" var="b">
				<li class="list-item-desced list-thumb flex-group">
					<a href="#batch_${b.id}">
						<div class="batch-thumb">
						</div>
					</a>
					<div class="batch-content">
						<a href="#batch_${b.id}">
							<h4 class="list-item-hd">${b.title}</h4>
							<div style="font-size: 8px">
								<div>${b.currentState()}</div>
							<g:if test="${b.isPresales()}">
								<div class="am-list-item-text">预售价:<span class="price">${net.xunzhenji.util.FormatUtil.formatPrice(b.price)}</span> (订金:<strong><span class="price">${net.xunzhenji.util.FormatUtil.formatPrice(batch.product?.deposit)}</span></strong>)</div>
							</g:if>
							<g:else>
								<div class="am-list-item-text">售价:<span class="price">${net.xunzhenji.util.FormatUtil.formatPrice(b.product.price)}</span></div>
							</g:else>
							</div>
						</a>

					</div>
				</li>
			</g:each>
		</ul>
	</div>
</section>
</div>
