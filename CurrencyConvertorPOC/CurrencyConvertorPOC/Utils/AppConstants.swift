
//
//  AppConstants.swift
//  CurrencyConvertorPOC
//
//  Created by Nicson on 29/11/2017.
//  Copyright © 2017 Nicson. All rights reserved.
//

import Foundation


/// Supported Currencies List and their types
enum CurrencyType:Int {
    
    case USD = 0, EURO = 1, JPY = 2
    
    static let allList = [USD,EURO,JPY] // You can add currencies in here, as of now I kept is as static let , but you can make it an instance array or stored array and update them
    
    static let currencyShortForm = ["USD","EUR","JPY"]
    static let currencySymbols = ["$","€","¥"]
    static let currencyShortFormEquations = ["USD":USD,"EUR":EURO,"JPY":JPY]

}


extension Notification.Name {
    static let sliderNotification = Notification.Name("sliderNotify")
}
