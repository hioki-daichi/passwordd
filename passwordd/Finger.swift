//
//  Finger.swift
//  passwordd
//
//  Created by 日置大智 on 2015/05/04.
//  Copyright (c) 2015年 hiokidaichi. All rights reserved.
//

import Foundation

public enum Finger {
    case Index, Middle, Ring, Pinkie

    public static let allValues = [Index, Middle, Ring, Pinkie]

    // 左手のその指の使用が許可されているかどうか
    public func isAllowedL() -> Bool {
        switch self {
        case .Index:
            return MyUserDefaults.sharedInstance.allowIndexFingerL
        case .Middle:
            return MyUserDefaults.sharedInstance.allowMiddleFingerL
        case .Ring:
            return MyUserDefaults.sharedInstance.allowRingFingerL
        case .Pinkie:
            return MyUserDefaults.sharedInstance.allowPinkieL
        }
    }

    // 右手のその指の使用が許可されているかどうか
    public func isAllowedR() -> Bool {
        switch self {
        case .Index:
            return MyUserDefaults.sharedInstance.allowIndexFingerR
        case .Middle:
            return MyUserDefaults.sharedInstance.allowMiddleFingerR
        case .Ring:
            return MyUserDefaults.sharedInstance.allowRingFingerR
        case .Pinkie:
            return MyUserDefaults.sharedInstance.allowPinkieR
        }
    }
}
