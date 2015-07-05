package com.rcstc.business

import com.rcstc.manufacture.Person

class Invoice {

    static constraints = {
        invoiceNo nullable: false
        invoiceTitle nullable: false
        invoiceAmount nullable: false
        invoiceDate nullable: false
        drawer nullable: true
        receiver nullable: true
        status nullable: true
        confirmer nullable: true
        confirmDate nullable: true
        creater nullable: true
        createDate nullable: true
        type nullable: false
        tax nullable: true
        rebatesTax nullable: true
    }

    static belongsTo = [bill:Bill]

    String invoiceNo            //	发票号
    String invoiceTitle         //	发票台头
    BigDecimal invoiceAmount    //	发票金额
    Date invoiceDate            //	开票日期
    String drawer               //	开票经手人
    String receiver             //	收票人
    ContractStatus status       //	状态：（生效、作废）
    Person confirmer            //	甲方确认人
    Date confirmDate            //	确认日期

    InvoiceType type            //  发票类型
    BigDecimal tax              //  税额
    boolean isRebates           //  是否办理退税
    BigDecimal rebatesTax       //  退税金额

    Person creater              //创建人
    Date createDate             //创建日期
}

public enum InvoiceType {
    VALUE_ADDED_TAX_INVOICE('10','增值税发票'),
    PLAIN_INVOICE('20','普通发票')

    String id
    String name

    InvoiceType(String id, String name) {
        this.id = id
        this.name = name
    }
}