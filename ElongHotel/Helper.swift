//
//  Helper.swift
//  ElongHotel
//
//  Created by MC on 2020/5/5.
//  Copyright © 2020 MC. All rights reserved.
//

import UIKit

var isIphoneXOrLonger: Bool {
    // 812.0 / 375.0 on iPhone X, XS.
    // 896.0 / 414.0 on iPhone XS Max, XR.
    return UIScreen.main.bounds.height / UIScreen.main.bounds.width >= 896.0 / 414.0
}
