//
//  HotelDetailHotProductView.swift
//  ElongHotel
//
//  Created by MC on 2020/4/30.
//  Copyright © 2020 MC. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct HotelDetailHotProductView: View {
    var response: HotelDetailResponse
    
    var productImage: Dictionary<String, [String]> {
        var dict = Dictionary<String, [String]>()
        if let roomTypes = response.roomTypes {
            let _ = roomTypes.map({ dict[$0.id] = $0.smallImgs })
        }
        return dict
    }
    
    var body: some View {
        VStack {
            if response.products != nil {
                ForEach(response.products!) { product in
                    VStack(spacing: 0) {
                        if product.recText != nil {
                            HStack {
                                Spacer()
                                Image(systemName: "wand.and.rays")
                                Text(product.recText!)
                                Spacer()
                            }
                            .font(.caption)
                            .foregroundColor(Color("redColor"))
                            .padding(.top, 10)
                        }
                        
                        HStack {
                            ZStack(alignment: .bottomTrailing) {
                                WebImage(url: URL(string: self.productImage[product.mroomId]?[0] ?? ""))
                                    .resizable()
                                    .scaledToFill()
                                    .animation(.easeInOut(duration: 0.5))
                                    .frame(width: 70)
                                    .cornerRadius(6)
                                    .padding(0)
                                
                                if self.productImage[product.mroomId] != nil {
                                    Text("\(self.productImage[product.mroomId]!.count)张")
                                        .font(.caption)
                                        .foregroundColor(.white)
                                        .padding(5)
                                        .background(Color.black.opacity(0.5))
                                        .cornerRadius(6, corners: [.topLeft, .bottomRight])
                                }
                               
                            }
                            .padding(5)

                            
                            VStack(alignment: .leading, spacing: 8) {
                                HStack(spacing: 0) {
                                    Text("\(product.roomTypeName)-\(product.breInfo)")
                                        .font(.headline)
                                        .foregroundColor(Color.black)
                                        .lineLimit(1)
                                    Image(systemName: "chevron.right")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                .padding(.top, 10)
                                
                                Text(self.getProductDesc(product))
                                    .font(.body)
                                    .foregroundColor(.secondary)
                                    .lineLimit(1)
                                
                                if self.getProductCancel(product) != nil {
                                    Text(self.getProductCancel(product)!)
                                        .font(.body)
                                        .foregroundColor(.secondary)
                                        .lineLimit(1)
                                }
                                
                                if product.showTags != nil {
                                   HotelTagView(tags: product.showTags!)
                                }
                                
                                Spacer()
                            }
                            
                            Spacer()
                            
                            VStack {
                                Spacer()
                                
                                HStack(alignment: .firstTextBaseline, spacing: 0) {
                                    Text("¥")
                                        .font(.subheadline)
                                        
                                    Text("\(product.dayPrices[0].Price)")
                                        .font(.title)
                                        .fontWeight(.bold)
                                }
                                .foregroundColor(Color("redColor"))
                                
                                Text(HotelPayTransform.getPayDesc(product.payType).0 ?? "")
                                    .foregroundColor(.white)
                                    .frame(height: 30)
                                    .padding([.leading, .trailing], 8)
                                    .background(Color("redColor"))
                                    .cornerRadius(15)
                                
                                if HotelPayTransform.getPayDesc(product.payType).1 != nil {
                                    Text(HotelPayTransform.getPayDesc(product.payType).1!)
                                        .font(.subheadline)
                                        .foregroundColor(Color("themeColor"))
                                        .padding(.top, 8)
                                }
                                
                                Spacer()
                            }
                            .padding([.trailing], 10)
                            .padding([.leading], 5)
                        }
                        .background(Color.white)
                        .frame(height: 120)
                        .cornerRadius(8)
                        .padding([.leading, .trailing], 10)
                        .padding([.top, .bottom], 5)
                    }
                }
            }
        }
        .background(Color("red1Color"))
        .cornerRadius(12)
        .padding([.leading, .trailing, .top], 10)
    }
    
    private func getProductDesc(_ prodcut: HotelProduct) -> String {
        var desc = ""
        
        let key1 = "area"
        let key2 = "bed"
        let key3 = "window"
        
        var dict = Dictionary<String, String>()
        
        for item in prodcut.additionList {
            if [key1, key2, key3].contains(item.key)   {
                dict[item.key] = item.content
            }
        }
        
        desc += dict[key1] ?? ""
        desc += dict[key2] != nil ? dict[key2]! + " " : ""
        desc += dict[key3] != nil ? dict[key3]! + " " : ""
        
        return desc
    }
    
    private func getProductCancel(_ product: HotelProduct) -> String? {
        if product.newCancelDesc != nil && product.newCancelDesc!.count > 0 {
            return product.newCancelDesc!.first!
        }
        return nil
    }
}

struct HotelTagView: View {
    var tags: [HotelTag]
    
    var body: some View {
        HStack {
            ForEach(self.tags) { tag in
                Text(tag.Name)
                    .font(.system(size: 10))
                    .foregroundColor(Color(hex: tag.Color))
                    .padding([.leading, .trailing], 4)
                    .padding([.top, .bottom], 2)
                    .overlay(
                        RoundedRectangle(cornerRadius: 2)
                            .stroke(Color(hex: tag.Color) ?? Color.gray, lineWidth: 0.5)
                    )
            }
        }
    }
}
