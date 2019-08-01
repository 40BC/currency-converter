//
//  ViewController.swift
//  currency-converter
//
//  Created by Brandon Criss on 7/31/19.
//  Copyright © 2019 Brandon Criss. All rights reserved.
//

import UIKit

class ConverterVC: UIViewController {

    @IBOutlet weak var baseCurrencySymbolLbl: UILabel!
    @IBOutlet weak var targetCurrencySymbolLbl: UILabel!
    @IBOutlet weak var baseCurrencyValueTxt: UITextField!
    @IBOutlet weak var targetCurrencyValueTxt: UITextField!
    @IBOutlet weak var convertedValueLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

