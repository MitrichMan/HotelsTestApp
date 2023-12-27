//
//  TileView.swift
//  HotelsTestApp
//
//  Created by Dmitrii Melnikov on 27.12.2023.
//

import SwiftUI

struct TileView: View {
    let content: Text
    let foregroundColor: Color
    let backlgroundColor: Color
    
    var body: some View {
        Text("\(content)")
            .font(.system(size: 16, weight: .medium))
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .foregroundStyle(foregroundColor)
            .background(backlgroundColor)
            .frame(alignment: .leading)
            .cornerRadius(5)
    }
}
