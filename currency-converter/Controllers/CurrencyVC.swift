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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getSymbols()
        getValues()
    }
    
    func getSymbols() {
        CurrencyService.instance.getSupportedSymbols { (success) in
            if success {
                if CurrencyService.instance.currencies.count > 0 {
//                    self.tableView.reloadData()
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
    
}
