//
//  Helper.swift
//  QuickNote
//
//  Created by Khanh Tran on 21/12/2023.
//

import Foundation

struct Helper {
    static func randomColorString() -> String {
        let randomInt = Int.random(in: 1..<50)
        switch randomInt {
        case 0..<10:
            return "color_3dd5f0"
        case 10..<20:
            return "color_64f2a4"
        case 20..<30:
            return "color_f8edeb"
        case 30..<40:
            return "color_f9e2c5"
        default:
            return "color_ffe4e1"
        }
    }
}
