//
//  StringExtension.swift
//  AladinAPITest
//
//  Created by 김건우 on 2023/03/20.
//

import Foundation

extension String {
    var cleaningAuthors: String {
//        let authors = self.split(separator: "^").map { String($0) }
//        if authors.count > 1 {
//            return "\(authors[0]) 외 \(authors.count - 1)명 저자(글)"
//        }
        return "\(self)"
    }
    
    var cleaningCategoryName: String {
        let category = self.split(separator: ">")
        if category.count > 1 {
            return String(category[1])
        } else {
            return "기타"
        }
    }
    
    var cleaningPubDate: Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: self)!
    }
}
