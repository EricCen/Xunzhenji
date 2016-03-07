package net.xunzhenji.wechat

/**
 *
 * Created by: Kevin
 * Created time : 2015/5/8 10:59
 *
 * Copyright 2015 Kevin Peng - kevinzjpeng@gmail.com
 */
abstract class Areply {
    def int precisions = 0 //matching mode
    def Date dateCreated
    def Date lastUpdated

    def checkDuplicatedKeywords(List keywords) {
        Keyword.withCriteria { 'in'('keyword', keywords) }
    }
}
