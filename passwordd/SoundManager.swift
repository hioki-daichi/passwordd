//
//  SoundManager.swift
//  passwordd
//
//  Created by 日置大智 on 2015/04/30.
//  Copyright (c) 2015年 hiokidaichi. All rights reserved.
//

import Foundation
import AudioToolbox

public struct SoundManager {
    public static func setup() {
        setSoundID(KeyCode.Num1, filename: "Num1")
        setSoundID(KeyCode.Num2, filename: "Num2")
        setSoundID(KeyCode.Num3, filename: "Num3")
        setSoundID(KeyCode.Num4, filename: "Num4")
        setSoundID(KeyCode.Num5, filename: "Num5")
        setSoundID(KeyCode.Num6, filename: "Num6")
        setSoundID(KeyCode.Num7, filename: "Num7")
        setSoundID(KeyCode.Num8, filename: "Num8")
        setSoundID(KeyCode.Num9, filename: "Num9")
        setSoundID(KeyCode.Num0, filename: "Num0")
        setSoundID(KeyCode.Hyphen, filename: "Hyphen")
        setSoundID(KeyCode.q, filename: "q")
        setSoundID(KeyCode.w, filename: "w")
        setSoundID(KeyCode.e, filename: "e")
        setSoundID(KeyCode.r, filename: "r")
        setSoundID(KeyCode.t, filename: "t")
        setSoundID(KeyCode.y, filename: "y")
        setSoundID(KeyCode.u, filename: "u")
        setSoundID(KeyCode.i, filename: "i")
        setSoundID(KeyCode.o, filename: "o")
        setSoundID(KeyCode.p, filename: "p")
        setSoundID(KeyCode.a, filename: "a")
        setSoundID(KeyCode.s, filename: "s")
        setSoundID(KeyCode.d, filename: "d")
        setSoundID(KeyCode.f, filename: "f")
        setSoundID(KeyCode.g, filename: "g")
        setSoundID(KeyCode.h, filename: "h")
        setSoundID(KeyCode.j, filename: "j")
        setSoundID(KeyCode.k, filename: "k")
        setSoundID(KeyCode.l, filename: "l")
        setSoundID(KeyCode.Semicolon, filename: "Semicolon")
        setSoundID(KeyCode.z, filename: "z")
        setSoundID(KeyCode.x, filename: "x")
        setSoundID(KeyCode.c, filename: "c")
        setSoundID(KeyCode.v, filename: "v")
        setSoundID(KeyCode.b, filename: "b")
        setSoundID(KeyCode.n, filename: "n")
        setSoundID(KeyCode.m, filename: "m")
        setSoundID(KeyCode.Comma, filename: "Comma")
        setSoundID(KeyCode.Dot, filename: "Dot")
        setSoundID(KeyCode.Slash, filename: "Slash")

        switch MyUserDefaults.sharedInstance.keyboardType {
        case .JIS:
            // only JIS
            setSoundID(KeyCode.Backslash, filename: "Backslash")
            setSoundID(KeyCode.BracketRight, filename: "BracketRight")
            setSoundID(KeyCode.Underscore, filename: "Underscore")

            setSoundID(KeyCode.Hat, filename: "Hat") // ^ or =
            setSoundID(KeyCode.Atmark, filename: "Atmark") // @ or [
            setSoundID(KeyCode.BracketLeft, filename: "BracketLeft") // [ or ]
            setSoundID(KeyCode.Colon, filename: "Colon") // : or '
        case .US:
            // only US
            setSoundID(KeyCode.USBackquote, filename: "Num1") // 音声データがないため隣のキーの 1 で代用する
            setSoundID(KeyCode.Backslash, filename: "BracketLeft") // 音声データがないため隣の ] の音に当たる JIS でいう [ で代用する

            setSoundID(KeyCode.USEqual, filename: "Hat") // ^ or =
            setSoundID(KeyCode.BracketLeft, filename: "Atmark") // @ or [
            setSoundID(KeyCode.BracketRight, filename: "BracketLeft") // [ or ]
            setSoundID(KeyCode.USSinglequote, filename: "Colon") // : or '
        }
    }

    public static func play(keyCode: KeyCode) {
        if let soundID = soundIDOfKeyCodeDisplayString[keyCode.displayString()] {
            AudioServicesPlaySystemSound(soundID)
        }
    }

    public static func vibrate() {
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
    }

    private static var soundIDOfKeyCodeDisplayString = [String: SystemSoundID]()

    private static func setSoundID(keyCode: KeyCode, filename: String) {
        var soundID: SystemSoundID = 0
        var soundURL: NSURL = NSBundle.mainBundle().URLForResource("Resource/" + filename, withExtension: "caf")!
        AudioServicesCreateSystemSoundID(soundURL as CFURLRef, &soundID)
        soundIDOfKeyCodeDisplayString[keyCode.displayString()] = soundID
    }
}
