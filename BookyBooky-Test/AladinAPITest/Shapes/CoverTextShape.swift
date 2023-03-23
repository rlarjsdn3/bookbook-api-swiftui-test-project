//
//  CoverTextShape.swift
//  AladinAPITest
//
//  Created by 김건우 on 2023/03/20.
//

import SwiftUI

struct CoverTextShape: Shape {
    func path(in rect: CGRect) -> Path {
        let uiBeizierPath = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: [.topLeft, .bottomLeft],
            cornerRadii: CGSize(width: 20, height: 20)
        )
        
        return Path(uiBeizierPath.cgPath)
    }
}

struct CoverTextShape_Previews: PreviewProvider {
    static var previews: some View {
        CoverTextShape()
    }
}
