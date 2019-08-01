//
//  Helpers.swift
//  currency-converter
//
//  Created by Brandon Criss on 8/1/19.
//  Copyright © 2019 Brandon Criss. All rights reserved.
//

import Foundation

func convertCurrencyToDouble(currency: String) -> Double? {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .currency
    numberFormatter.locale = Locale.current
    return numberFormatter.number(from: currency)?.doubleValue
}

func convertDoubleToCurrency(currency: Double) -> String {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .currency
    numberFormatter.locale = Locale.current
    return numberFormatter.string(from: NSNumber(value: currency))!
}
