//
//  MainHeaderView.swift
//  AladinAPITest
//
//  Created by 김건우 on 2023/03/20.
//

import SwiftUI

struct MainHeaderView: View {
    @State private var showSearchSheet: Bool = false
    
    var body: some View {
        HStack {
            Menu {
                Button {
                    
                } label: {
                    Label("직접 추가", systemImage: "square.and.pencil")
                }
                
                Button {
                    showSearchSheet = true
                } label: {
                    Label("검색 추가", systemImage: "magnifyingglass")
                }
            } label: {
                Image(systemName: "plus")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
            }

            Spacer()
            
            Image("김지지")
                .resizable()
                .scaledToFill()
                .frame(width: 45, height: 45)
                .cornerRadius(15)
        }
        .padding()
        .sheet(isPresented: $showSearchSheet) {
            SearchView()
        }
    }
}

struct MainHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        MainHeaderView()
    }
}
