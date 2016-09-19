//
//  Speed.swift
//  passwordd
//
//  Created by 日置大智 on 2015/05/04.
//  Copyright (c) 2015年 hiokidaichi. All rights reserved.
//

import Foundation

public enum Speed: Int {
    case slowest, slower, normal, faster, fastest

    public func delay() -> Int64 {
        let x: Double

        switch self {
        case .slowest: x = 0.2
        case .slower:  x = 0.15
        case .normal:  x = 0.1
        case .faster:  x = 0.075
        case .fastest: x = 0.05
        }

        return Int64(x * Double(NSEC_PER_SEC))
    }

    public func next() -> Speed {
        switch self {
        case .slowest: return .slower
        case .slower:  return .normal
        case .normal:  return .faster
        case .faster:  return .fastest
        case .fastest: return .slowest
        }
    }

    public func title() -> String {
        switch self {
        case .slowest: return "1x"
        case .slower:  return "2x"
        case .normal:  return "3x"
        case .faster:  return "4x"
        case .fastest: return "5x"
        }
    }
}
