package net.xunzhenji

import net.xunzhenji.wechat.WeChatService

/**
 *
 * Created by: Kevin
 * Created time : 2015/5/27 17:20
 *
 * Copyright 2015 Kevin Peng - kevinzjpeng@gmail.com
 */
class LocationService extends WeChatService{
    def static String QQ_LOCATION_SERVICE_KEY = "W3MBZ-DY6R3-46Z35-33RUM-MWS3H-JSFIX"
    def static final String QQ_MAP_URL = "http://apis.map.qq.com/"


    def getAddress(latitude, longitude){
        def query  = [location: "${latitude},${longitude}", key:QQ_LOCATION_SERVICE_KEY, get_poi:1]

        def ret = [:]
        withHttp(QQ_MAP_URL, {api->
            api.get( path : "/ws/geocoder/v1/", query : query ) { resp, reader ->
                ret.status = reader.status
                ret.message = reader.message
                if(reader.status==0){
                    ret.address = reader.result?.address
                    ret.formattedAddress = reader.result?.formatted_addresses?.recommend
                    ret.rough = reader.result?.formatted_addresses?.rough
                    ret.city = reader.result?.address_component?.city
                    ret.district = reader.result?.address_component?.district
                    ret.nation = reader.result?.address_component?.nation
                    ret.province = reader.result?.address_component?.province
                    ret.street = reader.result?.address_component?.street
                    ret.streetNumber = reader.result?.address_component?.street_number
                }else{
                    log.warn("Cannot get location from qq map, message:${ret.message}")
                }
            }
        })
        return ret
    }

    def getLocation(province, city, district, street, address){
        return getLocationByAddress("${province}${city}${district}${street}${address}")
    }

    def getLocationByAddress(address) {
        log.info("Convert address into location")
        def query = [address: "${address}", key: QQ_LOCATION_SERVICE_KEY]
        def ret = [:]
        withHttp(QQ_MAP_URL, { api ->
            api.get(path: "/ws/geocoder/v1", query: query) { resp, reader ->
                ret.status = reader.status
                ret.message = reader.message
                if (reader.status == 0) {
                    def location =  reader.result.location
                    ret.latitude = location.lat
                    ret.longitude = location.lng
                    def addressComponents = reader.result.address_components
                    ret.province = addressComponents.province
                    ret.city = addressComponents.city
                    ret.street = addressComponents.street
                } else {
                    log.warn("Cannot get location from qq map, message:${ret.message}")
                }
            }
        });
        ret
    }

    def getGpsAddress(latitude, longitude){
        def convertedLocations = gpsConvert(latitude, longitude)
        return getAddress(convertedLocations.latitude, convertedLocations.longitude)
    }

    def gpsConvert(latitude, longitude){
        def query  = [locations: "${latitude},${longitude}", type: 1, key:QQ_LOCATION_SERVICE_KEY]

        def ret = [:]
        withHttp(QQ_MAP_URL, {api->
            api.get( path : "/ws/coord/v1/translate", query : query ) { resp, reader ->
                ret.status = reader.status
                ret.message = reader.message
                if(reader.status==0){
                    ret.latitude = reader.locations[0]?.lat
                    ret.longitude = reader.locations[0]?.lng
                }else{
                    log.warn("Cannot translate location from qq map, message:${ret.message}")
                }
            }
        })
        return ret
    }
}
