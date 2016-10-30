//
//  PasswordPanelLabel.swift
//  passwordd
//
//  Created by 日置大智 on 2015/04/29.
//  Copyright (c) 2015年 hiokidaichi. All rights reserved.
//

import UIKit

open class PasswordPanelLabel: UILabel {
    open static var width: CGFloat = {
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

    override open func awakeFromNib() {
        super.awakeFromNib()

        resetColor()
    }

    func setup(_ keyCode: KeyCode) {
        self.keyCode = keyCode
        text = keyCode.displayString()

        if UIDevice.deviceType == .iPad {
            font = UIFont.boldSystemFont(ofSize: 26)
        }
    }

    func highlightColor() {
        textColor = Color.highlight
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(MyUserDefaults.sharedInstance.speed.delay()) / Double(NSEC_PER_SEC)) {
            self.resetColor()
        }
    }

    func resetColor() {
        textColor = Color.normal
    }

    fileprivate struct Color {
        static let normal    = UIColor(red: 222/255.0, green: 222/255.0, blue: 222/255.0, alpha: 1)
        static let highlight = UIColor(red: 80/255.0, green: 80/255.0, blue: 80/255.0, alpha: 1)
    }
}
