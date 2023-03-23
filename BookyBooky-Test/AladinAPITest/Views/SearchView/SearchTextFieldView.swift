//
//  SearchTextFieldView.swift
//  AladinAPITest
//
//  Created by 김건우 on 2023/03/20.
//

import SwiftUI

struct SearchTextFieldView: View {
    @EnvironmentObject var viewModel: ViewModel
    @FocusState var searchIsFocused: Bool
    
    @Binding var text: String
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .font(.title2)
                    .opacity(0.25)
                
                TextField("검색", text: $text)
                    .keyboardType(.default)
                    .onSubmit {
                        viewModel.requestBookSearchAPI(search: text)
                        text = ""
                        searchIsFocused = false
                    }
                    .focused($searchIsFocused)
            }
            .padding(.horizontal)
            .padding(.vertical, 12)
            .background {
                Color.gray.opacity(0.2)
            }
            .cornerRadius(15)
            
            Button {
                viewModel.requestBookSearchAPI(search: text)
                text = ""
                searchIsFocused = false
            } label: {
                Text("검색")
            }
            .padding(.leading, 8)
        }
        .padding()
    }
}

struct SearchTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        SearchTextFieldView(text: .constant(""))
            .environmentObject(ViewModel())
    }
}
