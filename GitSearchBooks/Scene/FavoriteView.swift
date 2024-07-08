//
//  FavoriteView.swift
//  GitSearchBooks
//
//  Created by dev dfcc on 7/1/24.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var viewModel: FavoriteViewModel
    
    var body: some View {
        List(viewModel.favoriteBooks) { item in
            NavigationLink(destination: BookDetailView(viewModel: BookDetailViewModel(isbn: item.isbnNumber))) {
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
                    
                    Spacer()
                    
                    Button(action: {
                        viewModel.toggleFavorite(book: item)
                    }) {
                        Image(systemName: viewModel.isFavorite(book: item) ? "star.fill" : "star")
                            .foregroundColor(viewModel.isFavorite(book: item) ? .yellow : .gray)
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
            }
        }
        .navigationBarTitle("Favorites")
        .onAppear {
            viewModel.loadFavorites()
        }
    }
}
