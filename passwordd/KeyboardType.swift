//
//  KeyboardType.swift
//  passwordd
//
//  Created by 日置大智 on 2015/05/04.
//  Copyright (c) 2015年 hiokidaichi. All rights reserved.
//

import Foundation

public enum KeyboardType: Int {
    case JIS, US

    public static let allValues = [JIS, US]

    public static var currentKeyboardType = JIS

    public func displayString() -> String {
        switch self {
        case .JIS:
            return "JIS".localize()
        case .US:
            return "US".localize()
        }
    }
}
