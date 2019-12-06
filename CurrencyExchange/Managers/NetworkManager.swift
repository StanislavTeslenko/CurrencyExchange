//
//  NetworkManager.swift
//  CurrencyExchange
//
//  Created by Stanislav Teslenko on 01.12.2019.
//  Copyright © 2019 Stanislav Teslenko. All rights reserved.
//

import Foundation
import Alamofire

// example URL: https://api.privatbank.ua/p24api/exchange_rates?json&date=01.12.2019

private let baseUrl = URL(string: "https://api.privatbank.ua/p24api/exchange_rates")!

class NetworkManager {
    
    static func sendRequest(date: Date, completion: @escaping (_ currencyPB: [Currency], _ currencyNBU: [Currency]) -> () ) {
        
        let stringDate = formattedDate(from: date)
        
        let parameters = ["json" : "","date" : stringDate]
        
        guard let url = baseUrl.withQueries(parameters) else {
            print (#line, #function, "Error creating URL from \(baseUrl.absoluteString) with \(parameters)")
            return
        }
        
        //        print("URL - \(url.absoluteString)")
        
        AF.request(url).validate().responseJSON { (response) in
            
            switch response.result {
                
            case .success(let json):
                
                guard let exchange = ExchangeRate(json: json) else {
                    completion([], [])
                    return}
                
                let currencyPB = filterCurrencyPB(currencyArray: exchange.exchangeRate)
                let currencyNBU = filterCurrencyNB(currencyArray: exchange.exchangeRate)
                
                completion(currencyPB, currencyNBU)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    fileprivate static func filterCurrencyPB(currencyArray: [Currency]?) -> [Currency] {
        
        guard let currencyArray = currencyArray else {return []}
        
        var filteredArray: [Currency] = []
        
        for currency in currencyArray {
            if currency.purchaseRate != nil && currency.saleRate != nil && currency.currency != nil {
                filteredArray.append(currency)
            }
        }
        filteredArray.sort {$0.currency! < $1.currency!}
        
        return filteredArray
    }
    
    fileprivate static func filterCurrencyNB(currencyArray: [Currency]?) -> [Currency] {
        
        guard let currencyArray = currencyArray else {return []}
        
        var filteredArray: [Currency] = []
        
        for currency in currencyArray {
            if currency.purchaseRateNB != nil && currency.saleRateNB != nil && currency.currency != nil {
                filteredArray.append(currency)
            }
        }
        filteredArray.sort {$0.currency! < $1.currency!}
        
        return filteredArray
    }
    
    fileprivate static func formattedDate(from date: Date) -> String {
        
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        formatter.dateFormat = "dd.MM.yyyy"
        
        return formatter.string(from: date)
    }
    
}


