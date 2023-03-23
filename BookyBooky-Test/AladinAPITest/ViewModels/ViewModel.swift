//
//  ViewModel.swift
//  AladinAPITest
//
//  Created by 김건우 on 2023/03/20.
//

import Foundation
import Alamofire

class ViewModel: ObservableObject {
    @Published var bookSearch: SearchModel?
    @Published var bookDetail: BookDetailModel?
    
    // 책 검색 API 호출 (네이버 검색 API)
//    func requestBookSearchAPI(search query: String) {
//        let baseURL = "https://openapi.naver.com/v1/search/book.json"
//
//        let headers: HTTPHeaders = [
//            "X-Naver-Client-Id": NaverAPI.clientID,
//            "X-Naver-Client-Secret": NaverAPI.clientSecret
//        ]
//
//        let parameters: Parameters = [
//            "query": query,
//            "display": 100,
//            "sort": "sim",
//        ]
//
//        AF.request(
//            baseURL,
//            method: .get,
//            parameters: parameters,
//            encoding: URLEncoding.default,
//            headers: headers
//        )
//        .validate(statusCode: 200...500)
//        .responseDecodable(of: BookSearchModel.self) { response in
//            switch response.result {
//            case .success(let data):
//                guard let statusCode = response.response?.statusCode else { return }
//                if statusCode == 200 {
//                    DispatchQueue.main.async {
//                        self.bookSearch = data
//                        print(data)
//                    }
//                }
//            case .failure(let error):
//                print("네이버 검색 API 호출 실패: \(error)")
//            }
//        }
//    }
//
    func requestBookSearchAPI(search query: String) {
        let baseURL = "http://www.aladin.co.kr/ttb/api/ItemSearch.aspx?ttbkey=\(AladinAPI.TTBKey)&Query=\(euckrEncoding(query))&InputEncoding=euc-kr&QueryType=Title&Cover=BIG&MaxResults=100&start=1&SearchTarget=Book&output=js&Version=20131101"

        AF.request(
            baseURL,
            method: .get,
            parameters: nil,
            encoding: URLEncoding.default,
            headers: nil
        )
        .validate(statusCode: 200...500)
        .responseDecodable(of: SearchModel.self) { response in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else { return }
                if statusCode == 200 {
                    DispatchQueue.main.async {
                        self.bookSearch = data
                        print(data)
                    }
                }
            case .failure(let error):
                print("알라딘 검색 API 호출 실패: \(error)")
            }
        }
    }
    
    // 책 디테일 API 호출 (알라딘 상품 API)
    func requestBookDetailAPI(isbn13 isbn: String) {
        // 커버까지 가져오도록 URL 수정하기
        let baseURL = "http://www.aladin.co.kr/ttb/api/ItemLookUp.aspx?ttbkey=\(AladinAPI.TTBKey)&itemIdType=ISBN&Cover=BIG&ItemId=\(isbn)&output=js&Version=20131101"
        
        AF.request(
            baseURL,
            method: .get,
            parameters: nil,
            encoding: URLEncoding.default,
            headers: nil
        )
        .responseDecodable(of: BookDetailModel.self) { response in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else { return }
                if statusCode == 200 {
                    DispatchQueue.main.async {
                        self.bookDetail = data
                        print(data)
                    }
                }
            case .failure(let error):
                print("알라딘 상품 API 호출 실패: \(error)")
            }
        }
    }
    
    func euckrEncoding(_ query: String) -> String { //EUC-KR 인코딩
        let rawEncoding = CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(CFStringEncodings.EUC_KR.rawValue))
        let encoding = String.Encoding(rawValue: rawEncoding)

        let eucKRStringData = query.data(using: encoding) ?? Data()
        let outputQuery = eucKRStringData.map {byte->String in
            if byte >= UInt8(ascii: "A") && byte <= UInt8(ascii: "Z")
                || byte >= UInt8(ascii: "a") && byte <= UInt8(ascii: "z")
                || byte >= UInt8(ascii: "0") && byte <= UInt8(ascii: "9")
                || byte == UInt8(ascii: "_") || byte == UInt8(ascii: ".") || byte == UInt8(ascii: "-")
            {
                return String(Character(UnicodeScalar(UInt32(byte))!))
            } else if byte == UInt8(ascii: " ") {
                return "+"
            } else {
                return String(format: "%%%02X", byte)
            }
            }.joined()

        return outputQuery
    }
}
