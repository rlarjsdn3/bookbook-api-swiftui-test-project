//
//  DetailView.swift
//  AladinAPITest
//
//  Created by 김건우 on 2023/03/20.
//

import SwiftUI
import Shimmer
import RealmSwift

struct DetailView: View {
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var viewModel: ViewModel
    @ObservedResults(FavoriteBookModel.self) var favoriteBooks
    @Binding var selectedIsbn: String
    
    var body: some View {
        VStack {
            if let bookDetail = viewModel.bookDetail {
                Spacer()
                
                AsyncImage(url: URL(string: bookDetail.item[0].cover)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 200)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                        )
                } placeholder: {
                    ProgressView()
                }
                
                Text(bookDetail.item[0].title)
                    .font(.title)
                    .fontWeight(.bold)
                    .lineLimit(1)
                
                Spacer()
                
                Button {
                    let book = FavoriteBookModel(
                        value: [
                            "title": "\(bookDetail.item[0].title)"
                        ]
                    )
                    $favoriteBooks.append(book)
                    dismiss()
                } label: {
                    Text("추가하기")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .padding(.horizontal)
                        .background {
                            Color.red
                        }
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
            } else {
                Text("Loading...")
                    .redacted(reason: .placeholder)
                    .modifier(Shimmer())
            }
        }
        .onAppear {
            viewModel.requestBookDetailAPI(isbn13: selectedIsbn)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(selectedIsbn: .constant(""))
            .environmentObject(ViewModel())
    }
}
