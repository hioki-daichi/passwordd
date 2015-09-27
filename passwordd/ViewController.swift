//
//  ViewController.swift
//  passwordd
//
//  Created by 日置大智 on 2015/04/25.
//  Copyright (c) 2015年 hiokidaichi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "didBecomeActive:", name: "applicationDidBecomeActive", object: nil)

        setKeyboardUnitViewLabel()
        SoundManager.setup()

        speedButton.setTitle(MyUserDefaults.sharedInstance.speed.title(), forState: .Normal)
        speedButton.setTitleColor(UIColor(red: 210/255.0, green: 210/255.0, blue: 210/255.0, alpha: 1), forState: .Disabled)

        keyboardUnitWidthConstraint.constant = KeyboardUnitView.width
        passwordPanelLabelWidthConstraint.constant = PasswordPanelLabel.width

        switch MyUserDefaults.sharedInstance.keyboardType {
        case .JIS:
            usBackquoteViewWidthConstraint.constant = 0
            usBackquoteView.hidden = true
            usBackslashView.hidden = true
            backslashViewWidthConstraint.constant = keyboardUnitWidthConstraint.constant

            if UIDevice.deviceType == .iPad {
                row0Margin.constant = 20
                row1Margin.constant = 20
            } else {
                row0Margin.constant = 10
                row1Margin.constant = 10
            }
        case .US:
            usBackquoteViewWidthConstraint.constant = keyboardUnitWidthConstraint.constant
            backslashViewWidthConstraint.constant = 0
            backslashView.hidden = true
            bracketRightView.hidden = true
            underscoreView.hidden = true

            if UIDevice.deviceType == .iPad {
                row0Margin.constant = 70
                row1Margin.constant = -70
            } else {
                row0Margin.constant = 30
                row1Margin.constant = -25
            }
        }

        refreshPassword()
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)

        for touch: UITouch in touches {
            if let v = touch.view {
                if v.tag == 1 {
                    let passwordPanelLabel = v as! PasswordPanelLabel
                    passwordPanelLabel.highlightColor()

                    if let keyCode = passwordPanelLabel.keyCode {
                        getKeyboardUnitView(keyCode).highlightColor()
                        SoundManager.play(keyCode)
                    }
                }
            }
        }
    }

    func didBecomeActive(notification: NSNotification) {
        if let receivedPassword = KeyCode.receivedKeyCodes {
            currentPassword = receivedPassword
            setPasswordPanelLabel(currentPassword)
        }
    }

    @IBOutlet weak var keyboardUnitWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var passwordPanelLabelWidthConstraint: NSLayoutConstraint!

    @IBOutlet weak var settingsButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet private weak var playButton: UIButton!
    @IBOutlet private weak var speedButton: UIButton!
    @IBOutlet private weak var row0Margin: NSLayoutConstraint!
    @IBOutlet private weak var row1Margin: NSLayoutConstraint!

    private var currentPassword: [KeyCode]!

    @IBAction private func refreshButton(sender: AnyObject) {
        refreshPassword()
    }

    @IBAction private func playButton(sender: AnyObject) {
        playButton.enabled = false
        refreshButton.enabled = false
        shareButton.enabled = false
        settingsButton.enabled = false
        speedButton.enabled = false
        playIndex = 0
        play(currentPassword[0]) {
            self.play(self.currentPassword[1]) {
                self.play(self.currentPassword[2]) {
                    self.play(self.currentPassword[3]) {
                        self.play(self.currentPassword[4]) {
                            self.play(self.currentPassword[5]) {
                                self.play(self.currentPassword[6]) {
                                    self.play(self.currentPassword[7]) {
                                        self.play(self.currentPassword[8]) {
                                            self.play(self.currentPassword[9]) {
                                                self.play(self.currentPassword[10]) {
                                                    self.play(self.currentPassword[11]) {
                                                        self.play(self.currentPassword[12]) {
                                                            self.play(self.currentPassword[13]) {
                                                                self.play(self.currentPassword[14]) {
                                                                    self.play(self.currentPassword[15]) {
                                                                        self.playButton.enabled = true
                                                                        self.refreshButton.enabled = true
                                                                        self.shareButton.enabled = true
                                                                        self.settingsButton.enabled = true
                                                                        self.speedButton.enabled = true
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    private func refreshPassword() {
        currentPassword = KeyCode.generateRandomKeycodes()
        setPasswordPanelLabel(currentPassword)
    }

    private func play(keyCode: KeyCode, block: () -> ()) {
        switch playIndex {
        case 0:
            passwordPanelLabel0.highlightColor()
        case 1:
            passwordPanelLabel1.highlightColor()
        case 2:
            passwordPanelLabel2.highlightColor()
        case 3:
            passwordPanelLabel3.highlightColor()
        case 4:
            passwordPanelLabel4.highlightColor()
        case 5:
            passwordPanelLabel5.highlightColor()
        case 6:
            passwordPanelLabel6.highlightColor()
        case 7:
            passwordPanelLabel7.highlightColor()
        case 8:
            passwordPanelLabel8.highlightColor()
        case 9:
            passwordPanelLabel9.highlightColor()
        case 10:
            passwordPanelLabel10.highlightColor()
        case 11:
            passwordPanelLabel11.highlightColor()
        case 12:
            passwordPanelLabel12.highlightColor()
        case 13:
            passwordPanelLabel13.highlightColor()
        case 14:
            passwordPanelLabel14.highlightColor()
        case 15:
            passwordPanelLabel15.highlightColor()
        default:
            break
        }

        let keyboardUnitView = getKeyboardUnitView(keyCode)
        keyboardUnitView.highlightColor()

        SoundManager.play(keyCode)

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, MyUserDefaults.sharedInstance.speed.delay()), dispatch_get_main_queue()) {
            keyboardUnitView.resetColor()
            block()
        }

        playIndex++
    }

    @IBAction private func shareButton(sender: AnyObject) {
        let textToShare = currentPassword.map { $0.rawValue }.joinWithSeparator("")

        let activityViewController = UIActivityViewController(activityItems: [textToShare], applicationActivities: nil)

        // iPad 対応
        if let popoverPresentationController = activityViewController.popoverPresentationController {
            popoverPresentationController.sourceView = view
            popoverPresentationController.sourceRect = CGRect(x: view.frame.width / 2, y: view.frame.height, width: 0, height: 0)
        }

        self.presentViewController(activityViewController, animated: true, completion: nil)
    }

    @IBAction func speedButton(sender: AnyObject) {
        MyUserDefaults.sharedInstance.speed = MyUserDefaults.sharedInstance.speed.next()
        speedButton.setTitle(MyUserDefaults.sharedInstance.speed.title(), forState: .Normal)
    }

    // MARK: - PasswordPanelLabel
    @IBOutlet weak private var passwordPanelLabel0: PasswordPanelLabel!
    @IBOutlet weak private var passwordPanelLabel1: PasswordPanelLabel!
    @IBOutlet weak private var passwordPanelLabel2: PasswordPanelLabel!
    @IBOutlet weak private var passwordPanelLabel3: PasswordPanelLabel!
    @IBOutlet weak private var passwordPanelLabel4: PasswordPanelLabel!
    @IBOutlet weak private var passwordPanelLabel5: PasswordPanelLabel!
    @IBOutlet weak private var passwordPanelLabel6: PasswordPanelLabel!
    @IBOutlet weak private var passwordPanelLabel7: PasswordPanelLabel!
    @IBOutlet weak private var passwordPanelLabel8: PasswordPanelLabel!
    @IBOutlet weak private var passwordPanelLabel9: PasswordPanelLabel!
    @IBOutlet weak private var passwordPanelLabel10: PasswordPanelLabel!
    @IBOutlet weak private var passwordPanelLabel11: PasswordPanelLabel!
    @IBOutlet weak private var passwordPanelLabel12: PasswordPanelLabel!
    @IBOutlet weak private var passwordPanelLabel13: PasswordPanelLabel!
    @IBOutlet weak private var passwordPanelLabel14: PasswordPanelLabel!
    @IBOutlet weak private var passwordPanelLabel15: PasswordPanelLabel!

    private var playIndex: Int = 0

    private func setPasswordPanelLabel(keyCodes: [KeyCode]) {
        passwordPanelLabel0.setup(keyCodes[0])
        passwordPanelLabel1.setup(keyCodes[1])
        passwordPanelLabel2.setup(keyCodes[2])
        passwordPanelLabel3.setup(keyCodes[3])
        passwordPanelLabel4.setup(keyCodes[4])
        passwordPanelLabel5.setup(keyCodes[5])
        passwordPanelLabel6.setup(keyCodes[6])
        passwordPanelLabel7.setup(keyCodes[7])
        passwordPanelLabel8.setup(keyCodes[8])
        passwordPanelLabel9.setup(keyCodes[9])
        passwordPanelLabel10.setup(keyCodes[10])
        passwordPanelLabel11.setup(keyCodes[11])
        passwordPanelLabel12.setup(keyCodes[12])
        passwordPanelLabel13.setup(keyCodes[13])
        passwordPanelLabel14.setup(keyCodes[14])
        passwordPanelLabel15.setup(keyCodes[15])
    }

    // MARK: - KeyboardUnitView
    // 1段目
    @IBOutlet weak var usBackquoteView: KeyboardUnitView!
    @IBOutlet weak var usBackquoteViewWidthConstraint: NSLayoutConstraint!

    @IBOutlet weak var num1View: KeyboardUnitView!
    @IBOutlet weak var num2View: KeyboardUnitView!
    @IBOutlet weak var num3View: KeyboardUnitView!
    @IBOutlet weak var num4View: KeyboardUnitView!
    @IBOutlet weak var num5View: KeyboardUnitView!
    @IBOutlet weak var num6View: KeyboardUnitView!
    @IBOutlet weak var num7View: KeyboardUnitView!
    @IBOutlet weak var num8View: KeyboardUnitView!
    @IBOutlet weak var num9View: KeyboardUnitView!
    @IBOutlet weak var num0View: KeyboardUnitView!
    @IBOutlet weak var hyphenView: KeyboardUnitView!
    @IBOutlet weak var hatView: KeyboardUnitView!
    @IBOutlet weak var backslashView: KeyboardUnitView!
    @IBOutlet weak var backslashViewWidthConstraint: NSLayoutConstraint!


    // 2段目
    @IBOutlet weak var qView: KeyboardUnitView!
    @IBOutlet weak var wView: KeyboardUnitView!
    @IBOutlet weak var eView: KeyboardUnitView!
    @IBOutlet weak var rView: KeyboardUnitView!
    @IBOutlet weak var tView: KeyboardUnitView!
    @IBOutlet weak var yView: KeyboardUnitView!
    @IBOutlet weak var uView: KeyboardUnitView!
    @IBOutlet weak var iView: KeyboardUnitView!
    @IBOutlet weak var oView: KeyboardUnitView!
    @IBOutlet weak var pView: KeyboardUnitView!
    @IBOutlet weak var atmarkView: KeyboardUnitView!
    @IBOutlet weak var bracketLeftView: KeyboardUnitView!

    @IBOutlet weak var usBackslashView: KeyboardUnitView!


    // 3段目
    @IBOutlet weak var aView: KeyboardUnitView!
    @IBOutlet weak var sView: KeyboardUnitView!
    @IBOutlet weak var dView: KeyboardUnitView!
    @IBOutlet weak var fView: KeyboardUnitView!
    @IBOutlet weak var gView: KeyboardUnitView!
    @IBOutlet weak var hView: KeyboardUnitView!
    @IBOutlet weak var jView: KeyboardUnitView!
    @IBOutlet weak var kView: KeyboardUnitView!
    @IBOutlet weak var lView: KeyboardUnitView!
    @IBOutlet weak var semicolonView: KeyboardUnitView!
    @IBOutlet weak var colonView: KeyboardUnitView!
    @IBOutlet weak var bracketRightView: KeyboardUnitView!

    // 4段目
    @IBOutlet weak var zView: KeyboardUnitView!
    @IBOutlet weak var xView: KeyboardUnitView!
    @IBOutlet weak var cView: KeyboardUnitView!
    @IBOutlet weak var vView: KeyboardUnitView!
    @IBOutlet weak var bView: KeyboardUnitView!
    @IBOutlet weak var nView: KeyboardUnitView!
    @IBOutlet weak var mView: KeyboardUnitView!
    @IBOutlet weak var commaView: KeyboardUnitView!
    @IBOutlet weak var dotView: KeyboardUnitView!
    @IBOutlet weak var slashView: KeyboardUnitView!
    @IBOutlet weak var underscoreView: KeyboardUnitView!

    private func setKeyboardUnitViewLabel() {
        num1View.setup(KeyCode.Num1)
        num2View.setup(KeyCode.Num2)
        num3View.setup(KeyCode.Num3)
        num4View.setup(KeyCode.Num4)
        num5View.setup(KeyCode.Num5)
        num6View.setup(KeyCode.Num6)
        num7View.setup(KeyCode.Num7)
        num8View.setup(KeyCode.Num8)
        num9View.setup(KeyCode.Num9)
        num0View.setup(KeyCode.Num0)
        hyphenView.setup(KeyCode.Hyphen)
        qView.setup(KeyCode.q)
        wView.setup(KeyCode.w)
        eView.setup(KeyCode.e)
        rView.setup(KeyCode.r)
        tView.setup(KeyCode.t)
        yView.setup(KeyCode.y)
        uView.setup(KeyCode.u)
        iView.setup(KeyCode.i)
        oView.setup(KeyCode.o)
        pView.setup(KeyCode.p)
        aView.setup(KeyCode.a)
        sView.setup(KeyCode.s)
        dView.setup(KeyCode.d)
        fView.setup(KeyCode.f)
        gView.setup(KeyCode.g)
        hView.setup(KeyCode.h)
        jView.setup(KeyCode.j)
        kView.setup(KeyCode.k)
        lView.setup(KeyCode.l)
        semicolonView.setup(KeyCode.Semicolon)
        zView.setup(KeyCode.z)
        xView.setup(KeyCode.x)
        cView.setup(KeyCode.c)
        vView.setup(KeyCode.v)
        bView.setup(KeyCode.b)
        nView.setup(KeyCode.n)
        mView.setup(KeyCode.m)
        commaView.setup(KeyCode.Comma)
        dotView.setup(KeyCode.Dot)
        slashView.setup(KeyCode.Slash)

        switch MyUserDefaults.sharedInstance.keyboardType {
        case .JIS:
            // only JIS
            backslashView.setup(KeyCode.Backslash)
            bracketRightView.setup(KeyCode.BracketRight)
            underscoreView.setup(KeyCode.Underscore)

            hatView.setup(KeyCode.Hat) // ^ or =
            atmarkView.setup(KeyCode.Atmark) // @ or [
            bracketLeftView.setup(KeyCode.BracketLeft) // [ or ]
            colonView.setup(KeyCode.Colon) // : or '
        case .US:
            // only US
            usBackquoteView.setup(KeyCode.USBackquote)
            usBackslashView.setup(KeyCode.Backslash)

            hatView.setup(KeyCode.USEqual) // ^ or =
            atmarkView.setup(KeyCode.BracketLeft) // @ or [
            bracketLeftView.setup(KeyCode.BracketRight) // [ or ]
            colonView.setup(KeyCode.USSinglequote) // : or '
        }
    }

    private func getKeyboardUnitView(keyCode: KeyCode) -> KeyboardUnitView {
        switch keyCode {
        case .Num1:
            return num1View
        case .Num2:
            return num2View
        case .Num3:
            return num3View
        case .Num4:
            return num4View
        case .Num5:
            return num5View
        case .Num6:
            return num6View
        case .Num7:
            return num7View
        case .Num8:
            return num8View
        case .Num9:
            return num9View
        case .Num0:
            return num0View
        case .Hyphen:
            return hyphenView
        case .Hat:
            return hatView
        case .Backslash:
            return backslashView
        case .q:
            return qView
        case .w:
            return wView
        case .e:
            return eView
        case .r:
            return rView
        case .t:
            return tView
        case .y:
            return yView
        case .u:
            return uView
        case .i:
            return iView
        case .o:
            return oView
        case .p:
            return pView
        case .Atmark:
            return atmarkView
        case .BracketLeft:
            return bracketLeftView
        case .a:
            return aView
        case .s:
            return sView
        case .d:
            return dView
        case .f:
            return fView
        case .g:
            return gView
        case .h:
            return hView
        case .j:
            return jView
        case .k:
            return kView
        case .l:
            return lView
        case .Semicolon:
            return semicolonView
        case .Colon:
            return colonView
        case .BracketRight:
            return bracketRightView
        case .z:
            return zView
        case .x:
            return xView
        case .c:
            return cView
        case .v:
            return vView
        case .b:
            return bView
        case .n:
            return nView
        case .m:
            return mView
        case .Comma:
            return commaView
        case .Dot:
            return dotView
        case .Slash:
            return slashView
        case .Underscore:
            return underscoreView
        case .USBackquote:
            return usBackquoteView
        case .USEqual:
            return hatView // XXX
        case .USSinglequote:
            return colonView // XXX
        }
    }
}

