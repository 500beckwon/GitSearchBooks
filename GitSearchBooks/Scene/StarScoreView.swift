//
//  StarScoreView.swift
//  GitSearchBooks
//
//  Created by dev dfcc on 7/1/24.
//

import SwiftUI

struct StarRatingView: View {
    @Binding var rating: Double
    
    private let maxRating: Double = 5
    private let starCount = 5
    private let starSize: CGFloat = 40
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<starCount, id: \.self) { index in
                ZStack {
                    if rating >= Double(index) + 1 {
                        Image(systemName: "star.fill")
                            .resizable()
                            .frame(width: starSize, height: starSize)
                            .foregroundColor(.yellow)
                    } else if rating >= Double(index) + 0.5 {
                        Image(systemName: "star.leadinghalf.filled")
                            .resizable()
                            .frame(width: starSize, height: starSize)
                            .foregroundColor(.yellow)
                    } else {
                        Image(systemName: "star")
                            .resizable()
                            .frame(width: starSize, height: starSize)
                            .foregroundColor(.gray)
                    }
                }
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            let starWidth = starSize + 4  // including spacing
                            let newRating = (value.location.x / starWidth) + Double(index)
                            self.rating = min(max((newRating * 2).rounded() / 2, 0), self.maxRating)
                        }
                        .onEnded { _ in
                            self.rating = min(max((self.rating * 2).rounded() / 2, 0), self.maxRating)
                        }
                )
            }
        }
        .padding()
    }
    
    // Function to set rating value directly
    func setRating(_ newRating: Double) {
        self.rating = min(max((newRating * 2).rounded() / 2, 0), self.maxRating)
        print(self.rating, "asdfasdfasdf")
    }
}

struct ContentView: View {
    @State private var rating: Double = 0
    
    var body: some View {
        VStack {
            StarRatingView(rating: $rating)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.setRating(3.5)
                    }
                }
            Text("Rating: \(rating, specifier: "%.1f")")
                .font(.largeTitle)
        }
        .padding()
    }
    
    func setRating(_ newRating: Double) {
        rating = min(max((newRating * 2).rounded() / 2, 0), 5.0)
    }
}

