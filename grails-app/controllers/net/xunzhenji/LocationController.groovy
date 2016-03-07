package net.xunzhenji

import grails.transaction.Transactional
import net.xunzhenji.datacollect.FansLocation
import net.xunzhenji.mall.City
import net.xunzhenji.mall.District
import net.xunzhenji.util.ErrorCodeUtil
import net.xunzhenji.util.SessionUtil
import net.xunzhenji.wechat.WeChatFans

/**
 *
 * Created by: Kevin
 * Created time : 2015/6/19 21:17
 *
 * Copyright 2015 Kevin Peng - kevinzjpeng@gmail.com
 */
class LocationController {
    def locationService

    @Transactional
    def update(){
        log.info("Receive location update, ${params}")
        def latitude = SessionUtil.getSessionValue(SessionUtil.SESSION_LATITUDE)
        def longitude = SessionUtil.getSessionValue(SessionUtil.SESSION_LONGITUDE)
        District district
        City city
        if(!latitude && !longitude){
            def WeChatFans weChatFans = SessionUtil.getSessionValue(SessionUtil.SESSION_WECHAT_FANS)

            if(weChatFans){
                def newLocation = new FansLocation(openId: weChatFans.openId, latitude: params.latitude, longitude: params.longitude,
                        locationPrecision: params.accuracy, createTime: new Date(), weChatFans: weChatFans)
                def address = locationService.getGpsAddress(params.latitude, params.longitude)
                if(address.status==0){
                    log.info("Converted result, ${address}")
                    newLocation.properties = address
                    newLocation.save(flush:true)

                    city = City.findByName(newLocation.city)
                    if(city){
                        district = District.findByNameAndCity(newLocation.district, city)
                    }
                }
            }
            SessionUtil.setSessionValue(SessionUtil.SESSION_LATITUDE, params.latitude)
            SessionUtil.setSessionValue(SessionUtil.SESSION_LONGITUDE, params.longitude)
        }

        if(district){
            log.info("Update district: ${district}")
            render ErrorCodeUtil.noError([city: city.name, province: city.province, district: district.name, districtId: district.id])
        }else {
            render ErrorCodeUtil.noError()
        }
    }

    def convertFromAddress(){
        def ret = locationService.getLocation(params.province, params.city, params.district, params.street, params.address);
        render ErrorCodeUtil.noError([lat:ret.latitude, lng: ret.longitude])
    }
}
