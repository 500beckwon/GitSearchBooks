//
//  URLSessionDataTaskProtocol.swift
//  GitSearchBooks
//
//  Created by ByungHoon Ann on 6/13/24.
//

import Foundation

protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol { }
