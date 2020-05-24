//
//  HotelDetailRoomView.swift
//  ElongHotel
//
//  Created by MC on 2020/5/1.
//  Copyright © 2020 MC. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct HotelDetailRoomView: View {
    var room: HotelRoomType
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                ZStack(alignment: .bottomTrailing) {
                    WebImage(url: URL(string: self.room.coverImg))
                        .resizable()
                        .scaledToFill()
                        .animation(.easeInOut(duration: 0.5))
                        .frame(width: 70)
                        .cornerRadius(6, corners: .allCorners)
                        .padding(0)
                    
                    Text("\(self.room.smallImgs.count)张")
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(5)
                        .background(Color.black.opacity(0.5))
                        .cornerRadius(6, corners: [.topLeft, .bottomRight])
                   
                }
                .padding([.top, .trailing, .bottom], 5)
                
                VStack(alignment: .leading, spacing: 10) {
                    HStack(spacing: 0) {
                        Text("\(self.room.name)")
                            .font(.headline)
                            .foregroundColor(Color.black)
                            .lineLimit(2)
                    }
                    .padding(.top, 10)

                    Text(self.getRoomDesc(room))
                        .font(.body)
                        .foregroundColor(.secondary)
                        .lineLimit(1)

                    Spacer()
                }

                Spacer()

                HStack(alignment: .firstTextBaseline, spacing: 0) {
                    Group {
                        Text("¥")
                            .font(.subheadline)
                            

                        Text("\(self.room.price)")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text("起")
                            .font(.body)
                    }
                    .lineLimit(1)
                    .foregroundColor(Color("redColor"))

                    Image(systemName: "chevron.up")
                        .padding(.leading, 4)
                        .foregroundColor(Color.gray)
                }
                .padding([.trailing], 10)
                .padding([.leading], 5)
                .layoutPriority(1)
            }
                .background(Color.white)
                .frame(height: 120)
                .cornerRadius(8, corners: .allCorners)
                .padding([.leading, .trailing], 10)
                .padding([.top, .bottom], 5)
            
            /// 子房型
            if self.room.products != nil && self.room.showed != nil {
                VStack(spacing: 5) {
                    ForEach(self.room.products!) { product in
                        HotelRoomSon(product: product)
                    }
                }
                    .padding([.leading, .trailing, .bottom], 10)
                    .padding(.top, 5)
            }
        }
        .background(RoundedRectangle(cornerRadius: 12).fill(Color.white))
        .padding([.leading, .trailing, .top], 10)
        
    }
    private func getRoomDesc(_ room: HotelRoomType) -> String {
        var desc = ""
        
        let key1 = "floor"
        
        var dict = Dictionary<String, String>()
        
        for item in room.additionList {
            if [key1].contains(item.key)   {
                dict[item.key] = item.content
            }
        }
        
        desc += dict[key1] ?? ""
        
        return desc
    }
    
    private func getProductCancel(_ product: HotelProduct) -> String? {
        if product.newCancelDesc != nil && product.newCancelDesc!.count > 0 {
            return product.newCancelDesc!.first!
        }
        return nil
    }
}


struct HotelRoomSon: View {
    var product: HotelProduct
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text(self.product.breInfo)
                        .foregroundColor(.black)
                        .font(.headline)
                    
                    if self.product.minPricetDes != nil {
                        Text(self.product.minPricetDes!)
                            .foregroundColor(.white)
                            .padding([.leading, .trailing], 4)
                            .padding([.top, .bottom], 2)
                            .background(Color.green)
                            .font(.subheadline)
                    }
                    
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                        .font(.caption)
                }
                
                if self.product.name != nil {
                    Text(self.product.name!)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                HStack {
                    if self.product.supplierName != nil {
                        Text(self.product.supplierName!)
                            .foregroundColor(Color("themeColor"))
                            .font(.subheadline)
                    }
                    
                    if self.getProductCancel(product) != nil {
                        Text(self.getProductCancel(product)!)
                            .foregroundColor(.secondary)
                            .font(.subheadline)
                    }
                }
                
                if self.product.showTags != nil {
                   HotelTagView(tags: product.showTags!)
                }
            }
            .padding()
            
            Spacer()
            
            /// 价格区域
            HStack {
                HStack(alignment: .firstTextBaseline, spacing: 0) {
                    Text("¥")
                        .font(.subheadline)
                        
                    Text("\(product.dayPrices[0].Price)")
                        .font(.title)
                        .fontWeight(.bold)
                }
                .foregroundColor(Color("redColor"))
                
                VStack {
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
                }
                .padding([.trailing], 10)
                .padding([.leading], 5)
            }
            .layoutPriority(1)
        }
            .background(Color("grayBgColor"))
            .cornerRadius(6)
            
    }
    
    private func getProductCancel(_ product: HotelProduct) -> String? {
        if product.newCancelDesc != nil && product.newCancelDesc!.count > 0 {
            return product.newCancelDesc!.first!
        }
        return nil
    }
}
