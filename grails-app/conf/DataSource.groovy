/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

dataSource {
    pooled = true
    driverClassName = "com.mysql.jdbc.Driver"
    username = "dbadmin"
    password = "zzzzzz"
}
hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = true
    cache.region.factory_class = 'org.hibernate.cache.ehcache.EhCacheRegionFactory'
}


// environment specific settings
environments {
    development {
        dataSource {
            dbCreate = "update" // one of 'create', 'create-drop', 'update', 'validate', ''
            url = "jdbc:h2:mem:testDb;MVCC=TRUE;LOCK_TIMEOUT=10000"
            driverClassName = "org.h2.Driver"
            username = ""
            password = ""
            logSql = false
        }
    }
    test {
        dataSource {
            dbCreate = "update" // one of 'create', 'create-drop', 'update', 'validate', ''
            url = "jdbc:mysql://localhost/xunzhenji?useUnicode=true&characterEncoding=UTF-8&autoReconnect=true"
            username = "dbadmin"
            password = "zzzzzz"
            logSql = false
        }
    }
    production {
        grails.config.locations = ["file:/opt/env/production.groovy"]
    }
}
