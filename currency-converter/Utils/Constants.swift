//
//  Constants.swift
//  currency-converter
//
//  Created by Brandon Criss on 7/31/19.
//  Copyright © 2019 Brandon Criss. All rights reserved.
//

import Foundation

// makes type CompletionHandler type Success which is a bool
typealias CompletionHandler = (_ Success: Bool) -> ()

let API_KEY = "13da4b4211c21e05ae3588c821918926"
let API_URL = "http://data.fixer.io/api"
let SYMBOLS_URL = "\(API_URL)/symbols?access_key=\(API_KEY)"
let LASTEST_URL = "\(API_URL)/latest?access_key=\(API_KEY)"
let CONVERT_URL = "\(API_URL)/convert?access_key=\(API_KEY)"

var BASE_CURRENCY_NAME = "Euro"
var BASE_CURRENCY = "EUR"
var BASE_VALUE = 1.00
