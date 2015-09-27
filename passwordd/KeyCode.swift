//
//  KeyCode.swift
//  passwordd
//
//  Created by 日置大智 on 2015/05/04.
//  Copyright (c) 2015年 hiokidaichi. All rights reserved.
//

import Foundation

public enum KeyCode: String {
    case Num1         = "1"
    case Num2         = "2"
    case Num3         = "3"
    case Num4         = "4"
    case Num5         = "5"
    case Num6         = "6"
    case Num7         = "7"
    case Num8         = "8"
    case Num9         = "9"
    case Num0         = "0"
    case Hyphen       = "-"
    case Hat          = "^"
    case Backslash    = "\\"
    case q            = "q"
    case w            = "w"
    case e            = "e"
    case r            = "r"
    case t            = "t"
    case y            = "y"
    case u            = "u"
    case i            = "i"
    case o            = "o"
    case p            = "p"
    case Atmark       = "@"
    case BracketLeft  = "["
    case a            = "a"
    case s            = "s"
    case d            = "d"
    case f            = "f"
    case g            = "g"
    case h            = "h"
    case j            = "j"
    case k            = "k"
    case l            = "l"
    case Semicolon    = ";"
    case Colon        = ":"
    case BracketRight = "]"
    case z            = "z"
    case x            = "x"
    case c            = "c"
    case v            = "v"
    case b            = "b"
    case n            = "n"
    case m            = "m"
    case Comma        = ","
    case Dot          = "."
    case Slash        = "/"
    case Underscore   = "_"
    case USBackquote  = "`"
    case USSinglequote = "'"
    case USEqual      = "="

    public static let allValues: [KeyCode] = {
        var ret = [KeyCode]([.Num1, .Num2, .Num3, .Num4, .Num5, .Num6, .Num7, .Num8, .Num9, .Num0, .Hyphen, .Backslash, .q, .w, .e, .r, .t, .y, .u, .i, .o, .p, .Atmark, .BracketLeft, .a, .s, .d, .f, .g, .h, .j, .k, .l, .Semicolon, .BracketRight, .z, .x, .c, .v, .b, .n, .m, .Comma, .Dot, .Slash])

        switch MyUserDefaults.sharedInstance.keyboardType {
        case .JIS:
            ret += [KeyCode]([.Hat, .Colon, .Underscore])
        case .US:
            ret += [KeyCode]([.USBackquote, .USEqual, .USSinglequote])
        }

        return ret
        }()

    public static let alphabetL =  [KeyCode](
        [.q, .w, .e, .r, .t, .a, .s, .d, .f, .g, .z, .x, .c, .v, .b]
    )

    public static let alphabetR = [KeyCode](
        [.y, .u, .i, .o, .p, .h, .j, .k, .l, .n, .m]
    )

    public static let numberL = [KeyCode](
        [.Num1, .Num2, .Num3, .Num4, .Num5]
    )

    public static let numberR = [KeyCode](
        [.Num6, .Num7, .Num8, .Num9, .Num0]
    )

    public static let signL: [KeyCode] = {
        switch MyUserDefaults.sharedInstance.keyboardType {
        case .JIS:
            return []
        case .US:
            return [.USBackquote]
        }
        }()

    public static let signR: [KeyCode] = {
        switch MyUserDefaults.sharedInstance.keyboardType {
        case .JIS:
            return [.Hyphen, .Hat, .Backslash, .Atmark, .BracketLeft, .Semicolon, .Colon, .BracketRight, .Comma, .Dot, .Slash]
        case .US:
            return [.Hyphen, .USEqual, .BracketLeft, .BracketRight, .Backslash, .Semicolon, .USSinglequote, .Comma, .Dot]
        }
        }()

    public static func generateRandomKeycodes() -> [KeyCode] {
        var filterL: KeyCode -> Bool = { KeyCode.alphabetL.contains($0) },
            filterR: KeyCode -> Bool = { KeyCode.alphabetR.contains($0) }

        if MyUserDefaults.sharedInstance.includeNumber {
            var _filterL = filterL,
                _filterR = filterR
            filterL = { _filterL($0) || KeyCode.numberL.contains($0) }
            filterR = { _filterR($0) || KeyCode.numberR.contains($0) }
        }

        if MyUserDefaults.sharedInstance.includeLowerCaseSign {
            var _filterL = filterL,
                _filterR = filterR
            filterL = { _filterL($0) || KeyCode.signL.contains($0) }
            filterR = { _filterR($0) || KeyCode.signR.contains($0) }
        }

        let array = KeyCode.allValues,
            arrayL = array.filter { filterL($0) },
            arrayR = array.filter { filterR($0) }

        let numberOfAvailableFingerL = Finger.allValues.filter { $0.isAllowedL() }.count
        let numberOfAvailableFingerR = Finger.allValues.filter { $0.isAllowedR() }.count

        var rtn = [KeyCode]()

        var fingersL: [Finger] = [Finger]()
        var fingersR: [Finger] = [Finger]()

        for n in 1...8 {
            // 左手
            var sampleL = getSampleL(arrayL)
            if n <= numberOfAvailableFingerL {
                while fingersL.contains(sampleL.finger()) {
                    sampleL = getSampleL(arrayL)
                }
            } else {
                while sampleL.finger() != fingersL[(n - 1) % numberOfAvailableFingerL] {
                    sampleL = getSampleL(arrayL)
                }
            }
            fingersL += [sampleL.finger()]

            // 右手
            var sampleR = getSampleR(arrayR)
            if n <= numberOfAvailableFingerR {
                while fingersR.contains(sampleR.finger()) {
                    sampleR = getSampleR(arrayR)
                }
            } else {
                while sampleR.finger() != fingersR[(n - 1) % numberOfAvailableFingerR] {
                    sampleR = getSampleR(arrayR)
                }
            }
            fingersR += [sampleR.finger()]


            rtn += [sampleL, sampleR]
        }

        return rtn
    }



    public static var receivedKeyCodes: [KeyCode]?

    // passwordd://?q=xuapfkdpboxjrpao などで指定された文字列がすべて正しく [KeyCode] に変換できる場合は変換して返す
    public static func setReceivedKeyCodesFromString(q: String) {
        var keyCodes = [KeyCode]()

        for c in q.characters {
            if let keyCode = KeyCode(rawValue: String(c)) {
                keyCodes.append(keyCode)
            }
        }

        if keyCodes.count == 16 {
            receivedKeyCodes = keyCodes
        }
    }

    private static func getSampleL(keyCodes: [KeyCode]) -> KeyCode {
        var ret = keyCodes.sample()
        repeat { ret = keyCodes.sample() } while !ret.finger().isAllowedL()
        return ret
    }

    private static func getSampleR(keyCodes: [KeyCode]) -> KeyCode {
        var ret = keyCodes.sample()
        repeat { ret = keyCodes.sample() } while !ret.finger().isAllowedR()
        return ret
    }

    public func displayString() -> String {
        return rawValue
    }

    public func finger() -> Finger {
        switch self {
        case .Num4, .r, .f, .v, .Num5, .t, .g, .b, .Num6, .y, .h, .n, .Num7, .u, .j, .m:
            return .Index
        case .Num3, .e, .d, .c, .Num8, .i, .k, .Comma:
            return .Middle
        case .Num2, .w, .s, .x, .Num9, .o, .l, .Dot:
            return .Ring
        case .Num1, .q, .a, .z, .Num0, .p, .Semicolon, .Slash, .Hyphen, .Atmark, .Colon, .Underscore, .Hat, .BracketLeft, .BracketRight, .Backslash, .USBackquote, .USEqual, .USSinglequote:
            return .Pinkie
        }
    }
}
