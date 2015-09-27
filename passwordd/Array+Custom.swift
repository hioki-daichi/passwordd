//
//  Array+Custom.swift
//  passwordd
//
//  Created by 日置大智 on 2015/05/04.
//  Copyright (c) 2015年 hiokidaichi. All rights reserved.
//

import Foundation

extension Array {
    func sample() -> Element {
        return self[Int(arc4random_uniform(UInt32(count)))]
    }
}
