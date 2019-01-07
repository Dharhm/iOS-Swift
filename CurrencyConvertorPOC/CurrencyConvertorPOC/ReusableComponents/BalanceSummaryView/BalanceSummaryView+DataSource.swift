//
//  BalanceSummaryView+DataSource.swift
//  CurrencyConvertorPOC
//
//  Created by Nicson on 29/11/2017.
//  Copyright © 2017 Nicson. All rights reserved.
//

import Foundation


extension BalanceSummaryView {
    
    func refresh(){
        
       refresh(viewModel: self.viewModel)
    }
    
    func refresh(viewModel:BalanceSummaryViewModel){
        
        self.balanceSummaryTitle.text =   viewModel.balanceSummaryTitleText
        self.balanceAmountLbl.text =  viewModel.currencySymbol + String(format: "%.2f", Float(viewModel.balanceAmountValue)!)
    }
 
}
