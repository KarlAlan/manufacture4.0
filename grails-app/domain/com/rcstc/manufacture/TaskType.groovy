package com.rcstc.manufacture

/**
 * Create: karl
 * Date: 15-4-30
 */
public enum TaskType {
    DEPLOYMENT_TASK('80','发布任务'),
    MAINTENANCE_TASK('70','运维任务'),
    DOCUMENT_TASK('65','文档任务'),
    TRAIN_TASK('62','培训任务'),
    ONLINE_TASK('60','上线部署'),
    UAT_TASK('57','用户测试'),
    SIT_TASK('55','测试任务'),
    DEVELOP_TASK('50','开发任务'),
    SALE_TASK('20','销售活动'),
    DESIGN_TASK('15','系统设计'),
    ANALYSE_TASK('10','运营分析'),
    TROUBLE_SHOOTING_TASK('85','故障处理'),
    OTHER_TASK('90','其他任务')

    String id
    String name

    TaskType(String id, String name) {
        this.id = id
        this.name = name
    }
}
