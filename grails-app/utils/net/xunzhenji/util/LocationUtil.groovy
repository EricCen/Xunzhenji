/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.util;

public class LocationUtil {
	public static final double ONE_KM_LATLNG = 0.008984D
	public static final double HALF_KM_LATLNG = ONE_KM_LATLNG / 2

	public static double distance(Double lat1, Double lng1, Double lat2, Double lng2) {
		double radLat1 = toRad(lat1);
		double radLat2 = toRad(lat2);
		double deltaLat = radLat1 - radLat2;
		double deltaLng = toRad(lng1) - toRad(lng2);
		double dis = 2 * Math.asin(Math.sqrt(Math.pow(Math.sin(deltaLat / 2), 2) + Math.cos(radLat1) * Math.cos(radLat2) * Math.pow(Math.sin(deltaLng / 2), 2)));
		return dis * 6378137;
	}

	private static double toRad(double d) {
		return d * Math.PI / 180;
	}

}
