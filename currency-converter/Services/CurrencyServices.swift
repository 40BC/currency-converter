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
        print("URL: \(SYMBOLS_URL)")
        Alamofire.request(SYMBOLS_URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
                if let json = JSON(data: data).dictionary {
                    if let symbols = json["symbols"] {
                        for (key, value) in symbols {
                            print("KEY \(key)")
                            print("VALUE \(value)")
                        }
                    } else {
                        print("No symbols available")
                    }
                }
            } else {
                debugPrint(response.result.error as Any)
                completion(false)
            }
        }
    }
    
    
}
