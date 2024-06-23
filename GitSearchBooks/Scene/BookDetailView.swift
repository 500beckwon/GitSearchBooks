//
//  BookDetailView.swift
//  GitSearchBooks
//
//  Created by ByungHoon Ann on 6/22/24.
//

import SwiftUI

struct BookDetailView: View {
    @ObservedObject var viewModel: BookDetailViewModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            AsyncImageView(isbn: viewModel.detailBook.isbnLongNumber)
                .frame(width: 300, height: 300)
                .cornerRadius(10)
            
            Text("Title: \(viewModel.detailBook.title)")
                .font(.body)
            
            Text("Authors: \(viewModel.detailBook.authors)")
                .font(.body)
            
            Text("Description: \(viewModel.detailBook.descripiton)")
                .font(.body)
            
            
            Text("Price: \(viewModel.detailBook.price)")
                .font(.body)
            

            Text("ISBN: \(viewModel.detailBook.isbnLongNumber)")
                .font(.body)
            
            Spacer()
        }
        .padding()
        .navigationBarTitle(viewModel.detailBook.title, displayMode: .inline)
        .alert(isPresented: $viewModel.showAlert) {
            Alert(
                title: Text("상세정보를 불러오는데 실패하였습니다."),
                message: Text(""),
                dismissButton: .default(Text("확인")) {
                    // 화면 뒤로 가기
                    self.presentationMode.wrappedValue.dismiss()
                }
            )
        }
        .onAppear {
        }
    }
    
}
