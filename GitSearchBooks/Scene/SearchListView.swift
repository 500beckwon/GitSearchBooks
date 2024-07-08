//
//  SearchListView.swift
//  GitSearchBooks
//
//  Created by ByungHoon Ann on 6/10/24.
//

import SwiftUI

struct SearchListView: View {
    @State private var searchText: String = ""
    @StateObject private var viewModel = ViewModel()
    @StateObject private var favoriteviewModel = FavoriteViewModel()
       
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $viewModel.searchText)
                
                List(viewModel.filteredItems) { item in
                    NavigationLink(destination: BookDetailView(isbn: item.isbnNumber)) {
                        HStack {
                            AsyncImageView(isbn: item.isbnNumber)
                                .clipped()
                                .frame(width: 100, height: 100)
                                .cornerRadius(8)
                            
                            VStack(alignment: .leading) {
                                Text(item.title)
                                    .font(.system(size: 15, weight: .bold))
                                
                                Text(item.subTitle)
                                    .font(.system(size: 12))
                                    .padding(.top, 5)
                            }
                            
                            Button(action: {
                                favoriteviewModel.toggleFavorite(book: item)
                            }) {
                                Image(systemName: favoriteviewModel.isFavorite(book: item) ? "star.fill" : "star")
                                    .foregroundColor(favoriteviewModel.isFavorite(book: item) ? .yellow : .gray)
                            }
                            .buttonStyle(BorderlessButtonStyle()) // List 내에서 Button 클릭을 위해 추가
                            
                        }.onAppear {
                            if viewModel.filteredItems.last == item {
                                viewModel.loadMoreData()
                            }
                        }
                    }
                }
                Spacer()
            }
            .navigationBarTitle("iBookSearch")
            .navigationBarItems(trailing: NavigationLink(destination: FavoritesView(viewModel: favoriteviewModel)) {
                Text("Favorites")
            })
        }
    }
}
