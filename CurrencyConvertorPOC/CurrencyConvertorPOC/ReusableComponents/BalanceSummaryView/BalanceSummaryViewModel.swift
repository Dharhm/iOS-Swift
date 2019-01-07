//
//  BalanceSummaryViewModel.swift
//  CurrencyConvertorPOC
//
//  Created by Nicson on 29/11/2017.
//  Copyright © 2017 Nicson. All rights reserved.
//

import Foundation

class  BalanceSummaryViewModel{
    
    var balanceSummaryTitleText = "NA"
    var balanceAmountValue = "0.00"
    var currencyType:CurrencyType = .USD
    var currencySymbol = "$"
    var currencyShortForm = "USD"
    
    var dataModel = BalanceSummaryDataModel()  // TODO : Need to figure out where this can be moved
    
    func updateViewModel(dataModel:BalanceSummaryDataModel?){
        
        if dataModel != nil{
            

        }
        
    }
    
}

struct BalanceSummaryDataModel{
    
    var usdBalance:Float = 0.00
    var euroBalance:Float = 0.00
    var jyBalance:Float = 0.00

}
