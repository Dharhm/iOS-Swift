//
//  SharedTransactionHistory
//  CurrencyConvertorPOC
//
//  Created by Nicson on 30/11/2017.
//  Copyright © 2017 Nicson. All rights reserved.
//

import Foundation


class SharedTransactionHistory: NSObject {
    
    static let sharedInstance = SharedTransactionHistory()

    var balanceDetails = [CurrencyType.USD  : "0.00",
                          CurrencyType.EURO : "1000.00",
                          CurrencyType.JPY   : "0.00"] // Initial amount EURO 1000 as per the requirement
    
    var selectedTransaction:(fromCurrency:String, toCurrency:String,amount:String, comissionCharge: Double, date:Date) = ("EUR","USD","0.00", 0.0, Date())
    
    var convertedTransactionDetails:(balanceAmountList:[Float],previousTransactionsList:[(fromCurrency:String, toCurrency:String,amount:String, comissionCharge: Double, date:Date)], recentTransaction:(fromCurrency:String, toCurrency:String,amount:String, comissionCharge: Double, date:Date)) = ([],[],("USD","EUR","0.00",0.0,Date()))
    
    
    var transactionHistory:[(fromCurrency:String,toCurrency:String,amount:String, commission:Double, date:Date)] = []
    
    var commission:Double = 0.07
    
    var freeTransactionLimit = 2
    
    func resetSelection(){
        selectedTransaction.amount = "0"
        selectedTransaction.toCurrency = "EUR"
        selectedTransaction.fromCurrency = "USD"

    }
}


