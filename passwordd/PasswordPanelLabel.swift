//
//  PasswordPanelLabel.swift
//  passwordd
//
//  Created by 日置大智 on 2015/04/29.
//  Copyright (c) 2015年 hiokidaichi. All rights reserved.
//

import UIKit

public class PasswordPanelLabel: UILabel {
    public static var width: CGFloat = {
        switch UIDevice.deviceType {
        case .iPhone6:
            return 21
        case .iPhone6Plus:
            return 24
        case .iPad:
            return 46
        default:
            return 18
        }
        }()

    var keyCode: KeyCode?

    override public func awakeFromNib() {
        super.awakeFromNib()

        resetColor()
    }

    func setup(keyCode: KeyCode) {
        self.keyCode = keyCode
        text = keyCode.displayString()

        if UIDevice.deviceType == .iPad {
            font = UIFont.boldSystemFontOfSize(26)
        }
    }

    func highlightColor() {
        textColor = Color.highlight
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, MyUserDefaults.sharedInstance.speed.delay()), dispatch_get_main_queue()) {
            self.resetColor()
        }
    }

    func resetColor() {
        textColor = Color.normal
    }

    private struct Color {
        static let normal    = UIColor(red: 222/255.0, green: 222/255.0, blue: 222/255.0, alpha: 1)
        static let highlight = UIColor(red: 80/255.0, green: 80/255.0, blue: 80/255.0, alpha: 1)
    }
}
