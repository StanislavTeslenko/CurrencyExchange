//
//  PBViewController.swift
//  CurrencyExchange
//
//  Created by Stanislav Teslenko on 01.12.2019.
//  Copyright © 2019 Stanislav Teslenko. All rights reserved.
//

import UIKit

protocol PBViewControllerDelegate: class {
    func selectRow(at indexPath: IndexPath?)
}

class PBViewController: UIViewController {
    
    var pBCurrencyList: [Currency] = []
    var nBCurrencyList: [Currency] = []
    weak var delegate: PBViewControllerDelegate?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")

        tableView.tableFooterView = UIView()
        
        
     
    }
    
    func dataPrint() {
        
        print(pBCurrencyList)
        
    }

}

extension PBViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pBCurrencyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        cell.purchaseRateLabel.text = "\(pBCurrencyList[indexPath.row].purchaseRate!)"
        cell.saleRateLabel.text = "\(pBCurrencyList[indexPath.row].saleRate!)"
        cell.currencyLabel.text = pBCurrencyList[indexPath.row].currency
        
        return cell
        
    }
  
    
}

extension PBViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let indexPath = findRow(pBCurrency: pBCurrencyList, nBCurrency: nBCurrencyList, at: indexPath)
    
        delegate?.selectRow(at: indexPath)
     
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let degree: Double = 90
        let rotationAngle = CGFloat(degree * .pi / 180)
        let rotationTransform = CATransform3DMakeRotation(rotationAngle, 1, 0, 0)
        cell.layer.transform = rotationTransform
        
        UIView.animate(withDuration: 0.5, delay: 0.1 * Double(indexPath.row), options: .curveEaseInOut, animations: {
            cell.layer.transform = CATransform3DIdentity
        })
    }
    
}

extension PBViewController: NBViewControllerDelegate {
    
    func selectRow(at indexPath: IndexPath?) {
        
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .middle)
    }
    
}

extension PBViewController {
    
    func findRow(pBCurrency: [Currency], nBCurrency: [Currency], at indexPath: IndexPath) -> IndexPath? {
        
        let currency = nBCurrency.filter {$0.currency == pBCurrency[indexPath.row].currency}.first
        
        let index = nBCurrency.firstIndex {$0.currency == currency?.currency}
        
        if index != nil {
        let indexPath = IndexPath(row: index!, section: 0)
            return indexPath
        } else {
            return nil
        }
    
    }
   
}

