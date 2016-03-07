<%@ page import="net.xunzhenji.mall.Producer" %>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
	<tbody>
	<tr>
		<th>
			<label for="name"><g:message code="default.name.label" default="姓名" /><span class="required-indicator">*</span></label>
		</th>
		<td><g:textField name="name" required="" class="px" value="${producerInstance?.name}"/>
		</td>
	</tr>
	</tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
	<tbody>
	<tr>
		<th>
			<label for="introduction"><g:message code="default.introduction.label" default="简介" /><span class="required-indicator">*</span></label>
		</th>
		<td><g:textArea rows="4" name="introduction" required="" class="px" style="width:580px;height:auto" value="${producerInstance?.introduction}"/>
		</td>
	</tr>
	</tbody>
</table>

	<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
		<tbody>
		<tr>
			<th>
				<label for="address"><g:message code="default.address.label" default="地址" /><span class="required-indicator">*</span></label>
			</th>
			<td>
				<g:textField name="address" id="address" required="" class="px" value="${producerInstance?.address}"/>
				<a onclick="codeAddress();">搜索</a>
			</td>
		</tr>
		</tbody>
	</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
	<tbody>
	<tr>
		<th>
			<label for="longitude"><g:message code="default.longitude.label" default="经度" /></label>
		</th>
		<td><g:textField name="longitude" id="longitude" class="px" value="${producerInstance?.longitude}"/>
		</td>
	</tr>
	</tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
	<tbody>
	<tr>
		<th>
			<label for="latitude"><g:message code="default.latitude.label" default="纬度" /></label>
		</th>
		<td><g:textField name="latitude" class="px" value="${producerInstance?.latitude}"/>
		</td>
	</tr>
	</tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
	<tbody>
	<tr>
		<th>
			<label for="latitude">地图上选择</label>
		</th>
		<td>
			<div title="在地图上选择位置" id="select-location" class="panel">
				%{--<asset:image class="center-point-img" src="location.png"/>--}%
				<div id="map-container" style="width:603px;height:300px;"></div>
			</div>
		</td>
	</tr>
	</tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
	<tbody>
	<tr>
		<th>
			<label for="phone"><g:message code="default.phone.label" default="电话" /></label>
		</th>
		<td><g:textField name="phone" class="px" value="${producerInstance?.phone}"/>
		</td>
	</tr>
	</tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
	<tbody>
	<tr>
		<th>
			<label><g:message code="default.head.label" default="头像" /><br>最佳尺寸200×200像素</label>
		</th>
		<td>
			<div class="form-ele fileupload-container" id="fileupload-container-head">
				<g:if test="${producerInstance.head}">
				<div class="uploaded-img">
					<img style="max-width:200px;" src="${producerInstance.head.thumbUrl}" data-url="${producerInstance.head.deleteUrl}" id="${producerInstance.head.id}">
				</div>
				</g:if>
				<div class="fileupload-block" for="fileupload" ${producerInstance.head ? 'style="display:none"' : ""}>
					<p>拖拽图片放在此处上传</p>
					<span>或者</span>
					<span>点击此处上传</span>
				</div>
			</div>
		</td>
	</tr>
	</tbody>
</table>

<table class="userinfoArea" border="0" cellspacing="0" cellpadding="0" width="100%">
	<tbody>
	<tr>
		<th>
			<label><g:message code="producer.images.label" default="相册" /><span class="required-indicator">*</span></label>
		</th>
		<td>
			<div class="form-ele fileupload-container" id="fileupload-container-image">
				<g:each in="${producerInstance.images}" var="image">
				<div class="uploaded-img">
					<div>
						<label for="image_order_${image.id}">顺序:</label>
						<input class="px" type="number" name="image_order_${image.id}" value="${image.order}">
					</div>
					<div>
						<label>水印位置:</label>
						<a onclick="changeMarkerLocation(${image.id}, 'topleft')">左上</a>
						<a onclick="changeMarkerLocation(${image.id}, 'topright')">右上</a>
						<a onclick="changeMarkerLocation(${image.id}, 'bottomleft')">左下</a>
						<a onclick="changeMarkerLocation(${image.id}, 'bottomright')">右下</a>
					</div>
					<img style="max-width:200px;" src="${image.thumbUrl}" data-url="${image.deleteUrl}" id="${image.id}">
				</div>
				</g:each>
				<div class="fileupload-block" for="fileupload" style="display:none">
					<p>拖拽图片放在此处上传</p>
					<span>或者</span>
					<span>点击此处上传</span>
				</div>
			</div>
		</td>
	</tr>
	</tbody>
</table>

<asset:javascript src="map.qq.js"/>
<script>
	var geocoder,map,marker = null;
	function codeAddress() {
		var address = $("#address").val();
		geocoder.getLocation(address);
	}

	function loadAddressMap() {
		var container = $("#map-container");
		container.html("");
		var lng = $("#longitude").val();
		var lat = $("#latitude").val();
		if(lng == 0 || lat == 0){
			lng = 113.3441812801746;
			lat = 23.171633330703315;
		}
		var center = new qq.maps.LatLng(lat,lng);
		map = new qq.maps.Map(document.getElementById('map-container'),{
			center: center,
			zoom: 15
		});
		geocoder = new qq.maps.Geocoder({
			complete : function(result){
				map.setCenter(result.detail.location);
			}
		});

		var middleControl = document.createElement("div");
		middleControl.style.left="265px";
		middleControl.style.top="114px";
		middleControl.style.position="relative";
		middleControl.style.width="36px";
		middleControl.style.height="36px";
		middleControl.style.zIndex="100000";
		middleControl.innerHTML ='${asset.image(src:"location.png", class:"center-point-img")}';
		document.getElementById("map-container").appendChild(middleControl);

		qq.maps.event.addListener(map, 'center_changed', function() {
			var latlng =  map.getCenter();
			$("#longitude").val(latlng.lng);
			$("#latitude").val(latlng.lat);
			console.log(latlng.lat)
		});
	}

	$(document).ready(function(){
		loadAddressMap();
	});
</script>