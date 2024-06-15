//
//  Book.swift
//  GitSearchBooks
//
//  Created by ByungHoon Ann on 6/10/24.
//

import Foundation

struct Book: Codable, Identifiable {
    let title: String
    let subTitle: String
    let isbnNumber: String
    let price: String
    let image: String
    let storeUrl: String
    
    var id: String {
        return isbnNumber
    }
    
    enum CodingKeys: String, CodingKey {
        case title
        case subTitle = "subtitle"
        case isbnNumber = "isbn13"
        case price
        case image
        case storeUrl = "url"
    }
}

extension Book: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(isbnNumber)
    }
}
