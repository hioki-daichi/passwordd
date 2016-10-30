//
//  Finger.swift
//  passwordd
//
//  Created by 日置大智 on 2015/05/04.
//  Copyright (c) 2015年 hiokidaichi. All rights reserved.
//

import Foundation

public enum Finger {
    case index, middle, ring, pinkie

    public static let allValues = [index, middle, ring, pinkie]

    // 左手のその指の使用が許可されているかどうか
    public func isAllowedL() -> Bool {
        switch self {
        case .index:
            return MyUserDefaults.sharedInstance.allowIndexFingerL
        case .middle:
            return MyUserDefaults.sharedInstance.allowMiddleFingerL
        case .ring:
            return MyUserDefaults.sharedInstance.allowRingFingerL
        case .pinkie:
            return MyUserDefaults.sharedInstance.allowPinkieL
        }
    }

    // 右手のその指の使用が許可されているかどうか
    public func isAllowedR() -> Bool {
        switch self {
        case .index:
            return MyUserDefaults.sharedInstance.allowIndexFingerR
        case .middle:
            return MyUserDefaults.sharedInstance.allowMiddleFingerR
        case .ring:
            return MyUserDefaults.sharedInstance.allowRingFingerR
        case .pinkie:
            return MyUserDefaults.sharedInstance.allowPinkieR
        }
    }
}
