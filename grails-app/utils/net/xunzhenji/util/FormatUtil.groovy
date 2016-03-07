package net.xunzhenji.util

import org.apache.commons.lang.time.DateFormatUtils
import org.apache.commons.lang.time.DateUtils

/**
 *
 * Created by: Kevin
 * Created time : 2015/7/3 10:07
 *
 * Copyright 2015 Kevin Peng - kevinzjpeng@gmail.com
 */
class FormatUtil {
    def static daysInWeekArr = ['日','一','二','三','四','五','六'];
    def static daysCounting =[
            0:"今天", 1:"明天", 2:"后天"
    ]
    def static String formatPrice(price){
        (price as BigDecimal).setScale(0, BigDecimal.ROUND_HALF_UP)
    }

    def static String formatFullPrice(price){
        (price as BigDecimal).setScale(2, BigDecimal.ROUND_HALF_UP)
    }

    def static String removeRightZero(value){
        def val=value.toString()
        while(val.endsWith("0") || val.endsWith(".")){
            val = val.substring(0, val.length() - 1)
        }
        val
    }

    def static String formatDate(date){
        date ? DateFormatUtils.format(date, "yy年M月d日") : ""
    }

    def static Date parseDate(String dateStr){
        return DateUtils.parseDate(dateStr, "yy年M月d日")
    }

    def static String formatDatetime(date){
        date ? DateFormatUtils.format(date, "yy年M月d日 HH:mm") : ""
    }

    def static String formatSimpleDate(date){
        date  ? DateFormatUtils.format(date, "M月d日") : ""
    }

    def static String formatCountingDate(date) {
        if(date){
            def daysLeft = date - new Date().clearTime()
            def daysLeftStr = daysCounting[daysLeft]
            return daysLeftStr ? daysLeftStr : ""
        }
        return ""
    }

    def static Date parseSimpleDate(String dateStr){
        return DateUtils.parseDate(dateStr, "M月d日")
    }

    def static String formatSimpleDatetime(date){
        date ? DateFormatUtils.format(date, "M月d日 HH:mm") : ""
    }

    def static toDetails(productOrders){
        def sb = new StringBuilder()
        productOrders.each{ order->
            sb.append("${order.product.title} ${order.batch.title} ${order.quantity}件\n")
        }
        sb.toString()
    }

    def static trimZero(str){
        if (str.indexOf(".") != -1 && str.charAt(str.length() - 1) == '0') {
            return trimZero(str.substring(0, str.length() - 1));
        } else {
            return str.charAt(str.length() - 1) == '.' ? str.substring(0, str.length() - 1) : str;
        }
    }

    def static formatDayInWeek(daysInWeek){
        daysInWeekArr[daysInWeek - 1]
    }

    def static formatDayInWeekStr(daysInWeekStr){
        return "周" + daysInWeekStr.split(",").collect{formatDayInWeek(it as int)}.join(",")
    }

    def static formatDurationUtilNow(time) {
        use(groovy.time.TimeCategory) {
            def now = new Date()
            if (now > time) {
                def duration = now - time
                return "${duration.days}天${duration.hours}小时前"
            } else {
                def duration = time - now
                return "${duration.days}天${duration.hours}小时后"
            }
        }
    }

    def static iso2Utf8(str) {
        new String(str.getBytes("ISO-8859-1"), "UTF-8")
    }

    def static formatPainStringNumber(number){
        if(number && number instanceof BigDecimal){
            return number?.stripTrailingZeros()?.toPlainString()
        }
        return number as String
    }
}
