//
//  CoverShape.swift
//  AladinAPITest
//
//  Created by 김건우 on 2023/03/20.
//

import SwiftUI

struct CoverShape: Shape {
    func path(in rect: CGRect) -> Path {
        let uiBeizierPath = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topRight, .bottomRight], cornerRadii: CGSize(width: 20, height: 20))
        
        return Path(uiBeizierPath.cgPath)
    }
}

struct CoverShape_Previews: PreviewProvider {
    static var previews: some View {
        CoverShape()
    }
}
