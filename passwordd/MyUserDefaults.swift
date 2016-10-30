//
//  MyUserDefaults.swift
//  passwordd
//
//  Created by 日置大智 on 2015/04/25.
//  Copyright (c) 2015年 hiokidaichi. All rights reserved.
//

import Foundation

open class MyUserDefaults {
    open static let sharedInstance = MyUserDefaults()

    open var includeNumber: Bool {
        get { return defaults.bool(forKey: "IncludeNumber") }
        set { defaults.set(newValue, forKey: "IncludeNumber") }
    }

    open var includeLowerCaseSign: Bool {
        get { return defaults.bool(forKey: "IncludeLowerCaseSign") }
        set { defaults.set(newValue, forKey: "IncludeLowerCaseSign") }
    }

    open var allowIndexFingerL: Bool {
        get { return defaults.bool(forKey: "AllowIndexFingerL") }
        set { defaults.set(newValue, forKey: "AllowIndexFingerL") }
    }

    open var allowIndexFingerR: Bool {
        get { return defaults.bool(forKey: "AllowIndexFingerR") }
        set { defaults.set(newValue, forKey: "AllowIndexFingerR") }
    }

    open var allowMiddleFingerL: Bool {
        get { return defaults.bool(forKey: "AllowMiddleFingerL") }
        set { defaults.set(newValue, forKey: "AllowMiddleFingerL") }
    }

    open var allowMiddleFingerR: Bool {
        get { return defaults.bool(forKey: "AllowMiddleFingerR") }
        set { defaults.set(newValue, forKey: "AllowMiddleFingerR") }
    }

    open var allowRingFingerL: Bool {
        get { return defaults.bool(forKey: "AllowRingFingerL") }
        set { defaults.set(newValue, forKey: "AllowRingFingerL") }
    }

    open var allowRingFingerR: Bool {
        get { return defaults.bool(forKey: "AllowRingFingerR") }
        set { defaults.set(newValue, forKey: "AllowRingFingerR") }
    }

    open var allowPinkieL: Bool {
        get { return defaults.bool(forKey: "AllowPinkieL") }
        set { defaults.set(newValue, forKey: "AllowPinkieL") }
    }

    open var allowPinkieR: Bool {
        get { return defaults.bool(forKey: "AllowPinkieR") }
        set { defaults.set(newValue, forKey: "AllowPinkieR") }
    }

    open var keyboardType: KeyboardType {
        get { return KeyboardType(rawValue: defaults.integer(forKey: "KeyboardType"))! }
        set(newValue) { defaults.set(newValue.rawValue, forKey: "KeyboardType") }
    }

    open var speed: Speed {
        get { return Speed(rawValue: defaults.integer(forKey: "Speed"))! }
        set(newValue) { defaults.set(newValue.rawValue, forKey: "Speed") }
    }

    open func setDefaultValue() {
        let lang = Locale.preferredLanguages[0]
        let keyboardType: KeyboardType = lang == "ja" ? .jis : .us

        defaults.register(
            defaults: [
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
                "Speed":                Speed.slowest.rawValue,
            ]
        )
    }

    fileprivate let defaults = UserDefaults.standard
}
