//
//  APIRequest.swift
//  GitSearchBooks
//
//  Created by ByungHoon Ann on 6/10/24.
//

import Foundation

protocol APIRequest {
    var urlString: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String : String]? { get }
    var headers: [String: String]? { get }
    var httpBody: Data? { get }
}

extension APIRequest {
    var urlString: String {
        return Define.baseURL
    }

    var method: HTTPMethod {
        return .get
    }
    
    var parameters: [String : String]? {
        return nil
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
    
    var httpBody: Data? {
        return nil
    }
}
