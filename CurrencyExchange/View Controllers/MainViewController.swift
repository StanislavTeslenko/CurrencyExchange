//
//  MainViewController.swift
//  CurrencyExchange
//
//  Created by Stanislav Teslenko on 05.12.2019.
//  Copyright © 2019 Stanislav Teslenko. All rights reserved.
//

import UIKit


class MainViewController: UIViewController {
    
    let currentDate = Date()
    
    private var embeddedPBViewController: PBViewController!
    private var embeddedNBViewController: NBViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        sendRequest(with: currentDate)
        
        
    }

}

extension MainViewController: DatePickerViewControllerDelegate {
    
    func sendRequest(with date: Date) {
        
        self.embeddedPBViewController.pBCurrencyList = []
        self.embeddedPBViewController.tableView.reloadData()
        self.embeddedPBViewController.activityIndicator.isHidden = false
        
        self.embeddedNBViewController.nBCurrencyList = []
        self.embeddedNBViewController.tableView.reloadData()
        self.embeddedNBViewController.activityIndicator.isHidden = false

        NetworkManager.sendRequest(date: date) {(currencyPB, currencyNBU) in
            
            self.embeddedPBViewController.pBCurrencyList = currencyPB
            self.embeddedPBViewController.nBCurrencyList = currencyNBU
            self.embeddedPBViewController.delegate = self.embeddedNBViewController
            self.embeddedPBViewController.tableView.setContentOffset(.zero, animated: true)
            self.embeddedPBViewController.tableView.reloadData()
            self.embeddedPBViewController.activityIndicator.isHidden = true
            
            self.embeddedNBViewController.pBCurrencyList = currencyPB
            self.embeddedNBViewController.nBCurrencyList = currencyNBU
            self.embeddedNBViewController.delegate = self.embeddedPBViewController
            self.embeddedNBViewController.tableView.setContentOffset(.zero, animated: true)
            self.embeddedNBViewController.tableView.reloadData()
            self.embeddedNBViewController.activityIndicator.isHidden = true

        }
        
        
    }
  
}


extension MainViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "PBViewControllerSegue" {
            
            let destinationViewController = segue.destination as? PBViewController
            self.embeddedPBViewController = destinationViewController
        }
        
        if segue.identifier == "NBViewControllerSegue" {
            
            let destinationViewController = segue.destination as? NBViewController
            self.embeddedNBViewController = destinationViewController
        }
        
        
    }
    
    
    
}


 
