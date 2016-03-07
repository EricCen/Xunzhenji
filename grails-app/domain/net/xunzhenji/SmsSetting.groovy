package net.xunzhenji

import net.xunzhenji.wechat.WeChatContext

/**
 * All video, image, voice are media, in wechat it will be deleted 3 days after upload, but will never be auto deleted
 * in this platform.
 */
class SmsSetting {
    def int balance
    def String ipWhiteList
    def int alarmBalance
    def String apiKey


}
