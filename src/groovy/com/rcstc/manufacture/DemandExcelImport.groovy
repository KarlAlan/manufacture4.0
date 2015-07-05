package com.rcstc.manufacture

import excelimport.AbstractExcelImporter
import excelimport.ExcelImportService

/**
 * Create: karl
 * Date: 14-11-7
 */
class DemandExcelImport extends AbstractExcelImporter {

    def excelImportService

    static Map CONFIG_DEMAND_COLUMN_MAP = [
            sheet:'Sheet1',
            startRow: 2,
            columnMap:  [
                    'B':'title',
                    'C':'author',
                    'D':'numSold',
            ]
    ]

    public DemandExcelImport(fileName){
        super(fileName)
    }

    List<Map> getDemands() {
        List demandList = excelImportService.convertColumnMapConfigManyRows(workbook, CONFIG_DEMAND_COLUMN_MAP)
    }
}
