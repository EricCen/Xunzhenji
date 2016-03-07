package net.xunzhenji

import org.apache.log4j.LogManager

class Server {
    String ip
    Date startupTime
    Boolean refreshBatchPrice = Boolean.FALSE
    Boolean refreshAccessToken = Boolean.FALSE
    Boolean refreshJsApiTicket = Boolean.FALSE
    Boolean remindPayment = Boolean.FALSE
    Boolean createDelivery = Boolean.FALSE

    static Server thisServer
    static transients = ['thisServer']

    static constraints = {
    }

    def static load(){
        def log = LogManager.getLogger(Server)
        try{
            String ip = InetAddress.getLocalHost().getLocalHost().hostAddress
            println  "This server ip: ${ip}"
            thisServer = Server.findByIp(ip)
            if(!thisServer){
                thisServer = new Server(ip: ip, startupTime: new Date())
                thisServer.save(flush: true)
            }
        }catch (e){
            println("Fail to get ip and load server configuration", e)
        }
    }

    def static otherServerIps(){
        def servers = Server.findAllByIpNotEqual(thisServer.ip)
        servers.collect{it.ip}
    }
}
