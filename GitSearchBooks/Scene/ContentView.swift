//
//  ContentView.swift
//  GitSearchBooks
//
//  Created by ByungHoon Ann on 6/10/24.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText: String = ""
    
    var body: some View {
        VStack {
            SearchBar(text: $searchText)
                .padding()
            
            List {
                ForEach(items.filter { $0.contains(searchText) || searchText.isEmpty }, id: \.self) { item in
                    Text(item)
                }
            }
            
            Spacer()
        }
        
        Spacer()
    }
    
    let items = ["Apple", "Banana", "Orange", "Grapes", "Peach"]
}

#Preview {
    ContentView()
}
