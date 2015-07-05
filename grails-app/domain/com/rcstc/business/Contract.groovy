package com.rcstc.business

import com.rcstc.manufacture.Person
import com.rcstc.manufacture.Project

class Contract {

    static constraints = {
        serial nullable: false
        name nullable: false
        firstParty nullable: false
        secondParty nullable: false
        signDate nullable: true
        contractAmount nullable: true
        status nullable: false
        batch nullable: true
        remark nullable: true, maxSize: 2000
        fpPersons nullable: true
        spPersons nullable: true
        creater nullable: true
        createDate nullable: true
    }

    static hasMany = [bills:Bill,fpPersons:Person,spPersons:Person,projects:Project]

    String serial               //合同编号
    String name                 //合同名称
    String batch                //项目批次
    String firstParty           //甲方
    String secondParty          //乙方
    Date signDate               //签订日期
    BigDecimal contractAmount   //合同金额
    ContractStatus status       //状态（草稿、生效、作废、完成），乙方起草，甲方确认生效
    String remark               //备注

    Person creater              //创建人
    Date createDate             //创建日期

    @Override
    String toString() {
        return this.name    //To change body of overridden methods use File | Settings | File Templates.
    }

    //已收总额
    BigDecimal payed(){
        BigDecimal bd = 0
        this.bills.each {it ->
            bd = bd + it.sumCreditAmountByFund()
        }
        bd
    }

    //应收总额
    BigDecimal unPay(){
        /*
        BigDecimal bd = 0
        if(!this.contractAmount){
            bd = this.contractAmount - this.payed()
        }
        bd
        */
        if(!this.contractAmount)
            this.contractAmount = 0

        this.contractAmount - this.payed()
    }

    //到期应收未收金额
    BigDecimal shouldPay(){
        BigDecimal bd = 0
        this.bills.each {it ->
            if(it.verification){
                bd = bd + it.amount - it.sumCreditAmountByFund()
            }
        }
        bd
    }
}

public enum ContractStatus {
    DRAFT('10','草稿'),
    ACTIVE('20','生效'),
    ACCOMPLISHED('99','完成'),
    CANCELED('80','作废')

    String id
    String name

    ContractStatus(String id, String name) {
        this.id = id
        this.name = name
    }
}