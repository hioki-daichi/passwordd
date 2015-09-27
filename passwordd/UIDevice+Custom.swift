//
//  UIDevice+Custom.swift
//  passwordd
//
//  Created by 日置大智 on 2015/04/30.
//  Copyright (c) 2015年 hiokidaichi. All rights reserved.
//

import UIKit

public extension UIDevice {
    public enum DeviceType {
        case iPhone6, iPhone6Plus, iPad, Others
    }

    public var modelIdentifier: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let mirror = reflect(systemInfo.machine)

        var identifier = ""
        for i in 0..<mirror.count {
            if let value = mirror[i].1.value as? Int8 where value != 0 {
                identifier.append(UnicodeScalar(UInt8(value)))
            }
        }

        return identifier
    }

    public static var deviceType: DeviceType = {
        let identifier = UIDevice.currentDevice().modelIdentifier

        if ["x86_64", "i386"].contains(identifier) { // Simulator の場合
            switch UIScreen.mainScreen().bounds.size {
            case CGSize(width: 414.0, height: 736.0):
                return .iPhone6Plus
            case CGSize(width: 375.0, height: 667.0):
                return .iPhone6
            case CGSize(width: 768.0, height: 1024.0):
                return .iPad
            default:
                return .Others
            }
        }

        switch identifier {
        case "iPhone7,1":
            return .iPhone6Plus
        case "iPhone7,2":
            return .iPhone6
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4", "iPad3,1", "iPad3,2", "iPad3,3", "iPad3,4", "iPad3,5", "iPad3,6", "iPad4,1", "iPad4,2", "iPad4,3", "iPad5,1", "iPad5,3", "iPad5,4", "iPad2,5", "iPad2,6", "iPad2,7", "iPad4,4", "iPad4,5", "iPad4,6", "iPad4,7", "iPad4,8", "iPad4,9":
            return .iPad
        default:
            return .Others
        }
    }()
}
