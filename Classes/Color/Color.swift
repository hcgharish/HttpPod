//
//  Color.swift
//  HarishFrameworkSwift4
//
//  Created by Harish on 11/01/18.
//  Copyright © 2018 Harish. All rights reserved.
//
import UIKit
class Color1: UIColor {
}
public extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
            self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    convenience init(netHex: Int) {
        self.init(red: (netHex >> 16) & 0xff, green: (netHex >> 8) & 0xff, blue: netHex & 0xff)
    }
    class func hexColor(_ rgb: UInt32, alpha: Double=1.0) -> UIColor {
        let red = CGFloat((rgb & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgb & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgb & 0xFF)/256.0
            return UIColor(red: red, green: green, blue: blue, alpha: CGFloat(alpha))
    }
}

extension UIColor {
    class var appBlack: UIColor {
        return UIColor(displayP3Red: 36/255, green: 40/255, blue: 51/255, alpha: 1)
    }
    
    class var appRed: UIColor {
        return UIColor(displayP3Red: 248/255, green: 107/255, blue: 106/255, alpha: 1)
    }
    
    class var appGreen: UIColor {
        return UIColor(displayP3Red: 40/255, green: 216/255, blue: 161/255, alpha: 1)
    }
    
    class var appBlue: UIColor {
        return UIColor(displayP3Red: 53/255, green: 147/255, blue: 228/255, alpha: 1)
    }
    
    class var appOrange: UIColor {
        return UIColor(displayP3Red: 255/255, green: 152/255, blue: 0/255, alpha: 1)
    }
}

func Color (_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat) -> UIColor {
    return UIColor(displayP3Red: red/255, green: green/255, blue: blue/255, alpha: 1)
}

enum CellName {
    case Cell_OrderDetailDetail
    case UpCell
    case Cell_InHomeYorHero1
    case Cell_InHomeYorHero2
    case Cell_InHomeYorHero3
    case Cell_InHomeYorHero4
    case Cell_JobReport
    case Cell_WarrantyTimer
    case Cell_OrderDetailCancelled_Refund
    case Cell_ExpandText
    case Cell_RequestSent
    case Cell_InDispute
    case none
}

class UpData: NSObject {
    var colorTitleClosed: UIColor? = .appBlack
    var colorInfoClosed: UIColor? = .appBlack
    
    var fontTitleClosed: UIFont? = UIFont(name: "HelveticaNeue-Bold", size: 16)!
    var fontInfoClosed: UIFont? = UIFont(name: "HelveticaNeue", size: 12)!
    
    var colorTitle: UIColor?// = .appBlack
    var colorInfo: UIColor?// = .appBlack
    
    var fontTitle: UIFont?// = UIFont(name: "HelveticaNeue-Light", size: 14)!
    var fontInfo: UIFont?// = UIFont(name: "HelveticaNeue-Light", size: 14)!
    
    var title: String!
    var time: String!
    var disc: String!
    
    var leading: CGFloat = 16
    
    var parentIndex = -1
    
    var data: NSDictionary!
    var paerntData: NSDictionary!
    var isYorHero: Bool? = nil
    
    var idParent = 0
    var hasChilds = false
    var isOpen = true
    var cellHeightOpen: CGFloat! = -1.0
    var cellHeightClose: CGFloat! = 74.0
    var cellName: CellName = .none
    
    init(color: UIColor, title: String, time: String, _ isOpen: Bool = true) {
        self.colorTitle = color
        self.title = title
        self.time = time
        self.isOpen = isOpen
    }
}
