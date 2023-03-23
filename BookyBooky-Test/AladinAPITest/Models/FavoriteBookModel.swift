//
//  FavoriteBookRealmModel.swift
//  AladinAPITest
//
//  Created by 김건우 on 2023/03/20.
//

import Foundation
import RealmSwift

class FavoriteBookModel: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var title: String
}
