//
//  HotelDetailDateView.swift
//  ElongHotel
//
//  Created by MC on 2020/4/29.
//  Copyright © 2020 MC. All rights reserved.
//

import SwiftUI

struct HotelDetailDateView: View {
    var response: HotelDetailResponse
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                Text(self.response.inDateStr)
                    .font(.headline)
                    .padding([.leading], 10)
                    .foregroundColor(Color("themeColor"))
                    
                Text("入住")
                    .font(.subheadline)
                    .padding([.leading], 5)
                    .foregroundColor(.secondary)
                
                Text(self.response.outDateStr)
                    .font(.headline)
                    .padding([.leading], 10)
                    .foregroundColor(Color("themeColor"))
                
                Text("离店")
                    .font(.subheadline)
                    .padding([.leading], 5)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Text("共\(self.response.days)晚")
                    .font(.subheadline)
                    .foregroundColor(Color("black2Color"))
                
                Image(systemName: "chevron.right")
                    .padding(.leading, 5)
                    .padding(.trailing, 10)
                    .foregroundColor(Color("black2Color"))
            }
        }
        .padding([.top, .bottom], 15)
        .background(Color("bgColor"))
        .cornerRadius(12)
        .padding(10)
    }
}
