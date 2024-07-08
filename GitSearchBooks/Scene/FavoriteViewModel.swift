//
//  FavoriteViewModel.swift
//  GitSearchBooks
//
//  Created by dev dfcc on 7/1/24.
//

import Combine
import SwiftUI

class FavoriteViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var items: [Book] = []
    @Published private(set) var favorites: Set<String> = [] {
        didSet {
            saveFavorites()
        }
    }
    
    private let favoritesKey = "favorites"

    init() {
        loadFavorites()
        loadItems()
    }
    
    var filteredItems: [Book] {
        if searchText.isEmpty {
            return items
        } else {
            return items.filter { $0.title.contains(searchText) || $0.subTitle.contains(searchText) }
        }
    }
    
    func loadMoreData() {
        
    }
    
    func toggleFavorite(book: Book) {
        if favorites.contains(book.isbnNumber) {
            favorites.remove(book.isbnNumber)
        } else {
            favorites.insert(book.isbnNumber)
        }
    }
    
    func isFavorite(book: Book) -> Bool {
        return favorites.contains(book.isbnNumber)
    }
    
    var favoriteBooks: [Book] {
        return items.filter { favorites.contains($0.isbnNumber) }
    }
    
    private func saveFavorites() {
        let favoritesArray = Array(favorites)
        UserDefaults.standard.set(favoritesArray, forKey: favoritesKey)
    }
    
    func loadFavorites() {
        if let favoritesArray = UserDefaults.standard.array(forKey: favoritesKey) as? [String] {
            favorites = Set(favoritesArray)
        } else {
            favorites = []
        }
    }
    
    private func loadItems() {
       
    }
}
