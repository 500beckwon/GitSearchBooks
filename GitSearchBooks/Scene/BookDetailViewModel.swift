//
//  BookDetailViewModel.swift
//  GitSearchBooks
//
//  Created by ByungHoon Ann on 6/22/24.
//

import Combine
import UIKit
import SwiftUI

final class BookDetailViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    @Published var detailBook = DetailBook.emptyDetailBook
    @Published var isbn: String
    @Published var showAlert = false

    init(isbn: String) {
        self.isbn = isbn
    }
    
    func fetchData() {
        BookListRequest.requestDetailBook(isbn: isbn) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let book):
                    self.detailBook = book
                case .failure(let error):
                    print(error.localizedDescription)
                    self.showAlert = true
                }
            }
        }
    }
}
