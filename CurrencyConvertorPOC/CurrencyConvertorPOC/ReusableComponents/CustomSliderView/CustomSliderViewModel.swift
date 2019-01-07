//
//  CustomSliderViewModel.swift
//  CurrencyConvertorPOC
//
//  Created by Nicson on 30/11/2017.
//  Copyright © 2017 Nicson. All rights reserved.
//

import UIKit

class  CustomSliderViewModel{
    
    var sliderValue = "0.00"
    var currencyType:CurrencyType = .USD
    var currencySymbol = "$"
    var currencyShortForm = "USD"
    var sliderMaxValue:Float = 0

    var dataModel = CustomSliderDataModel()  // TODO : Need to figure out where this can be moved
    
    func updateViewModel(dataModel:CustomSliderDataModel?){
        
        if dataModel != nil{
            
            
        }
        
    }
    
}

struct CustomSliderDataModel{
    
    var sliderValue = 0

    
}
