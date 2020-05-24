//
//  Color-Hex.swift
//  ElongHotel
//
//  Created by MC on 2020/5/1.
//  Copyright © 2020 MC. All rights reserved.
//

import SwiftUI

extension Color {
    public init?(hex: String) {
        let r, g, b, a: Double

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count >= 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = Double((hexNumber & 0xff000000) >> 24) / 255.0
                    g = Double((hexNumber & 0x00ff0000) >> 16) / 255.0
                    b = Double((hexNumber & 0x0000ff00) >> 8) / 255.0
                    a = Double(hexNumber & 0x000000ff) / 255.0

                    self.init(.sRGB, red: r, green: g, blue: b, opacity: a)
                    return
                }
            }
        }

        return nil
    }
}
