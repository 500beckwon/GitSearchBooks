//
//  NetworkError.swift
//  GitSearchBooks
//
//  Created by ByungHoon Ann on 6/10/24.
//

import Foundation

enum NetworkError: Error {
    case emptyData
    case decodingError
    case badURL
    case inValidError
}
