package com.rcstc.manufacture.utils

import org.codehaus.groovy.grails.commons.GrailsApplication
import org.codehaus.groovy.grails.commons.cfg.GrailsConfig
import org.springframework.beans.PropertyEditorRegistrar
import org.springframework.beans.PropertyEditorRegistry
import org.springframework.stereotype.Component

import javax.annotation.Resource

/**
 * Create: karl
 * Date: 14-9-3
 */
@Component
class CustomPropertyEditorRegistrar implements PropertyEditorRegistrar {
    @Resource
    GrailsApplication grailsApplication
    /*
     * 注册自定义的属性装配器
     */
    @Override
    void registerCustomEditors(PropertyEditorRegistry registry) {
        def formats = grailsApplication.config.grails.date.formats as List
        //def formats = gc.get("grails.date.formats", List.class)?:["yyyy-MM-dd HH:mm:ss","yyyy-MM-dd'T'HH:mm:ss","yyyy-MM-dd"];
        println formats
        registry.registerCustomEditor(Date.class, new CustomDateBinder(formats));
    }
}
