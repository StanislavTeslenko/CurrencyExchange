//
//  ExchangeRate.swift
//  CurrencyExchange
//
//  Created by Stanislav Teslenko on 01.12.2019.
//  Copyright © 2019 Stanislav Teslenko. All rights reserved.
//

import Foundation

struct ExchangeRate: Codable {
    
    let bank: String?
    let baseCurrency: Int?
    let baseCurrencyLit: String?
    let date: String?
    let exchangeRate: [Currency]?
    
    init?(json: Any) {
        
        guard let json = json as? [String : Any] else {return nil}
        
        let bank = json["bank"] as? String
        let baseCurrency = json["baseCurrency"] as? Int
        let baseCurrencyLit = json["baseCurrencyLit"] as? String
        let date = json["date"] as? String
        let exchangeRate = Currency.getArray(from: json["exchangeRate"])
        
        self.bank = bank
        self.baseCurrency = baseCurrency
        self.baseCurrencyLit = baseCurrencyLit
        self.date = date
        self.exchangeRate = exchangeRate
        
    }
    
}

struct Currency: Codable {
    
    let currency: String?
    let saleRateNB: Double?
    let purchaseRateNB: Double?
    let saleRate: Double?
    let purchaseRate: Double?
    
    init?(json: [String: Any]) {
        
        let currency = json["currency"] as? String
        let saleRateNB = json["saleRateNB"] as? Double
        let purchaseRateNB = json["purchaseRateNB"] as? Double
        let saleRate = json["saleRate"] as? Double
        let purchaseRate = json["purchaseRate"] as? Double
        
        self.currency = currency
        self.saleRateNB = saleRateNB
        self.purchaseRateNB = purchaseRateNB
        self.saleRate = saleRate
        self.purchaseRate = purchaseRate
        
    }
    
        static func getArray(from jsonArray: Any?) -> [Currency]? {
    
            guard let jsonArray = jsonArray as? Array<[String: Any]> else {return nil}
            
            var currencyArray: [Currency] = []
            
            for jsonObject in jsonArray {
                if let currency = Currency(json: jsonObject){
                    currencyArray.append(currency)
                }
            }
            
            return currencyArray         
        }
  
}
