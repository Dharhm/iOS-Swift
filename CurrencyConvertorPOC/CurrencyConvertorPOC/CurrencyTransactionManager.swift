//
//  CurrencyTransactionManager.swift
//  CurrencyConvertorPOC
//
//  Created by Nicson on 30/11/2017.
//  Copyright © 2017 Nicson. All rights reserved.
//

import Foundation
import Unbox
import Alamofire
import UnboxedAlamofire

typealias TransactionCompletionModel = (_ errorCode: String?, _ recentTransaction:(fromCurrency:String, toCurrency:String,amount:String, comissionCharge: Double, date:Date)?) -> Void

let getURLForCurrencyConversion =  "http://api.evp.lt/currency/commercial/exchange/"



class CurrencyTransactionManager {
    
    
    
    
    public static  func convertCurrenciesWithDetails(selectedTransaction:(fromCurrency:String, toCurrency:String,amount:String, comissionCharge: Double, date:Date) , completion: @escaping TransactionCompletionModel){
        
        var url = getURLForCurrencyConversion
        url = url + selectedTransaction.amount + "-" + selectedTransaction.fromCurrency + "/" + selectedTransaction.toCurrency + "/latest" //fromAmount}-{fromCurrency}/{toCurrency}/latest
        
        ServerAPIInteractor.getRequestForService(url: url, responseClass: nil, headers: nil) { (response) in
            
            if let resp = response as? TransactionResponse{
                
                completion(nil, (fromCurrency:selectedTransaction.fromCurrency, toCurrency:resp.currency,amount:resp.amount, comissionCharge: selectedTransaction.comissionCharge, date:Date()) as? (fromCurrency: String, toCurrency: String, amount: String, comissionCharge: Double, date: Date))
                
            }else{
                
                completion("ERRORED",nil)
            }
            
        }
    }
    
  public static  func processConversion(transactionModel:(fromCurrency:String, toCurrency:String,amount:String, comissionCharge: Double, date:Date)?) {
        let transaction = SharedTransactionHistory.sharedInstance
        
        
    // subtract selected amount from the fromCurrency balance
        transaction.balanceDetails[CurrencyType.currencyShortFormEquations[(transactionModel?.fromCurrency)!]!] = String(Double(transaction.balanceDetails[CurrencyType.currencyShortFormEquations[(transactionModel?.fromCurrency)!]!]!)! - Double((transaction.selectedTransaction.amount))!)
    
    // subtract commission from the fromCurrency balance
        transaction.balanceDetails[CurrencyType.currencyShortFormEquations[(transactionModel?.fromCurrency)!]!] = String(Double(transaction.balanceDetails[CurrencyType.currencyShortFormEquations[(transactionModel?.fromCurrency)!]!]!)! - (Double((transaction.selectedTransaction.amount))! * (transactionModel?.comissionCharge)!))
    
    // add converted chargaes to the existing balance of ToCurrency Account
        transaction.balanceDetails[CurrencyType.currencyShortFormEquations[(transactionModel?.toCurrency)!]!] =
           (String(Double(transaction.balanceDetails[CurrencyType.currencyShortFormEquations[(transactionModel?.toCurrency)!]!]!)! + Double((transactionModel?.amount)!)! ))
    
        SharedTransactionHistory.sharedInstance.transactionHistory.append((fromCurrency: (transactionModel?.fromCurrency)!, toCurrency: (transactionModel?.toCurrency)!, amount: (transactionModel?.amount)!, commission:(transactionModel?.comissionCharge)!, date:Date()))
        
    }
}


struct TransactionResponse {
    
    let amount: String?
    let currency: String?
    
}

extension TransactionResponse: Unboxable {
    
    init(unboxer: Unboxer) throws {
        
        self.currency =  unboxer.unbox(key: "currency")
        self.amount =  unboxer.unbox(key: "amount")
        
    }
}
