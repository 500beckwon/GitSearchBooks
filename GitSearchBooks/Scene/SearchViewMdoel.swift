//
//  SearchViewMdoel.swift
//  GitSearchBooks
//
//  Created by ByungHoon Ann on 6/14/24.
//

import Combine
import UIKit

final class ViewModel: ObservableObject {
    @Published var bookList: BookList = {
        return BookList(total: "", page: "1", books: [])
    }()
    
    @Published var searchText: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    var currentPage = 1
    var canMoreLoad = false
    
    init() {
        $searchText.sink { [weak self] searchText in
            guard let self = self else { return }
            self.fetchData(page: currentPage, searchText: searchText)
        }.store(in: &cancellables)
    }
    
    var filteredItems: [Book] {
        if searchText.isEmpty {
            return []
        } else {
            return bookList.books
        }
    }
    
    func makeSearchInfo(page: Int = 1, searchText: String) -> SearchInformation {
        return SearchInformation(page: page, searchText: searchText)
    }
    
    func fetchData(page: Int, searchText: String) {
        currentPage = 1
        let searchInfo = makeSearchInfo(page: page, searchText: searchText)
        BookListRequest.requestSearchBook(searchInfo: searchInfo) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let bookList):
                    self.bookList = bookList
                    self.canMoreLoad = true
                case .failure:
                    self.bookList = BookList(total: "", page: "", books: [])
                }
            }
        }
    }
    
    func loadMoreData() {
        guard canMoreLoad == true else { return }
        
        currentPage += 1
        let searchInfo = makeSearchInfo(page: currentPage, searchText: searchText)
        
        BookListRequest.requestSearchBook(searchInfo: searchInfo) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let bookList):
                    if bookList.books.isEmpty {
                        self.canMoreLoad = false
                    } else {
                        self.bookList.books.append(contentsOf: bookList.books)
                    }
                case .failure:
                    self.canMoreLoad = false
                }
            }
        }
    }
}
