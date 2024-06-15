//
//  BookImage.swift
//  GitSearchBooks
//
//  Created by ByungHoon Ann on 6/13/24.
//

import Foundation

enum BookImageAPI {
    case imageDownload(isbn: String)
}

extension BookImageAPI: APIRequest {
    var urlString: String {
        return Define.bookImageURL
    }
    
    var baseURL: URL {
        guard
            let url = URL(string: urlString)
        else {
            fatalError("\(URLError.badURL)")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .imageDownload(let isbn):
            return "/\(isbn).png"
        }
    }
}

