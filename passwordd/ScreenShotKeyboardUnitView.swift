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
            let label = UILabel(frame: CGRect.zero)
            let n: CGFloat = 140 / 255.0
            label.textColor = UIColor(red: n, green: n, blue: n, alpha: 1)
            label.text = "d"
            label.font = UIFont(name: "DINAlternate-Bold", size: 400)
            label.translatesAutoresizingMaskIntoConstraints = false
            addSubview(label)
            addConstraint(NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
            addConstraint(NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))

            // Border
            layer.borderColor = UIColor(red: 222/255.5, green: 222/255.0, blue: 222/255.0, alpha: 1).cgColor
            let borderWidth = CGFloat(2)
            frame = frame.insetBy(dx: -borderWidth, dy: -borderWidth)
            layer.borderWidth = borderWidth
            layer.cornerRadius = 12

            // Drop Shadow
            let maskLayer = CAShapeLayer()
            let keyboardUnitViewWidth: CGFloat = 512
            maskLayer.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: keyboardUnitViewWidth, height: keyboardUnitViewWidth + 10), cornerRadius: 12).cgPath
            layer.mask = maskLayer
            layer.masksToBounds = false
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOpacity = 0.17
            layer.shadowRadius = 10.0
            layer.shadowOffset = CGSize(width: 0, height: 0)
        }
    }

    class func setupScreenShotView(_ superView: UIView) {
        superView.backgroundColor = UIColor.gray

        let v = UINib(nibName: "ScreenShotView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! UIView
        superView.addSubview(v)
        v.translatesAutoresizingMaskIntoConstraints = false
        superView.addConstraint(NSLayoutConstraint(item: v, attribute: .top, relatedBy: .equal, toItem: superView, attribute: .top, multiplier: 1, constant: 0))
        superView.addConstraint(NSLayoutConstraint(item: v, attribute: .left, relatedBy: .equal, toItem: superView, attribute: .left, multiplier: 1, constant: 0))
    }
}
