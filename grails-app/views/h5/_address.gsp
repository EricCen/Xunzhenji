%{--
- Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
- GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
--}%
<div class="view" id="address-view">
	<header>
		<h1>地址管理</h1>
		<a id="save-address" style="display: none" onclick="saveAddress();">保存</a>
		<a id="add-address" style="display: none" onclick="addAddress();"><i class="fa fa-plus-circle"></i> <span style="font-size: 15px">添加新地址</span></a>
		<a id="close-address" class="close" style="display: none" onclick="backToReturnPanel(this);"><i class="fa fa-times"></i></a>
	</header>
	<div class="pages">
	<div id="address-panel" class="select-address panel" panelload="loadAddressPanel();" panelunload="unloadAddressPanel();" data-title="地址薄">
	<section class="row first-row address-list">
		<ul id="address-rows" class="list"></ul>
		<div class='add-address-btn' style="padding:30px 15px;">
			<div class="flex-item">
				<a class="btn btn-block btn-green btn-lg confirm-btn invalid" style="width: 100%;" onclick="confirmAddress()"><i class="fa fa-thumbs-o-up"></i> 确认地址</a>
			</div>
		</div>
	</section>
	</div>

	<!-- Edit address form -->
	<div id="addAddress" class="add-address panel" data-title="编辑地址">

		<g:form class="edit-address-form" controller="address" action="saveAddress">
			<input type="hidden" id='address_id' name="address.id" value="">
			<input type="hidden" id='latitude' name="latitude" value="">
			<input type="hidden" id='longitude' name="longitude" value="">

			<div class="input-group" style="padding-top: 27px;">
				<div role="realName" class="input-row">
					<div>收货人</div>

					<div>
						<input id="name" type="text" required="required" oninput="validateAddressForm();"
							   placeholder="输入收货人姓名" name="name" value="${userInfo && userInfo.name ? userInfo.name : ''}">
					</div>
				</div>

				<div role="phoneNumber" class="input-row"><div>手机号</div>

					<div>
						<input type="tel" id="phone" class="phoneNumber" name="phone" pattern="^\d{11}$"
							   placeholder="填写你的手机号码" oninput="validateAddressForm();" title="11位手机号码"
							   value="${userInfo && userInfo.mobile ? userInfo.mobile : ''}">
					</div>
				</div>

				<div role="city" class="input-row" style="padding: 3px 15px;">
					<div>城市/区县</div>

					<div>
						<a href="#select-province" onclick="getCities();">
							<input type="text" id="city" class="city" name="city" value=""
								   placeholder="" readonly onchange="validateAddressForm();"/>
						</a>
					</div>

					<div class="input-right-btn edit-city-btn"><a href="#select-province"><i
							class="fa fa-angle-right show-page"></i></a></div>

					<input type="hidden" id="district_id" name="district.id" value=""/>
				</div>

				<div role="street" class="input-row">
					<div>路名门牌</div>

					<div><input type="text" id="street" class="street" name="street"
								placeholder="XX路XX号(选填)" title="路名门牌"
								value="" oninput="validateAddressForm();">
					</div>
				</div>

				<div role="address" class="input-row"><div>详细地址</div>

					<div><input type="text" id="address" class="address" name="address"
								placeholder="XX小区XX栋XX室(必填)" title="详细地址"
								value="" oninput="validateAddressForm();">
					</div>
				</div>
			</div>
		</g:form>

		<div style="padding:30px 15px 30px 15px">
			<div class="flex-item">
				<a role="selectLocation" class="btn btn-block btn-green btn-lg invalid" style="margin:5px 0"
				   onclick="saveAddress()">保存</a>
			</div>

			<div class="flex-item">
				<button role="deleteAddress" class="btn btn-block btn-red btn-lg" style="margin:5px 0; display: none;"
						onclick="deleteAddress();">删除</button>
			</div>
		</div>
	</div>

	<div title="在地图上选择位置" id="select-location" class="panel">
		<asset:image class="center-point-img" src="location.png"/>
		<div id="map-container"></div>
	</div>

	<div id="tpl-address-row" style="display: none;">
		{{#addressList}}
		<li class="address-row" address-id="{{id}}" district-id="{{districtId}}" latitude="{{}}" longitude="{{}}">
			<div class="flex-group">
				{{#isDefault}}
				<div class="select-box is-dft" onclick="selectAddress(event);"><i class="fa fa-check-circle"></i></div>
				{{/isDefault}}
				{{^isDefault}}
				<div class="select-box" onclick="selectAddress(event);"><i class="fa fa-circle-o"></i></div>
				{{/isDefault}}

				{{#groupAddress}}
				<div class="show-address" address-id="{{addressId}}" is-group=true>
					<div class="head-user-phone flex-group">
						<div class="head-image">
							<img class="lazy img-circle" data-original="{{headImageUrl}}">
						</div>
						<div>
							<div><span class="lxgroup-name">领鲜群</span>:<span class="address-name">{{name}}</span></div>
							<div>电话: <span class="address-phone">{{phone}}</span></div>
						</div>
					</div>

					<div class="address-address" province="{{province}}" city="{{city}}" district="{{district}}"
						 street="{{street}}" address="{{address}}">地址:<span class="address-detail">{{city}}{{district}}{{street}}{{address}}</span>
					</div>
				</div>
				{{/groupAddress}}
				{{^groupAddress}}
				<a href="#addAddress" class="address-link chevron" onclick="editAddress();">
				<div class="show-address" address-id="{{addressId}}">
					<div class="head-user-phone flex-group">
						<div class="head-image">
							{{#headImageUrl}}
							<img class="lazy img-circle" data-original="{{headImageUrl}}">
							{{/headImageUrl}}
							{{^headImageUrl}}
							<img class="lazy img-circle" data-original="/assets/profile.png">
							{{/headImageUrl}}
						</div>
						<div>
							<div>收件人:<span class="address-name">{{name}}</span></div>
							<div>电话: <span class="address-phone">{{phone}}</span></div>
						</div>
					</div>

					<div class="address-address" province="{{province}}" city="{{city}}" district="{{district}}"
						 street="{{street}}" address="{{address}}">地址: <span class="address-detail">{{city}}{{district}}{{street}}{{address}}</span></div>
				</div>
				</a>
				{{/groupAddress}}
			</div>
		</li>
		{{/addressList}}
	</div>

	<div id="select-province" class="panel" data-title="选择省份">
		<div class="input-group" style="padding-top: 27px;">
			<ul class="list-group provinces">
			</ul>
		</div>
	</div>
	<div id="tpl-provinces">
		{{#provinceList}}
		<li class="list-group-item provinces-btn" onclick="clickProvince(event);">{{name}}</li>
		{{/provinceList}}
	</div>

	<div id="select-cities" class="panel" data-title="选择城市">
		<div class="input-group" style="padding-top: 27px;">
			<ul class="list-group cities">
			</ul>
		</div>
	</div>

	<div id="tpl-cities">
		{{#cityList}}
		<li class="list-group-item cities-btn" id="{{id}}" onclick="clickCity(event);">{{name}}</li>
		{{/cityList}}
	</div>

	<div id="select-districts" class="panel" data-title="选择区县">
		<div class="input-group" style="padding-top: 27px;">
			<ul class="list-group districts">
			</ul>
		</div>
	</div>

	<div id="tpl-districts">
		{{#districtList}}
		<li class="list-group-item districts-btn" id="{{id}}" onclick="clickDistrict(event);">{{district}}</li>
		{{/districtList}}
	</div>
	</div>
</div>