//
//  TileStackView.swift
//  HotelsTestApp
//
//  Created by Dmitrii Melnikov on 28.12.2023.
//

import SwiftUI

struct TileStackView: View {
    var content: [String]
    let foregroundColor: Color
    let backgroundColor: Color
    
    var body: some View {
        GeometryReader { geometry in
            LazyVGrid(
                columns: [
                    GridItem(.flexible(
                        minimum: 0,
                        maximum: geometry.size.width)
                    ),
                    GridItem(.flexible(
                        minimum: 0,
                        maximum: geometry.size.width)
                    )
                ],
                alignment: .leading,
                spacing: 8,
                content: {
                    ForEach(content, id: \.self) { text in
                        TileView(
                            content: Text(text),
                            foregroundColor: foregroundColor,
                            backlgroundColor: backgroundColor
                        )
                        .frame(
                            minWidth: 0,
                            maxWidth: geometry.size.width / 2 - 4
                        )
                        .fixedSize(horizontal: true, vertical: false)
                    }
                }
            )
        }
    }
}
