//
//  SearchModel.swift
//  AladinAPITest
//
//  Created by 김건우 on 2023/03/22.
//

import SwiftUI
import Foundation

struct SearchModel: Codable {
    var totalResults: Int // API 결과의 제목
    
    var item: [Item]
    struct Item: Codable, Hashable {
        var title: String?
        var author: String
        var publisher: String
        var pubDate: String
        var cover: String
        var link: String
        var categoryName: String
        var isbn13: String
    }
}

extension SearchModel.Item {
    var mainCategory: String {
        let category = categoryName.split(separator: ">")
        if category.count > 1 {
            return String(category[1])
        }
        return "기타"
    }
    
    var categoryAccentColor: Color {
        switch categoryName.cleaningCategoryName {
        case "어린이":
            return .yellow
        case "수험서/자격증":
            return .blue
        default:
            return .gray
        }
    }
}

extension SearchModel {
    static var preview: SearchModel {
        SearchModel(
            totalResults: 1,
            item: [
                .init(
                    title: "타이틀",
                    author: "저자",
                    publisher: "출판사",
                    pubDate: "1998-03-21",
                    cover: "https://image.aladin.co.kr/product/10917/74/cover/8915104323_1.jpg",
                    link: "링크",
                    categoryName: "카테고리 명>카테고리 명",
                    isbn13: "테스트")
            ]
        )
    }
}
