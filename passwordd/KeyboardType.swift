//
//  KeyboardType.swift
//  passwordd
//
//  Created by 日置大智 on 2015/05/04.
//  Copyright (c) 2015年 hiokidaichi. All rights reserved.
//

import Foundation

public enum KeyboardType: Int {
    case jis, us

    public static let allValues = [jis, us]

    public static var currentKeyboardType = jis

    public func displayString() -> String {
        switch self {
        case .jis:
            return "JIS".localize()
        case .us:
            return "US".localize()
        }
    }
}
