//
//  BaseEndpoint.swift
//  JustoTechChallenge
//
//  Created by Natalia Goyes on 31/08/22.
//

import Foundation

class BaseEndpoint {
    
    let scheme: String = "https"
    let host: String = "randomuser.me"
    let path: String
    let queryItems: [URLQueryItem]
    let httpMethod: HTTPMethod
    
    init(path: String, queryItems: [URLQueryItem], httpMethod: HTTPMethod) {
        self.path = path
        self.queryItems = queryItems
        self.httpMethod = httpMethod
    }
    
    func getURL() -> URL? {
        
        var components = URLComponents()
        components.scheme = self.scheme
        components.host = self.host
        components.path = self.path
        components.queryItems = self.queryItems
        
       return components.url
    }
}

class RandomUserEndpoint: BaseEndpoint {
    
    init(){
        let path = "/api"
        super.init(path: path, queryItems: [], httpMethod: .GET)
    }
    
}
    