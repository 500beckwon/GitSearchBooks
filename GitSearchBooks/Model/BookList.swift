//
//  BookList.swift
//  GitSearchBooks
//
//  Created by ByungHoon Ann on 6/10/24.
//

import Foundation

struct BookList: Codable {
    let total: String
    let page: String?
    var books: [Book]
}
