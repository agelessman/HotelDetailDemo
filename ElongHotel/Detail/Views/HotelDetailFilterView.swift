//
//  HotelDetailFilterView.swift
//  ElongHotel
//
//  Created by MC on 2020/4/30.
//  Copyright © 2020 MC. All rights reserved.
//

import SwiftUI

struct HotelDetailFilterView: View {
    var response: HotelDetailResponse
    var filterAction: (() -> Void)?
    
    var body: some View {
        VStack {
            HStack(spacing: 5) {
                ForEach(self.response.filterItems) { item in
                    Text(item.filterName)
                        .disabled(item.disable)
                        .font(.caption)
                        .foregroundColor(item.disable ? Color.gray : Color("black2Color"))
                        .padding([.leading, .trailing], 5)
                        .frame(height: 30)
                        .background(Color("bgColor"))
                        .cornerRadius(15)
                }
                
                Spacer()
                
                HStack(spacing: 0) {
                    Text("筛选")
                    Image(systemName: "chevron.down")
                        .padding(.leading, 4)
                }
                .onTapGesture {
                    self.filterAction?()
                }
                .font(.caption)
                .foregroundColor(Color("black2Color"))
                .padding([.leading, .trailing], 5)
                .frame(height: 30)
                .background(Color("bgColor"))
                .cornerRadius(15)
            }
            .padding([.leading, .trailing], 10)
        }
    }
}
