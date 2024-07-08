//
//  BookImageRequest.swift
//  GitSearchBooks
//
//  Created by ByungHoon Ann on 6/13/24.
//

import Combine
import Foundation
import UIKit

final class BookImageRequest {
    static func requestBookImage(isbn: String, completion: @escaping((Result<Data, Error>) -> Void)) {
        NetworkRequest<Data>(apiRequest: BookImageAPI.imageDownload(isbn: isbn))
            .requestImage(completion: completion)
        
        
    }
    
    static func requestBookImage(isbn: String) -> AnyPublisher<Data?, Error> {
        return NetworkRequest(apiRequest: BookImageAPI.imageDownload(isbn: isbn))
            .requestImage()
    }
}
