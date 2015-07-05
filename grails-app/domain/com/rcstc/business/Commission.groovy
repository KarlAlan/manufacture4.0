package com.rcstc.business

class Commission {

    static constraints = {
        company nullable: false
        project nullable: false
        contractAmount nullable: false
        procurementCosts nullable: true
        rebate nullable: true
        tax nullable: true
        saleman nullable: true
        saleRate nullable: true
        saleCommission nullable: true
        schemer nullable: true
        schemeRate nullable: true
        schemeBonus nullable: true
        manager nullable: true
        produceRate nullable: true
        planDate nullable: true
        budget nullable: true
        actualDate nullable: true
        actualCost nullable: true
        teamSize nullable: true
        teamBonus nullable: true
        managerBonus nullable: true
        grossProfit nullable: true
        grossProfitRate nullable: true
    }

    String company                  // 公司名称
    String project                  // 项目名称
    BigDecimal contractAmount       // 合同金额
    BigDecimal procurementCosts     // 采购成本
    BigDecimal rebate               // 回扣
    BigDecimal tax                  // 税金

    // 业务部分
    String saleman                   // 业务员
    BigDecimal saleRate              // 销售提成点数
    BigDecimal saleCommission        // 提成

    // 方案部分
    String schemer                   // 方案制作人
    BigDecimal schemeRate            // 方案奖金比例
    BigDecimal schemeBonus           // 奖金

    // 生产部分
    String manager                   // 项目经理
    BigDecimal produceRate           // 生产奖金比例
    Date planDate                    // 计划完成日期
    BigDecimal budget                // 成本预算
    Date actualDate                  // 实际完成日期
    BigDecimal actualCost            // 实际成本
    BigDecimal teamSize              // 团队人数
    BigDecimal teamBonus             // 团队总奖金
    BigDecimal managerBonus          // 项目经理奖金

    // 公司部分
    BigDecimal grossProfit           // 毛利
    BigDecimal grossProfitRate       // 毛利率

    private BigDecimal calculateBaseAmount() {
        return contractAmount - procurementCosts - rebate - contractAmount*tax
    }

    def calculateSaleCommission(){
        saleCommission = calculateBaseAmount() * saleRate
        return saleCommission
    }

    def calculateSchemeBonus(){
        schemeBonus =  calculateBaseAmount() * schemeRate
        return schemeBonus
    }

    def calculatePlanTeamBonus(){
        teamBonus = (calculateBaseAmount() - budget) * produceRate
        return teamBonus
    }

    def calculateActualTeamBonus() {
        if (actualDate <= planDate) {
            teamBonus =  (calculateBaseAmount() - actualCost) * produceRate
        } else if (actualDate <= planDate + 30) {
            teamBonus =  ((calculateBaseAmount() - actualCost) * produceRate) / 2
        } else {
            teamBonus = 0
        }

        return teamBonus
    }

    def calculateManagerBonus() {
        managerBonus = (teamBonus / (teamSize + 2)) * 3
        return managerBonus
    }

    def calculateGrossProfit() {
        grossProfit = calculateBaseAmount() - saleCommission - schemeBonus - teamBonus
        return grossProfit
    }

    def calculateGrossProfitRate() {
        grossProfitRate = grossProfit / contractAmount
        return grossProfitRate
    }
}
