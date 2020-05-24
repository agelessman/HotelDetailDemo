//
//  HotelDetailPoliciesView.swift
//  ElongHotel
//
//  Created by MC on 2020/5/3.
//  Copyright © 2020 MC. All rights reserved.
//

import SwiftUI

struct HotelDetailPoliciesView: View {
    var policies: [HotelPolicieItem]
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("入住政策")
                    .font(.headline)
                
                Spacer()
                
                HStack {
                    Text("更多详情")
                        .font(.subheadline)
                        .foregroundColor(Color("themeColor"))
                    
                    Image(systemName: "chevron.right")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .padding([.top, .leading, .trailing], 10)
            
            VStack(alignment: .leading, spacing: 5) {
                ForEach(policies) { policy in
                    VStack(alignment: .leading, spacing: 5) {
                        Text(policy.name)
                            .font(.subheadline)
                            .foregroundColor(.black)
                        
                        Text(policy.value)
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                            .lineLimit(3)
                            
                    }
                }
            }
            .padding(10)
    
        }
        .background(Color.white)
        .cornerRadius(12)
        .padding([.top, .leading, .trailing], 10)
    }
}
