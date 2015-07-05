package com.rcstc.personnel

import com.rcstc.manufacture.OperateRecord

class Reward {

    static constraints = {
        rewardDate nullable: false
        username nullable: false
        rewardType nullable: false
        rewardPoint nullable: true
        evaluate nullable: true, inList: ["good","normal","bad"]
        description nullable: true
    }

    Date rewardDate
    String username
    RewardType rewardType
    BigDecimal rewardPoint
    String evaluate
    String description

    static Reward rewardPoint(String username, BigDecimal point){
        def instance = new Reward()
        instance.rewardDate = new Date()
        instance.rewardType = RewardType.积分
        instance.username = username
        instance.rewardPoint = point

        instance.save(flush: false, insert: true)
        instance
    }

    static Reward rewardEvaluate(String username, String eva, String desc){
        def instance = new Reward()
        instance.rewardDate = new Date()
        instance.rewardType = RewardType.评价
        instance.username = username
        instance.evaluate = eva
        instance.description = desc

        instance.save(flush: false, insert: true)
        instance
    }
}

public enum RewardType {
    评价('10'),
    积分('20')

    String id

    RewardType(String id) { this.id = id }
}