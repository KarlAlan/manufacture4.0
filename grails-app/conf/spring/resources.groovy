// Place your Spring DSL code here
import org.springframework.core.io.ClassPathResource
import org.springframework.core.io.support.PropertiesLoaderUtils;

import com.mchange.v2.c3p0.ComboPooledDataSource
// Place your Spring DSL code here
def properties = PropertiesLoaderUtils.loadProperties(new ClassPathResource("env.properties"))

beans = {
    dataSource(ComboPooledDataSource) {bean->
        driverClass = properties.getProperty("driverClassName")
        jdbcUrl=properties.getProperty("url")
        user =properties.getProperty("username")
        password =properties.getProperty("password")

        debugUnreturnedConnectionStackTraces=true
        maxIdleTime=5
        maxPoolSize=100
        minPoolSize=5
        acquireIncrement=3
        acquireRetryAttempts=50
        numHelperThreads=20
        checkoutTimeout=0
        maxStatements=0
        testConnectionOnCheckin=true
        testConnectionOnCheckout=true
    }

    //自定义属性绑定
    //customPropertyEditorRegistrar(com.rcstc.manufacture.utils.CustomPropertyEditorRegistrar)

    //Spring based scheduled tasks
    xmlns task: "http://www.springframework.org/schema/task"
    task.'annotation-driven'('proxy-target-class': true)
}
