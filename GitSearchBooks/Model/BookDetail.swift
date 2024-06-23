//
//  BookDetail.swift
//  GitSearchBooks
//
//  Created by ByungHoon Ann on 6/10/24.
//

import Foundation

struct DetailBook: Codable {
    let error: String
    let title: String
    let subtitle: String
    let authors: String
    let publisher: String
    let language: String?
    let isbnShotNumber: String
    let isbnLongNumber: String
    let pages: String
    let year: String
    let rating: String
    let descripiton: String
    let price: String
    let imageURL: String
    let storeURL: String
    let pdfInfo: PDFInfo?
    
    enum CodingKeys: String, CodingKey {
        case error
        case title
        case subtitle
        case authors
        case publisher
        case language
        case isbnShotNumber = "isbn10"
        case isbnLongNumber = "isbn13"
        case pages
        case year
        case rating
        case descripiton = "desc"
        case price
        case imageURL = "image"
        case storeURL = "url"
        case pdfInfo = "pdf"
    }
    
    static let emptyDetailBook = DetailBook(
        error: "",
        title: "",
        subtitle: "",
        authors: "",
        publisher: "",
        language: "",
        isbnShotNumber: "",
        isbnLongNumber: "",
        pages: "",
        year: "",
        rating: "",
        descripiton: "",
        price: "",
        imageURL: "",
        storeURL: "",
        pdfInfo: nil
    )
    
}

struct PDFInfo: Codable {
    let eBook: String?

    enum CodingKeys: String, CodingKey {
        case eBook = "Free eBook"
    }
}
