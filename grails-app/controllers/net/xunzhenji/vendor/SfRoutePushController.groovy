package net.xunzhenji.vendor

import net.xunzhenji.mall.Delivery
import net.xunzhenji.mall.DeliveryRouteUpdate
import net.xunzhenji.mall.Express

class SfRoutePushController {

    def index() {
        if (request.method == 'POST') {
            handlePost(params)
        }
    }

    def handlePost(params) {
        log.info("Receive Sf route push update.")
        def xml = request.reader.text
        log.info("XML: ${xml}")
        def msg = new XmlParser().parseText(xml)
        def routeUpdate = []
        def waybillRoutes = msg.Body.WaybillRoute
        waybillRoutes.each { route ->
            def deliveryRouteUpdate = new DeliveryRouteUpdate(express: Express.findByName("顺丰冷运宅配"))
            deliveryRouteUpdate.properties = [routeId      : route.@id[0],
                                              mailNo       : route.@mailno[0],
                                              orderId      : route.@orderid[0],
                                              acceptTime   : route.@acceptTime[0],
                                              acceptAddress: route.@acceptAddress[0],
                                              remark       : route.@remark[0],
                                              opCode       : route.@opCode[0]
            ]
            def delivery = Delivery.get(deliveryRouteUpdate.orderId as long)
            delivery.addToDeliveryRouteUpdate(deliveryRouteUpdate)
            routeUpdate << waybillRoutes
        }
        DeliveryRouteUpdate.saveAll(routeUpdate)
    }
}
