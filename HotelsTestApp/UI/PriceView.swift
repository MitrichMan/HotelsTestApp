//
//  PriceView.swift
//  HotelsTestApp
//
//  Created by Dmitrii Melnikov on 27.12.2023.
//

import SwiftUI

struct PriceView: View {
    
    let price: String
    let pricePer: String
    
    var body: some View {
        HStack(alignment: .bottom){
            Text("\(price)")
                .font(.system(size: 30, weight: .semibold))
                .frame(alignment: .leading)
            
            Text(pricePer)
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(.gray)
            
            Spacer()
        }
    }
}
