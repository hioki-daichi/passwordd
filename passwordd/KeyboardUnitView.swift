//
//  KeyboardUnitView.swift
//  passwordd
//
//  Created by 日置大智 on 2015/04/29.
//  Copyright (c) 2015年 hiokidaichi. All rights reserved.
//

import UIKit

public class KeyboardUnitView: UIView {
    public static var width: CGFloat = {
        switch UIDevice.deviceType {
        case .iPhone6:
            return 22
        case .iPhone6Plus:
            return 25
        case .iPad:
            return 45
        default:
            return 19
        }
        }()

    var label = UILabel(frame: CGRectZero)
    var keyCode: KeyCode?

    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        resetColor()
        setLabel()

        // Border
        layer.borderColor = Color.border.CGColor
        let borderWidth = CGFloat(0.5)
        frame = CGRectInset(frame, -borderWidth, -borderWidth)
        layer.borderWidth = borderWidth
        layer.cornerRadius = 2
    }

    override public func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        super.touchesBegan(touches, withEvent: event)

        highlightColor()

        if let keyCode = keyCode {
            SoundManager.play(keyCode)
        }
    }

    func setup(keyCode: KeyCode) {
        self.keyCode = keyCode
        label.text = keyCode.displayString()
    }

    func highlightColor() {
        backgroundColor = Color.highlight
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, MyUserDefaults.sharedInstance.speed.delay()), dispatch_get_main_queue()) {
            self.resetColor()
        }
    }

    func resetColor() {
        backgroundColor = Color.normal
    }

    private struct Color {
        static let title     = UIColor(red: 128/255.0, green: 128/255.0, blue: 128/255.0, alpha: 1)
        static let highlight = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1)
        static let normal    = UIColor(red: 247/255.5, green: 247/255.0, blue: 247/255.0, alpha: 1)
        static let border    = UIColor(red: 222/255.5, green: 222/255.0, blue: 222/255.0, alpha: 1)
    }

    private func setLabel() {
        label.textColor = Color.title
        let labelSize: CGFloat = {
            switch UIDevice.deviceType {
            case .iPad:
                return 22
            default:
                return 14
            }
            }()
        label.font = UIFont(name: "DINAlternate-Bold", size: labelSize)
        addSubview(label)
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        addConstraints(
            [
                NSLayoutConstraint(item: self, attribute: .CenterX, relatedBy: .Equal, toItem: label, attribute: .CenterX, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: self, attribute: .CenterY, relatedBy: .Equal, toItem: label, attribute: .CenterY, multiplier: 1, constant: 0),
            ]
        )
    }
}
