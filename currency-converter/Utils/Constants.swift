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

let API_KEY = "62b8e6f43ad8aec8c1e3edc86e60dec9"
let API_URL = "http://data.fixer.io/api"
let SYMBOLS_URL = "/symbols"
let LASTEST_URL = "/latest"
let CONVERT_URL = "/convert"

let DEFAULT_CURRENCY = "EUR"
