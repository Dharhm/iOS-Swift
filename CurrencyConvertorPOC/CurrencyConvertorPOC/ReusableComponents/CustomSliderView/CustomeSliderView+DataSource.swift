//
//  CustomeSliderView+DataSource.swift
//  CurrencyConvertorPOC
//
//  Created by Nicson on 30/11/2017.
//  Copyright © 2017 Nicson. All rights reserved.
//

import Foundation

extension CustomSliderView {
    
    func refresh(){
        
        refresh(viewModel: self.viewModel)
        
    }
    
    func refresh(viewModel:CustomSliderViewModel){
        
        self.sliderControl.value = Float(viewModel.sliderValue)!
        self.sliderValueLbl.text = viewModel.currencySymbol + String(format: "%.2f", self.sliderControl.value)
        self.sliderControl.maximumValue = viewModel.sliderMaxValue

    }
    
}
