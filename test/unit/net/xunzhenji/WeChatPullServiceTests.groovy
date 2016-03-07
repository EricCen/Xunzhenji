package net.xunzhenji

import net.xunzhenji.wechat.WeChatPullService
import org.apache.log4j.BasicConfigurator
import org.apache.log4j.Level
import org.apache.log4j.LogManager
import org.junit.Before
import org.junit.Test

class WeChatPullServiceTests {
	static transactional = true
	def WeChatPullService weChatPullService
	def log

    @Before
    def void setUp() {
		BasicConfigurator.configure()
		LogManager.rootLogger.level = Level.DEBUG
		log = LogManager.getLogger("com.xunzhenji.WeChatPullService")

		// use groovy metaClass to put the log into your class
        WeChatPullService.class.metaClass.getLog << {-> log}

        weChatPullService = new WeChatPullService()
        weChatPullService.locationService = new LocationService()
    }

    @Test
    def void testProcess() {
        weChatPullService.process("<xml><ToUserName><![CDATA[gh_5033b89a675a]]></ToUserName>\n" +
                "<FromUserName><![CDATA[o_KJxsxO_hf2iyPeVY_8IF17YoSI]]></FromUserName>\n" +
                "<CreateTime>1434728862</CreateTime>\n" +
                "<MsgType><![CDATA[event]]></MsgType>\n" +
                "<Event><![CDATA[LOCATION]]></Event>\n" +
                "<Latitude>23.171692</Latitude>\n" +
                "<Longitude>113.323036</Longitude>\n" +
                "<Precision>30.000000</Precision>\n" +
                "</xml>")
    }
}
