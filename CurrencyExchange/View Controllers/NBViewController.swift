//
//  NBViewController.swift
//  CurrencyExchange
//
//  Created by Stanislav Teslenko on 01.12.2019.
//  Copyright © 2019 Stanislav Teslenko. All rights reserved.
//

import UIKit

protocol NBViewControllerDelegate: class {
    func selectRow(at indexPath: IndexPath?)
}


class NBViewController: UIViewController {
    
    var pBCurrencyList: [Currency] = []
    var nBCurrencyList: [Currency] = []
    weak var delegate: NBViewControllerDelegate?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        tableView.tableFooterView = UIView()
        
    }
    
    
}

extension NBViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nBCurrencyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        cell.purchaseRateLabel.text = "\(nBCurrencyList[indexPath.row].purchaseRateNB!)"
        cell.saleRateLabel.text = "\(nBCurrencyList[indexPath.row].saleRateNB!)"
        cell.currencyLabel.text = nBCurrencyList[indexPath.row].currency
        
        return cell
        
    }
    
    
    
    
}

extension NBViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let indexPath = findRow(pBCurrency: pBCurrencyList, nBCurrency: nBCurrencyList, at: indexPath)
       
        delegate?.selectRow(at: indexPath)
     
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let degree: Double = 90
        let rotationAngle = CGFloat(degree * .pi / 180)
        let rotationTransform = CATransform3DMakeRotation(rotationAngle, 1, 0, 0)
        cell.layer.transform = rotationTransform
        
        UIView.animate(withDuration: 0.4, delay: 0.01 * Double(indexPath.row), options: .curveEaseInOut, animations: {
            cell.layer.transform = CATransform3DIdentity
        })
    }
    
}

extension NBViewController: PBViewControllerDelegate {
    
    func selectRow(at indexPath: IndexPath?) {
        
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .middle)
    }
    
}

extension NBViewController {
    
    func findRow(pBCurrency: [Currency], nBCurrency: [Currency], at indexPath: IndexPath) -> IndexPath? {
        
        let currency = pBCurrency.filter {$0.currency == nBCurrency[indexPath.row].currency}.first
        
        let index = pBCurrency.firstIndex {$0.currency == currency?.currency}
        
        if index != nil {
        let indexPath = IndexPath(row: index!, section: 0)
            return indexPath
        } else {
            return nil
        }
    
    }
   
}



