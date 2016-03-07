grails.servlet.version = "2.5" // Change depending on target container compliance (2.5 or 3.0)
grails.project.class.dir = "target/classes"
grails.project.test.class.dir = "target/test-classes"
grails.project.test.reports.dir = "target/test-reports"
grails.project.target.level = 1.6
grails.project.source.level = 1.6
grails.server.port.http = 8080

//concordion.extensionFactories = [ "es.osoco.grails.plugins.concordion.extensions.ConfigurableScreenshotExtensionFactory" ]

//grails.project.war.file = "target/${appName}-${appVersion}.war"

// uncomment (and adjust settings) to fork the JVM to isolate classpaths
//grails.project.fork = [
//   run: [maxMemory:1024, minMemory:64, debug:false, maxPerm:256]
//]

grails.project.dependency.resolution = {
    // inherit Grails' default dependencies
    inherits("global") {
        // specify dependency exclusions here; for example, uncomment this to disable ehcache:
        // excludes 'ehcache'
    }
    log "error" // log level of Ivy resolver, either 'error', 'warn', 'info', 'debug' or 'verbose'
    checksums true // Whether to verify checksums on resolve
    legacyResolve false // whether to do a secondary resolve on plugin installation, not advised and here for backwards compatibility

    repositories {
        inherits true // Whether to inherit repository definitions from plugins

        grailsPlugins()
        grailsHome()
        grailsCentral()

        mavenLocal()
        mavenCentral()

        // uncomment these (or add new ones) to enable remote dependency resolution from public Maven repositories
        mavenRepo "http://snapshots.repository.codehaus.org"
        mavenRepo "http://repository.codehaus.org"
        mavenRepo "http://download.java.net/maven/2/"
        mavenRepo "http://repository.jboss.com/maven2/"
        mavenRepo "https://repo.grails.org/grails/plugins/"
        mavenRepo 'http://repo.spring.io/milestone'
    }

    dependencies {
        // specify dependencies here under either 'build', 'compile', 'runtime', 'test' or 'provided' scopes e.g.

        test "org.grails:grails-datastore-test-support:1.0.2-grails-2.4"

        runtime 'mysql:mysql-connector-java:5.1.29'
        compile 'org.springframework:spring-aop:4.1.0.RC2'
        compile 'org.springframework:spring-expression:4.1.0.RC2'

        compile 'org.apache.httpcomponents:httpmime:4.2.1'
        compile 'net.glxn:qrgen:1.2'
        provided 'xmlpull:xmlpull:1.1.3.1'
        provided 'xpp3:xpp3:1.1.4c'
        provided 'com.thoughtworks.xstream:xstream:1.4.7'
        test 'junit:junit:4.10'
        test "org.gebish:geb-spock:0.12.2"
        test "org.gebish:geb-junit4:0.12.2"

        test "org.seleniumhq.selenium:selenium-support:2.45.0"
        test "org.seleniumhq.selenium:selenium-firefox-driver:2.45.0"
//        test "org.concordion:concordion-screenshot-extension:1.1.2"
//        test "org.concordion:concordion-logging-tooltip-extension:1.1.2"
    }

    plugins {
        runtime ':hibernate4:4.3.5.5'
        runtime ":jquery:1.11.1"
        runtime ":jquery-ui:1.10.4"

        runtime ":resources:1.2.8"
        runtime ":gsp-resources:0.4.4"
        compile ":quartz:1.0.2"
        compile ":quartz-monitor:1.0"
        runtime ":rest:0.8"

        compile ":lesscss:1.0.0"
        provided ":less-asset-pipeline:2.3.0"
        provided ":version-update:1.5.0"

        test ":geb:0.12.2"

        // Uncomment these (or add new ones) to enable additional resources capabilities
//        runtime ":zipped-resources:1.0"
//        runtime ":cached-resources:1.0"
//        runtime ":yui-minify-resources:0.1.4"

        build ":tomcat:7.0.55.2"

        runtime ":database-migration:1.4.1"

        compile ':cache:1.1.8'
        compile ':scaffolding:2.1.2'
        compile ':asset-pipeline:2.1.5'
        compile ":spring-security-core:2.0-RC4"
        compile ":spring-security-ui:1.0-RC2"
        compile "org.grails.plugins:xmlrpc:0.1"
//        test ":concordion:0.1.2"
    }
}
