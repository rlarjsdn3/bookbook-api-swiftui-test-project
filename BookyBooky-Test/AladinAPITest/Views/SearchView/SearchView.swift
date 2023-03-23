//
//  SearchView.swift
//  AladinAPITest
//
//  Created by 김건우 on 2023/03/20.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    @State private var selectedIsbn: String = ""
    @State private var text = ""
    
    var body: some View {
        ZStack {
            if selectedIsbn.isEmpty {
                VStack {
                    SearchTextFieldView(text: $text)
                    
                    Spacer()
                    
                    ZStack {
                        if let bookSearch = viewModel.bookSearch {
                            if !bookSearch.item.isEmpty {
                                ScrollView(showsIndicators: false) {
                                    ForEach(bookSearch.item, id: \.self) { item in
                                        SearchCellView(item: item)
                                            .onTapGesture {
                                                selectedIsbn = item.isbn13
                                            }
                                    }
                                }
                            }
                        } else {
                            VStack {
                                Spacer()
                                Label("검색 결과가 없습니다.", systemImage: "xmark.circle")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.gray)
                                Spacer()
                            }
                        }
                    }
                }
                .interactiveDismissDisabled(!text.isEmpty)
            } else {
                DetailView(selectedIsbn: $selectedIsbn)
            }
        }
        .onDisappear {
            viewModel.bookSearch = nil
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .environmentObject(ViewModel())
    }
}
