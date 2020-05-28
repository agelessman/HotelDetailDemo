//
//  HotelDetailResponse.swift
//  ElongHotel
//
//  Created by MC on 2020/4/22.
//  Copyright © 2020 MC. All rights reserved.
//

import Foundation

final class HotelDetailResponse: Codable {
    let imgList: [HotelDetailImageItem]
    let name: String
    let starDes: String
    let comment: HotelDetailComment
    let areaName: String?
    let address: String
    let poi: String
    let location: HotelLocation
    let banner: HotelBanner?
    let filterInfo: HotelFilterInfo
    let roomTypes:[HotelRoomType]?
    let products: [HotelProduct]?
    let policies: [HotelPolicieItem]
    let userComment: HotelUserComment
    
    let inDate = Date()
    let outdate = Date(timeIntervalSinceNow: 24 * 60 * 60)
    
    var inDateStr: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM月dd日"
        
        return formatter.string(from: inDate)
    }
    
    var outDateStr: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM月dd日"
        
        return formatter.string(from: outdate)
    }
    
    var days: String {
        let calendar = Calendar(identifier: .chinese)
        
        return "\(calendar.dateComponents([Calendar.Component.day], from: inDate, to: outdate).day!)"
    }
    
    var filterItems: [HotelFilterListItem] {
        var items = [HotelFilterListItem]()
        
        for item in self.filterInfo.fastGoodsFilters {
            if let objs = item.filterList {
                items.append(objs.first!)
            }
        }
        return items
    }
}

final class HotelPayTransform {
    static func getPayDesc(_ payType: Int) -> (String?, String?)! {
        switch payType {
        case 0:
            return ("到店付", "担保")
        case 1:
            return ("在线付", nil)
        default:
            return (nil, nil)
        }
    }
}

final class HotelLocation: Codable {
    let latgcj02: Double
    let lnggcj02: Double
}

final class HotelConmentTags: Codable, Identifiable {
    let id = UUID().uuidString
    let commentCount: Int
    let name: String
}

final class HotelDetailComment: Codable {
    let tags: [HotelConmentTags]
    let totalCount: Int
    let CommentDes: String
    let CommentScore: Float
}

final class HotelBanner: Codable {
    let bgPicUrl: String
}

final class HotelFilterListItem: Codable, Identifiable, Equatable {
    static func == (lhs: HotelFilterListItem, rhs: HotelFilterListItem) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id = UUID().uuidString
    let disable: Bool
    let filterName: String
    let describe: String
    let filterList: [HotelFilterListItem]?
}

final class HotelFilterInfo: Codable {
    let fastGoodsFilters: [HotelFilterListItem]
    let normalGoodsFilters: [HotelFilterListItem]
}

final class HotelProduct: Codable, Identifiable {
    let id = UUID().uuidString
    let additionList: [HotelAdditionListItem]
    let newCancelDesc: [String]?
    let breInfo: String
    let roomTypeName: String
    let payType: Int
    let dayPrices: [HotelDayPrices]
    let rId: String
    let fromName: String?
    let name: String?
    let recText: String?
    let showTags: [HotelTag]?
    let minPricetDes: String?
}

final class HotelAdditionListItem: Codable {
    let content: String
    let key: String
}

final class HotelTag: Codable, Identifiable {
    let id = UUID().uuidString
    let Color: String
    let Name: String
}

final class HotelDayPrices: Codable {
    let Price: Int
}

final class HotelRoomType: Codable, Identifiable {
    let id: String
    let additionList: [HotelAdditionListItem]
    let name: String
    let price: Int
    let smallImgs: [String]
    let coverImg: String
    let products: [HotelProduct]?
    
    let showed: String?
}

final class HotelPolicieItem: Codable, Identifiable {
    let id = UUID().uuidString
    let name: String
    let value: String
}

final class HotelUserComment: Codable {
    let title: String
    let totalCountTip: String
    
    let info: HotelUserCommentInfo
}

final class HotelUserCommentInfo: Codable {
    let userScore: Double
    let userName: String
    let travelTypeDesc: String
    let roomTypeName: String
    let commentDateTime: String
    let commentContent: String
    
    let commentScore: HotelCommentScore
}

final class HotelCommentScore: Codable {
    let commentDes: String
    let facilityScore: Double
    let positionScore: Double
    let sanitationScore: Double
    let score: Double
    let serviceScore: Double
}
