//
//  Extensions.swift
//  zero12-gaming
//
//  Created by Michele Massaro on 13/06/2018.
//  Copyright © 2018 zero12. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    static let cnpPurple = UIColor(red: 215 / 255.0, green: 0 / 255.0, blue: 100 / 255.0, alpha: 1)
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
    
    convenience init(hex: Int) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF
        )
    }
    
    convenience init?(hexString: String?) {
        guard let hexString = hexString else {
            return nil
        }
        
        let count = hexString.count
        if !([4, 7, 9].contains(count)) {
            return nil
        }
        
        let first = hexString[..<hexString.index(hexString.startIndex, offsetBy: 1)]
        if first != "#" {
            return nil
        }
        
        let rgb: String
        if hexString.count == 9 {
            rgb = String(hexString[hexString.index(hexString.startIndex, offsetBy: 3)...])
        } else {
            rgb = hexString
        }
        
        let scanner = Scanner.init(string: rgb)
        scanner.scanLocation = 1
        
        var value: UInt32 = 0
        scanner.scanHexInt32(&value)
        
        if hexString.count == 7 {
            let blue = CGFloat(value % 256) / 255.0
            let green = CGFloat((value >> 8) % 256) / 255.0
            let red = CGFloat(value >> 16) / 255.0
            self.init(red: red, green: green, blue: blue, alpha: 1)
        } else {// sono 4 caratteri
            let blue = CGFloat(value % 16) / 255.0
            let green = CGFloat((value >> 4) % 16) / 255.0
            let red = CGFloat(value >> 8) / 255.0
            self.init(red: red, green: green, blue: blue, alpha: 1)
        }
    }
}
