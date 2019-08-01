//
//  CurrencyVC.swift
//  currency-converter
//
//  Created by Brandon Criss on 7/31/19.
//  Copyright © 2019 Brandon Criss. All rights reserved.
//

import UIKit

class CurrencyVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var baseCurrencyButton: RoundedButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.isHidden = true

        baseCurrencyButton.isEnabled = false
        baseCurrencyButton.setTitle("\(BASE_CURRENCY_NAME): \(BASE_CURRENCY)", for: .normal)
        baseCurrencyButton.isEnabled = true

        getValues()
    }
    
    func getSymbols() {
        CurrencyService.instance.getSupportedSymbols { (success) in
            if success {
                if CurrencyService.instance.symbols.count > 0 {
                    if self.pickerView.isHidden {
                        self.pickerView.isHidden = false
                        self.pickerView.reloadAllComponents()
                    } else {
                        self.pickerView.isHidden = true
                    }
                } else {
                    print("ERROR fetching symbols")
                }
            }
        }
    }
    
    func getValues() {
        CurrencyService.instance.getLatestCurrencyValues(completion: { (success) in
            if success {
                self.tableView.reloadData()
            }
        })
    }
    
    func setBaseCurrency(base: Symbol) {
        BASE_CURRENCY_NAME = base.name
        BASE_CURRENCY = base.symbol
        
        baseCurrencyButton.isEnabled = false
        baseCurrencyButton.setTitle("\(BASE_CURRENCY_NAME): \(BASE_CURRENCY)", for: .normal)
        baseCurrencyButton.isEnabled = true
        
        getValues()
    }
    
    @IBAction func showPickerView(_ sender: Any) {
        getSymbols()
    }
    
}

extension CurrencyVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CurrencyService.instance.currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "currencyCell") as? CurrencyCell else {
            return UITableViewCell()
        }
        let currency = CurrencyService.instance.currencies[indexPath.row]
        
        cell.configureCell(currency: currency)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.none
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currency = CurrencyService.instance.currencies[indexPath.row]
        CurrencyService.instance.selectedCurrency = currency
        
        guard let converterVC = storyboard?.instantiateViewController(withIdentifier: "ConverterVC") as? ConverterVC else { return }
        converterVC.initData(symbol: currency.symbol, value: currency.value)
        
        present(converterVC, animated: true, completion: nil)
    }
    
}

extension CurrencyVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return CurrencyService.instance.symbols.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let symbol = CurrencyService.instance.symbols[row]
        return NSAttributedString(string: "\(symbol.name ?? BASE_CURRENCY_NAME): \(symbol.symbol ?? BASE_CURRENCY)", attributes: [NSAttributedString.Key.font: UIFont(name: "Helvetica Neue", size: 20.0)!])
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let symbol = CurrencyService.instance.symbols[row]
        setBaseCurrency(base: symbol)
    }
}
