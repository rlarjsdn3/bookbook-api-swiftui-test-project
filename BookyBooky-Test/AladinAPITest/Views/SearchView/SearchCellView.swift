//
//  SearchCellView.swift
//  AladinAPITest
//
//  Created by 김건우 on 2023/03/20.
//

import SwiftUI
import Shimmer

struct SearchCellView: View {
    var item: SearchModel.Item
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                asyncImage(url: item.cover, proxy: geometry)
                bookInfo(item: item, proxy: geometry)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(height: 200)
    }
    
    @ViewBuilder
    func asyncImage(url: String, proxy geometry: GeometryProxy) -> some View {
            AsyncImage(url: URL(string: item.cover)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width: geometry.size.width / 3,
                        height: geometry.size.height
                    )
                    .mask {
                        CoverShape()
                    }
            } placeholder: {
                CoverShape()
                    .fill(.white)
                    .frame(
                        width: geometry.size.width / 3,
                        height: geometry.size.height
                    )
            }
            .padding(.leading, -16)
            .padding()
    }
    
    @ViewBuilder
    func bookInfo(item: SearchModel.Item, proxy geometry: GeometryProxy) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.title ?? "placeholder-title")
                    .font(.title2)
                    .fontWeight(.bold)
                    .lineLimit(1)
                    .padding(.bottom, 1)
                
                // 모든 셀에 Shimmering Animation 적용하기
                
                Text(item.author.cleaningAuthors)
                    .font(.headline)
                    .foregroundColor(.gray)
                    .padding(.bottom, 0)
                
                HStack(spacing: 0) {
                    Text(item.publisher + " ・ ")
                    
                    Text(item.mainCategory)
                }
                .font(.subheadline)
                .foregroundColor(.gray)
                
                Spacer()
                
                Text(item.pubDate.cleaningPubDate, style: .date)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, -35)
            .padding()
            .redacted(
                reason: item.title == nil ? .placeholder : []
            )
            .shimmering(
                active: item.title == nil ? true : false,
                animation: .default
            )
            .background {
                ZStack {
                    RoundedRectangle(cornerRadius: 15, style: .circular)
                        .fill(item.categoryAccentColor)
                        .shadow(color: .black.opacity(0.08), radius: 8, x: 5, y: 5)
                        .shadow(color: .black.opacity(0.08), radius: 8, x: -5, y: -5)
                        .frame(
                            width: geometry.size.width * 0.77,
                            height: geometry.size.height * 0.7
                        )
                        .offset(y: 10)
                    
                    RoundedRectangle(cornerRadius: 15, style: .circular)
                        .fill(.white)
                        .shadow(color: .black.opacity(0.08), radius: 8, x: 5, y: 5)
                        .shadow(color: .black.opacity(0.08), radius: 8, x: -5, y: -5)
                        .frame(
                            width: geometry.size.width * 0.77,
                            height: geometry.size.height * 0.7
                        )
                }
            }
            .offset(y: -5)
        }
        .frame(height: geometry.size.height * 0.7)
    }
}

struct SearchCellView_Previews: PreviewProvider {
    static var previews: some View {
        SearchCellView(item: SearchModel.preview.item[0])
    }
}
