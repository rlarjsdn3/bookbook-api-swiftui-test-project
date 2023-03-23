//
//  AladinAPITestApp.swift
//  AladinAPITest
//
//  Created by 김건우 on 2023/03/20.
//

import SwiftUI

@main
struct AladinAPITestApp: App {
    let realmManager = RealmManager.shared
    @StateObject var viewModel = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            if let realm = realmManager.realm {
                MainView()
                    .environment(\.realm, realm)
                    .environmentObject(viewModel)
            } else {
                Text("Error!")
            }
        }
    }
}
