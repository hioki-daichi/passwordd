//
//  Speed.swift
//  passwordd
//
//  Created by 日置大智 on 2015/05/04.
//  Copyright (c) 2015年 hiokidaichi. All rights reserved.
//

import Foundation

public enum Speed: Int {
    case Slowest, Slower, Normal, Faster, Fastest

    public func delay() -> Int64 {
        let x: Double

        switch self {
        case .Slowest: x = 0.2
        case .Slower:  x = 0.15
        case .Normal:  x = 0.1
        case .Faster:  x = 0.075
        case .Fastest: x = 0.05
        }

        return Int64(x * Double(NSEC_PER_SEC))
    }

    public func next() -> Speed {
        switch self {
        case .Slowest: return .Slower
        case .Slower:  return .Normal
        case .Normal:  return .Faster
        case .Faster:  return .Fastest
        case .Fastest: return .Slowest
        }
    }

    public func title() -> String {
        switch self {
        case .Slowest: return "1x"
        case .Slower:  return "2x"
        case .Normal:  return "3x"
        case .Faster:  return "4x"
        case .Fastest: return "5x"
        }
    }
}
