//
//  CurrencyServices.swift
//  currency-converter
//
//  Created by Brandon Criss on 7/31/19.
//  Copyright © 2019 Brandon Criss. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class CurrencyService {
    static let instance = CurrencyService()
    
    var currencies = [Currency]()
    
    func getSupportedSymbols(completion: @escaping CompletionHandler) {
        Alamofire.request(SYMBOLS_URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
                if let json = JSON(data: data).dictionary {
                    if let symbols = json["symbols"] {
                        for (key, value) in symbols {
                            let symbol = key
                            let name = value.stringValue
                            
//                            self.currencies.append(Currency(symbol: symbol, name: name, value: nil))
                        }
                        
                        completion(true)
                    } else {
                        debugPrint("No symbols available")
                        completion(false)
                    }
                }
            } else {
                debugPrint(response.result.error as Any)
                completion(false)
            }
        }
    }
    
    func getLatestCurrencyValues(completion: @escaping CompletionHandler) {
        Alamofire.request(LASTEST_URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
                if let json = JSON(data: data).dictionary {
                    if let values = json["rates"] {
                        for (key, value) in values {
                            let symbol = key
                            let rate = value.doubleValue
                            
                            self.currencies.append(Currency(symbol: symbol, name: nil, value: convertDoubleToCurrency(currency: rate)))
                        }
                        completion(true)
                    }
                } else {
                    debugPrint("No values available")
                    completion(false)
                }
            } else {
                debugPrint(response.result.error as Any)
                completion(false)
            }
        }
    }
    
}
