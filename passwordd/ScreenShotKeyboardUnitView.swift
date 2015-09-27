//
//  ScreenShotKeyboardUnitView.swift
//  passwordd
//
//  Created by 日置大智 on 2015/05/01.
//  Copyright (c) 2015年 hiokidaichi. All rights reserved.
//

import UIKit

// MEMO: ViewController の viewDidLoad で ScreenShotKeyboardUnitView.setupScreenShotView(view) を実行すればキャプチャ用の画面が出来上がる
class ScreenShotKeyboardUnitView: UIView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        backgroundColor = UIColor(red: 247/255.5, green: 247/255.0, blue: 247/255.0, alpha: 1)

        if tag == 1 {
            // Label
            let label = UILabel(frame: CGRectZero)
            let n: CGFloat = 140 / 255.0
            label.textColor = UIColor(red: n, green: n, blue: n, alpha: 1)
            label.text = "d"
            label.font = UIFont(name: "DINAlternate-Bold", size: 400)
            label.translatesAutoresizingMaskIntoConstraints = false
            addSubview(label)
            addConstraint(NSLayoutConstraint(item: label, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0))
            addConstraint(NSLayoutConstraint(item: label, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 0))

            // Border
            layer.borderColor = UIColor(red: 222/255.5, green: 222/255.0, blue: 222/255.0, alpha: 1).CGColor
            let borderWidth = CGFloat(2)
            frame = CGRectInset(frame, -borderWidth, -borderWidth)
            layer.borderWidth = borderWidth
            layer.cornerRadius = 12

            // Drop Shadow
            let maskLayer = CAShapeLayer()
            let keyboardUnitViewWidth: CGFloat = 512
            maskLayer.path = UIBezierPath(roundedRect: CGRectMake(0, 0, keyboardUnitViewWidth, keyboardUnitViewWidth + 10), cornerRadius: 12).CGPath
            layer.mask = maskLayer
            layer.masksToBounds = false
            layer.shadowColor = UIColor.blackColor().CGColor
            layer.shadowOpacity = 0.17
            layer.shadowRadius = 10.0
            layer.shadowOffset = CGSizeMake(0, 0)
        }
    }

    class func setupScreenShotView(superView: UIView) {
        superView.backgroundColor = UIColor.grayColor()

        let v = UINib(nibName: "ScreenShotView", bundle: nil).instantiateWithOwner(self, options: nil)[0] as! UIView
        superView.addSubview(v)
        v.translatesAutoresizingMaskIntoConstraints = false
        superView.addConstraint(NSLayoutConstraint(item: v, attribute: .Top, relatedBy: .Equal, toItem: superView, attribute: .Top, multiplier: 1, constant: 0))
        superView.addConstraint(NSLayoutConstraint(item: v, attribute: .Left, relatedBy: .Equal, toItem: superView, attribute: .Left, multiplier: 1, constant: 0))
    }
}
