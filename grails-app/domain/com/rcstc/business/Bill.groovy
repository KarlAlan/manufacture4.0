package com.rcstc.business

import com.rcstc.manufacture.Person

class Bill {

    static constraints = {
        contract nullable: false
        title nullable: false
        amount nullable: false
        expireDate nullable: true
        remark nullable: true, maxSize: 2000
        fpPerson nullable: true
        spPerson nullable: true
        creater nullable: true
        createDate nullable: true
        invoices nullable: true
        funds nullable: true
    }

    static belongsTo = [contract:Contract]
    static hasMany = [invoices:Invoice,funds:Fund]

    String title                // 账款标题
    BigDecimal amount           // 应收账款
    Date expireDate             // 应收日期

    String fpPerson             //甲方联系人
    String spPerson             //乙方联系人
    Person creater              //创建人
    Date createDate             //创建日期

    ContractStatus status       //状态 （草稿、生效、作废）
    boolean verification        //到期应收标记

    String remark               // 备注

    @Override
    String toString() {
        return this.title    //To change body of overridden methods use File | Settings | File Templates.
    }

    BigDecimal sumAmountByInvoices(){
        BigDecimal ibs = 0
        this.invoices.each { it ->
            ibs = ibs + it.invoiceAmount
        }
        ibs
    }

    BigDecimal sumCreditAmountByFund(){
        BigDecimal ibs = 0
        this.funds.each {
            ibs = ibs + it.credit
        }
        ibs
    }
}
