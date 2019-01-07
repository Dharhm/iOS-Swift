//
//  ServerAPIInteractor.swift
//  CurrencyConvertorPOC
//
//  Created by Nicson on 30/11/2017.
//  Copyright © 2017 Nicson. All rights reserved.
//

import Foundation
import Alamofire
import Unbox
import UnboxedAlamofire

typealias responseCallback = (_ response:Any?) -> Void


class ServerAPIInteractor {
    
    
  public static func getRequestForService(url:String, responseClass:AnyClass?, headers:HTTPHeaders?, completion : @escaping responseCallback){
    
        // i should use responseclass with self type but some issues with parsing so i hardcoded TransactionResponse as expected response
        Alamofire.request(url, method: .get, headers:headers).responseObject { (response: DataResponse<TransactionResponse>) in

            completion(response.result.value)
            
            
        }
    }
    
}
