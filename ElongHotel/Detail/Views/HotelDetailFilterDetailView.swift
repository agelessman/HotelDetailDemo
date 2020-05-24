//
//  HotelDetailFilterDetailView.swift
//  ElongHotel
//
//  Created by MC on 2020/5/5.
//  Copyright © 2020 MC. All rights reserved.
//

import SwiftUI

struct HotelDetailFilterDetailView: View {
    var filters: [HotelFilterListItem]
    
    @Binding var show: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            GeometryReader { geo in
                ZStack(alignment: .bottom) {
                   
                        Rectangle()
                            .fill(Color.black.opacity(self.show ? 0.5 : 0))
                            .frame(width: geo.size.width, height: geo.size.height)
                            .transition(.fade)
                            .onTapGesture {
                                withAnimation(.easeIn) {
                                    self.show.toggle()
                                }
                        }
                        
                        VStack(alignment: .leading, spacing: 0) {
                            ScrollView(showsIndicators: false) {
                                VStack(alignment: .leading, spacing: 20) {
                                    ForEach(self.filters) { filter in
                                        VStack(alignment: .leading, spacing: 10) {
                                            Text(filter.describe)

                                            TestWrappedLayout(w: geo.size.width, filters: filter.filterList!)

                                        }
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding([.top, .leading, .trailing], 10)
                            }.padding(0)
                            
                            
                            Spacer(minLength: 0)
                            
                            VStack(alignment: .leading, spacing: 0) {
                                HStack {
                                    Button("清空选择") {
                                        
                                    }
                                    .frame(width: 80, height: 40)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color.gray, lineWidth: 1)
                                    )
                                    
                                    Text("确定")
                                        .frame(height: 40)
                                        .frame(maxWidth: .infinity)
                                        .font(.subheadline)
                                        .foregroundColor(.white)
                                        .background(Color("themeColor"))
                                        .cornerRadius(20)
                                        .onTapGesture {
                                            withAnimation(.easeIn) {
                                                self.show.toggle()
                                            }
                                    }
                                    
                                }
                                .padding([.leading, .trailing], 20)
                                .padding([.top, .bottom], 0)
                            }
                            .frame(height: isIphoneXOrLonger ? 34 + 60 : 60)
                            .background(Color.purple)
                        }
                        .frame(height: self.show ? geo.size.height * 0.8 : 0)
                        .background(Color.white)
                        .transition(.move(edge: .bottom))
                        .cornerRadius(12)
                    
                }
            }
        }
    }
}

struct TestWrappedLayout: View {
    let w: CGFloat
    @State var filters: [HotelFilterListItem]

    var body: some View {
        self.generateContent(in: w)
    }

    private func generateContent(in w: CGFloat) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return ZStack(alignment: .topLeading) {
            ForEach(self.filters) { f in
                self.item(for: f.filterName)
                    .padding([.trailing, .bottom], 4)
                    .alignmentGuide(.leading, computeValue: { d in
                     
                        if (abs(width - d.width) > w)
                        {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if f == self.filters.last! {
                            width = 0 //last item
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: {d in
                        let result = height
                        if f == self.filters.last! {
                            height = 0 // last item
                        }
                        return result
                    })
            }
        }
    }

    func item(for text: String) -> some View {
        Text(text)
            .padding([.leading, .trailing], 8)
            .frame(height: 30)
            .font(.subheadline)
            .background(Color.gray.opacity(0.1))
            .foregroundColor(Color("black2Color"))
            .cornerRadius(15)
            .onTapGesture {
                print("你好啊")
        }
    }
}
