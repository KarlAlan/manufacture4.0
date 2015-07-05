package com.rcstc.business

import com.rcstc.manufacture.Person

class Fund {

    static constraints = {
        bank nullable: true
        refNo nullable: true
        checkNumber nullable: true
        payer nullable: true
        payee nullable: true
        occurrenceDate nullable: false
        debit nullable: true,scale: 2
        credit nullable: true,scale: 2
        particulars nullable: true
        creater nullable: true
        createDate nullable: true
    }

    static belongsTo = [bill:Bill]

    String bank                 //银行
    String refNo                //银行柜员流水
    String checkNumber          //支票号
    String payer                //付款人
    String payee                //收款人
    Date occurrenceDate         //到账日期
    BigDecimal debit            //作为支付方时记录(借方)
    BigDecimal credit           //到账金额(贷方)
    String particulars          //摘要

    Person creater              //创建人
    Date createDate             //创建日期
}
