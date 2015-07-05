package com.rcstc.manufacture

/**
 * Create: karl
 * Date: 15-4-30
 */
public enum TaskStatus {
    DRAFT('0','草稿'),
    AUDIT('1','待审核'),
    ARRANGE('5','待安排'),
    DEVELOP('10','开发'),
    SIT('20','SIT'),
    ACCOMPLISHED('99','完成')

    String id
    String name

    TaskStatus(String id, String name) {
        this.id = id
        this.name = name
    }
}
