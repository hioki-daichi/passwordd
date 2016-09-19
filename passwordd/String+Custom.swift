//
//  String+Custom.swift
//  passwordd
//
//  Created by 日置大智 on 2015/04/30.
//  Copyright (c) 2015年 hiokidaichi. All rights reserved.
//

import Foundation

extension String {
    func localize() -> String {
        return NSLocalizedString(self, comment: "")
    }

    func getDictionaryFromQuery() -> [String: String] {
        var queryParams = [String: String]()
        for keyValue in self.components(separatedBy: "&") {
            let pair = keyValue.components(separatedBy: "=")
            queryParams[pair[0]] = pair[1]
        }

        return queryParams
    }
}
