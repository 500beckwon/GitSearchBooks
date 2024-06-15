//
//  AsyncImageView.swift
//  GitSearchBooks
//
//  Created by ByungHoon Ann on 6/14/24.
//

import SwiftUI

struct AsyncImageView: View {
    @StateObject private var imageLoader = ImageLoader()
    let isbn: String
    
    var body: some View {
        ZStack {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
            } else {
                ProgressView()
                    .onAppear {
                        imageLoader.loadImage(isbn: isbn)
                    }
            }
        }
    }
}
