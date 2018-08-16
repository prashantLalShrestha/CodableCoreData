//
//  Theme.swift
//  CoreDatabestPractices
//
//  Created by Prashant Shrestha on 6/19/18.
//  Copyright © 2018 Prashant. All rights reserved.
//

import UIKit

class Theme {
    static let mainFontName = "Helvetica-Neue"
    static let smallFontSize: CGFloat = 15
    static let mediumFontSize: CGFloat = 17
    static let largeFontSize: CGFloat = 20
    static let extralargeFontSize: CGFloat = 22
    
    static let accent = UIColor(named: "Accent")
    static let background = UIColor(named: "Background")
    static let tint = UIColor(named: "Tint")
    
    static let minGap = 8
    static let mediumgap = 16
    static let maxGap = 32
}

private var materialKey = false

extension UIView {
    
    @IBInspectable var materialDesign: Bool {
        
        get {
            return materialKey
        }
        set {
            materialKey = newValue
            
            if materialKey {
                self.layer.masksToBounds = false
                self.layer.cornerRadius = 3.0
                self.layer.shadowOpacity = 0.8
                self.layer.shadowRadius = 3.0
                self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
                self.layer.shadowColor = UIColor(red: 157/255, green: 157/255, blue: 157/255, alpha: 1.0).cgColor
            } else {
                self.layer.cornerRadius = 0
                self.layer.shadowOpacity = 0
                self.layer.shadowRadius = 0
                self.layer.shadowColor = nil
            }
        }
        
        
    }
    
}

private var themeKey = true

extension UILabel {
    @IBInspectable var enableTheme: Bool {
        get {
            return themeKey
        }
        set {
            themeKey = newValue
            
            if themeKey {
                self.font = UIFont(name: Theme.mainFontName, size: Theme.mediumFontSize)
            }
        }
    }
}


extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        /** Verify that we have valid values */
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    /** Initializes and sets color by hex value */
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
    
}
