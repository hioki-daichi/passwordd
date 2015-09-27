//
//  MyUserDefaults.swift
//  passwordd
//
//  Created by 日置大智 on 2015/04/25.
//  Copyright (c) 2015年 hiokidaichi. All rights reserved.
//

import Foundation

public class MyUserDefaults {
    public static let sharedInstance = MyUserDefaults()

    public var includeNumber: Bool {
        get { return defaults.boolForKey("IncludeNumber") }
        set { defaults.setBool(newValue, forKey: "IncludeNumber") }
    }

    public var includeLowerCaseSign: Bool {
        get { return defaults.boolForKey("IncludeLowerCaseSign") }
        set { defaults.setBool(newValue, forKey: "IncludeLowerCaseSign") }
    }

    public var allowIndexFingerL: Bool {
        get { return defaults.boolForKey("AllowIndexFingerL") }
        set { defaults.setBool(newValue, forKey: "AllowIndexFingerL") }
    }

    public var allowIndexFingerR: Bool {
        get { return defaults.boolForKey("AllowIndexFingerR") }
        set { defaults.setBool(newValue, forKey: "AllowIndexFingerR") }
    }

    public var allowMiddleFingerL: Bool {
        get { return defaults.boolForKey("AllowMiddleFingerL") }
        set { defaults.setBool(newValue, forKey: "AllowMiddleFingerL") }
    }

    public var allowMiddleFingerR: Bool {
        get { return defaults.boolForKey("AllowMiddleFingerR") }
        set { defaults.setBool(newValue, forKey: "AllowMiddleFingerR") }
    }

    public var allowRingFingerL: Bool {
        get { return defaults.boolForKey("AllowRingFingerL") }
        set { defaults.setBool(newValue, forKey: "AllowRingFingerL") }
    }

    public var allowRingFingerR: Bool {
        get { return defaults.boolForKey("AllowRingFingerR") }
        set { defaults.setBool(newValue, forKey: "AllowRingFingerR") }
    }

    public var allowPinkieL: Bool {
        get { return defaults.boolForKey("AllowPinkieL") }
        set { defaults.setBool(newValue, forKey: "AllowPinkieL") }
    }

    public var allowPinkieR: Bool {
        get { return defaults.boolForKey("AllowPinkieR") }
        set { defaults.setBool(newValue, forKey: "AllowPinkieR") }
    }

    public var keyboardType: KeyboardType {
        get { return KeyboardType(rawValue: defaults.integerForKey("KeyboardType"))! }
        set(newValue) { defaults.setInteger(newValue.rawValue, forKey: "KeyboardType") }
    }

    public var speed: Speed {
        get { return Speed(rawValue: defaults.integerForKey("Speed"))! }
        set(newValue) { defaults.setInteger(newValue.rawValue, forKey: "Speed") }
    }

    public func setDefaultValue() {
        let lang = NSLocale.preferredLanguages()[0]
        let keyboardType: KeyboardType = lang == "ja" ? .JIS : .US

        defaults.registerDefaults(
            [
                "IncludeNumber":        false,
                "IncludeLowerCaseSign": false,
                "AllowIndexFingerL":    true,
                "AllowIndexFingerR":    true,
                "AllowMiddleFingerL":   true,
                "AllowMiddleFingerR":   true,
                "AllowRingFingerL":     true,
                "AllowRingFingerR":     true,
                "AllowPinkieL":         true,
                "AllowPinkieR":         true,
                "KeyboardType":         keyboardType.rawValue,
                "Speed":                Speed.Slowest.rawValue,
            ]
        )
    }

    private let defaults = NSUserDefaults.standardUserDefaults()
}
