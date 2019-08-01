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
    
    var currencySymbol: String!
    var currencyValue: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer(target: self, action: #selector(ConverterVC.handleTap))
        view.addGestureRecognizer(tap)
        
        setupView()
    }
    
    func initData(symbol: String, value: String) {
        self.currencySymbol = symbol
        self.currencyValue = value
    }
    
    func setupView() {
        baseCurrencySymbolLbl.text = BASE_CURRENCY
        baseCurrencyValueTxt.text = convertDoubleToCurrency(currency: BASE_VALUE)
        
        targetCurrencySymbolLbl.text = currencySymbol
        targetCurrencyValueTxt.text = currencyValue
    }
    
    func convertCurrency() {
        guard let amount = baseCurrencyValueTxt.text else { return }
        let sanitizedAmount = amount.replacingOccurrences(of: "$", with: "")
        CurrencyService.instance.getConversion(targetCurrency: currencySymbol, amount: sanitizedAmount) { (success) in
            if success {
                self.targetCurrencyValueTxt.text = CurrencyService.instance.convertedValue
            } else {
                print("Conversion failed")
            }
        }
    }
    
    @IBAction func selectCurrency(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func convert(_ sender: Any) {
        view.endEditing(true)
        convertCurrency()
    }
    
    
}


extension ConverterVC:  UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    @objc func handleTap(){
        view.endEditing(true)
        convertCurrency()
    }
}

