package net.xunzhenji.mall

/**
 * 1. 普通客户和领鲜群主在地里位置上的关系 （并不代表客户属于领鲜群）
 * 2. 每次建立领鲜群，自动扫描所有1km范围内的现有用户加入到本关系中
 * 3. 需要通过batch job把每天新增客户加入到本关系中
 */
class UserInfoLxGroup {
    def UserInfo userInfo
    def LxGroup lxGroup
    def long distance
    def Boolean isDefault = Boolean.FALSE

    static constraints = {
    }
}
