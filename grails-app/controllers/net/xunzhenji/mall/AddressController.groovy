/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.mall

import grails.converters.JSON
import grails.transaction.Transactional
import net.xunzhenji.util.ErrorCodeUtil
import net.xunzhenji.util.SessionUtil

class AddressController {
    def static scaffold = true

    def locationService

    def listSupportCities() {
        def cities = City.list()
        render(cities.collect { [province: it.province, city: it.name, id: it.id] } as JSON)
    }

    def getDistricts() {
        def districts = District.findAllByCity(City.get(params.cityId))
        render(districts.collect { [district: it.name, id: it.id] } as JSON)
    }

    @Transactional
    def saveAddress() {
        log.info("Receive save address request, address.id:${params['address.id']}, lat:${params.latitude}, lng: ${params.longitude}")
        def district = District.get(params['district.id'])
        UserInfo userInfo = SessionUtil.getUserInfo()?.refresh()
        def city = district.city
        params.city = null
        Address address
        if (params['address.id']) {
            address = Address.get(params['address.id'] as long)
        } else {
            address = new Address(userInfo: userInfo)
        }
        address.properties = params
        address.city = city
        address.district = district
        Address.withTransaction {
            userInfo.addToAddress(address)
            address.save()
            userInfo.save()
        }

//        if (userInfo.address.size() == 1) {
            userInfo.myDefaultAddress = address
            userInfo.save()
//        }

        render ErrorCodeUtil.noError([id         : address.id,
                                      name       : address.name,
                                      phone      : address.phone,
                                      province   : address.city.province,
                                      city       : address.city.name,
                                      district   : address.district.name,
                                      districtId : address.district.id,
                                      street     : address.street,
                                      address    : address.address,
                                      isDefault: true,
                                      editable   : true])
    }

    @Transactional
    def deleteAddress() {
        log.info("Receive delete address request, address.id:${params.id}")
        Address address = Address.get(params.id)
        UserInfo userInfo = SessionUtil.getUserInfo()?.refresh()
        if (address) {
            if (userInfo.myDefaultAddress?.id == address.id) userInfo.myDefaultAddress = null
            address.disable = true
            address.save()

            render ErrorCodeUtil.noError([id: address.id])
        } else {
            log.warn("Cannot find the address")
            render ErrorCodeUtil.noAddressFound()
        }
    }

    def listAddress() {
        log.info("List address")
        UserInfo userInfo = SessionUtil.getUserInfo()?.refresh()
        if (!userInfo) {
            render ErrorCodeUtil.userNotYetLogin()
            return
        }

        def useGroupAddressAsDefault = userInfo.useGroupAddressAsDefault
        def useGroupAddress = useGroupAddressAsDefault && userInfo.groupDefaultAddress != null


        def userAddressList = userInfo.address.findAll{it.disable == false}.collect { add ->
            [
                    id          : add.id,
                    isDefault   : useGroupAddress ? false : add.id == userInfo.myDefaultAddress?.id,
                    name        : add.name,
                    phone       : add.phone,
                    province    : add.city.province,
                    city        : add.city.name,
                    district    : add?.district?.name,
                    districtId  : add?.district?.id,
                    street      : add.street,
                    address     : add.address,
                    latitude : add.latitude,
                    longitude: add.longitude,
                    headImageUrl: userInfo.headImageUrl(),
                    groupAddress: false
            ]
        }
        def groups = LxGroupMembers.findAllByUserInfo(userInfo)*.lxGroup
        def groupAddressList = groups.collect {
            [
                    id          : it.address.id,
                    isDefault   : useGroupAddress ? true : false,
                    name        : it.groupName,
                    phone       : it.address.phone,
                    province    : it.address.city.province,
                    city        : it.address.city.name,
                    district    : it.address?.district?.name,
                    districtId  : it.address?.district?.id,
                    street      : it.address.street,
                    address     : it.address.address,
                    headImageUrl: it.headImageUrl(),
                    groupAddress: true
            ]
        }
        def addressList = []
        addressList.addAll(userAddressList)
        addressList.addAll(groupAddressList)
        render ErrorCodeUtil.noError([addressList: addressList])
    }
}