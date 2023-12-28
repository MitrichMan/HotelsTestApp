//
//  ListRowView.swift
//  HotelsTestApp
//
//  Created by Dmitrii Melnikov on 28.12.2023.
//

import SwiftUI

struct ListRowView: View {
    let title: String
    let subTitle: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                Text(subTitle)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(.gray)
                
            }
            Spacer()
            Image(systemName: "chevron.right")
        }
    }
}

#Preview {
    ListRowView(title: "", subTitle: "")
}
