//
//  CurrencyVC.swift
//  currency-converter
//
//  Created by Brandon Criss on 7/31/19.
//  Copyright © 2019 Brandon Criss. All rights reserved.
//

import UIKit

class CurrencyVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        getSymbols()
    }
    
    func getSymbols() {
        CurrencyService.instance.getSupportedSymbols { (success) in
            if success {
                if CurrencyService.instance.currencies.count > 0 {
                    print("SUCCESS \(success)")
                } else {
                    print("ERROR fetching symbols")
                }
            }
        }
    }
    
}
