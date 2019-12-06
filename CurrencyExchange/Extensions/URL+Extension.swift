//
//  URL+Extension.swift
//  JSON Practice
//
//  Created by Stanislav Teslenko on 7/6/19.
//  Copyright © 2019 Stanislav Teslenko. All rights reserved.
//

import Foundation


extension URL {
    
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents (url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.map { URLQueryItem(name: $0.key, value: $0.value)}
        return components?.url
    }
    
    
    
}
