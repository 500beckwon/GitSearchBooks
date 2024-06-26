//
//  URLSessionProtocol.swift
//  GitSearchBooks
//
//  Created by ByungHoon Ann on 6/13/24.
//

import Foundation

protocol URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping((Data?, URLResponse?, Error?) -> Void)) -> URLSessionDataTaskProtocol
}

extension URLSession: URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping ((Data?, URLResponse?, Error?) -> Void)) -> URLSessionDataTaskProtocol {
        return dataTask(with: url, completionHandler: completionHandler) as URLSessionDataTask
    }
}
