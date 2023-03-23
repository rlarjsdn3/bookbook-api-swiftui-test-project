//
//  ContentView.swift
//  AladinAPITest
//
//  Created by 김건우 on 2023/03/20.
//

import SwiftUI
import RealmSwift

struct MainView: View {
    @Environment(\.realm) var realm: Realm
    
    @EnvironmentObject var viewModel: ViewModel
    @ObservedResults(FavoriteBookModel.self) var favoriteBooks
    
    var body: some View {
        VStack {
            MainHeaderView()
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    Text("Favorite Book")
                        .font(.largeTitle)
                        .fontWeight(.black)
                    
                    Text("Books are queitest and most constant of friends")
                        .font(.subheadline)
                        .fontWeight(.thin)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                
                ForEach(favoriteBooks) { favoriteBook in
                    Text(favoriteBook.title)
                        .font(.headline)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background {
                            Color.gray.opacity(0.5)
                        }
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
            }
        }
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(ViewModel())
            .environment(\.realm, RealmManager.openLocalRealm()!)
    }
}
