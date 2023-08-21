//
//  View.swift
//  HarishFrameworkSwift4
//
//  Created by Harish on 11/01/18.
//  Copyright © 2018 Harish. All rights reserved.
//

import UIKit

open class View: UIView, LayoutParameters {
    var classPara: ClassPara = ClassPara()
    @IBInspectable open var isBorder: Bool = false
    @IBInspectable open var border: Int = 0
    @IBInspectable open var radious: Int = 0
    @IBInspectable open var borderColor: UIColor?
    @IBInspectable open var isShadow: Bool = false
    @IBInspectable open var shadowCColor: UIColor?
    @IBInspectable open var lsOpacity: CGFloat = 0.5
    @IBInspectable open var lsRadius: Int = 0
    @IBInspectable open var lsOffWidth: CGFloat = 2.0
    @IBInspectable open var lsOffHeight: CGFloat = 2.0
    @IBInspectable open var isStrokeColor: Bool = false
    override open func draw(_ rect: CGRect) {
        if isStrokeColor {
            strokeColor()
        }
    }
    var shadowLayer: CAShapeLayer!
    override open func layoutSubviews() {
        super.layoutSubviews()
        shadowCColor = UIColor.darkGray
        let obb = ClassPara ()
        obb.shadowLayer = shadowLayer
        obb.backgroundColor = backgroundColor
        obb.layer = layer
        classPara = obb
        layoutSubviews (self)
    }
}
public extension UIView {
    func border (_ color: UIColor?, _ cornerRadius: CGFloat, _ borderWidth: CGFloat) {
        self.layer.masksToBounds = true
        if color != nil {
            self.layer.borderColor = color?.cgColor
        }
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
    }
    func shadowSubViews () {
        self.backgroundColor = UIColor.clear
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.layer.shadowOpacity = 0.7
        self.layer.shadowRadius = 4.0
        let borderView = UIView()
        borderView.frame = self.bounds
        borderView.layer.cornerRadius = 10
        borderView.layer.borderColor = UIColor.black.cgColor
        borderView.layer.borderWidth = 1.0
        borderView.layer.masksToBounds = true
        self.addSubview(borderView)
        let otherSubContent = UIImageView()
        otherSubContent.frame = borderView.bounds
        borderView.addSubview(otherSubContent)
    }
    func shadow () {
        self.layer.shadowColor = UIColor.hexColor(0x2C3237).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 0.0
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 4.0
    }
    func shadow1r () {
        self.layer.shadowColor = UIColor.hexColor(0x2C3237).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 0.0
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 0.0
    }
    func shadow0r () {
        self.layer.shadowColor = UIColor.hexColor(0x2C3237).withAlphaComponent(0.5).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 3
        
        let device = UIScreen.main.bounds
        
        var frame = self.bounds
        frame.origin.x = -10
        frame.size.width = device.size.width + 20
        
        self.layer.shadowPath = UIBezierPath(rect: frame).cgPath
    }
    func shadow2r (_ width: CGFloat, _ height: CGFloat) {
        self.layer.shadowColor = UIColor.hexColor(0x2C3237).withAlphaComponent(0.2).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 16
        
        var frame = self.bounds
        frame.origin.x = 15
        frame.origin.y = 15
        frame.size.width = width - 30
        frame.size.height = height - 30
        
        self.layer.shadowPath = UIBezierPath(rect: frame).cgPath
    }
    func shadow1r (_ width: CGFloat, _ height: CGFloat, _ shadowRadius: CGFloat = 8) {
        self.layer.shadowColor = UIColor.hexColor(0x2C3237).withAlphaComponent(0.2).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = shadowRadius
        
        var frame = self.bounds
        frame.origin.x = 0
        frame.origin.y = 6
        frame.size.width = width + 1
        frame.size.height = height - 4
        
        self.layer.shadowPath = UIBezierPath(rect: frame).cgPath
    }
    func shadow3r (_ width: CGFloat, _ height: CGFloat, _ shadowRadius: CGFloat = 8) {
        self.layer.shadowColor = UIColor.hexColor(0x2C3237).withAlphaComponent(0.1).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = shadowRadius
        
        var frame = self.bounds
        frame.origin.x = 0
        frame.origin.y = 6
        frame.size.width = width + 1
        frame.size.height = height - 4
        
        self.layer.shadowPath = UIBezierPath(rect: frame).cgPath
    }
    func shadow1 () {
        self.layer.shadowColor = UIColor.hexColor(0x2C3237).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.shadowOpacity = 0.1
        self.layer.shadowRadius = 4.0
        self.layer.masksToBounds = false
    }
    func shadowTabbar () {
        self.layer.shadowColor = UIColor.hexColor(0xD5D6D7).cgColor
        self.layer.shadowColor = UIColor.hexColor(0x000000).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 0.0
        self.layer.masksToBounds = true
    }
    func dropShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 10
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
    func shadow (_ color: UIColor) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 4.0
        self.layer.masksToBounds = false
    }
    func shadow (_ radious: CGFloat, _ hoff: CGFloat) {
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: hoff)
        //self.layer.
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = radious
        self.layer.masksToBounds = false
    }    
    func clearBackground () {
        self.backgroundColor = UIColor.clear
    }
}

extension UIView {
    func x () -> CGFloat {
        return self.frame.origin.x
    }
    
    func y () -> CGFloat {
        return self.frame.origin.y
    }
    
    func width () -> CGFloat {
        return self.frame.size.width
    }
    
    func height () -> CGFloat {
        return self.frame.size.height
    }
}

class ShadowView: UIView {
    override open func draw(_ rect: CGRect) {
        if self.tag != 1 {
            self.tag = 315
        }
        
        self.backgroundColor = .clear
        
        self.dropShadow(radious: 8, extra1: self.tag)
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        self.backgroundColor = .clear
    }
}

extension UIView {
    
    // OUTPUT 1
    func dropShadow(radious: CGFloat, extra1: Int = 0, scale: Bool = true) {        
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = radious
        
        var extra: CGFloat = 5
        
        var frame = bounds
        
        if extra1 > 300 && extra1 < 400 {
            let opacity = extra1 - 300
            
            extra = 5
            
            let shadowOpacity = Float(opacity) / 100
            
            layer.shadowOpacity = shadowOpacity
            
            frame.origin.x = frame.origin.x - extra
            frame.origin.y = frame.origin.y - extra
            frame.size.width = frame.size.width + (2 * extra)
            frame.size.height = frame.size.height + (2 * extra)
        } else if extra1 == 0 {
            extra = 5
            
            layer.shadowOpacity = 0.1
            
            frame.origin.x = frame.origin.x - extra
            frame.origin.y = frame.origin.y - extra
            frame.size.width = frame.size.width + (2 * extra)
            frame.size.height = frame.size.height + (2 * extra)
        } else {
            extra = 0
            
            layer.shadowOpacity = 0.02
            
            frame.origin.x = frame.origin.x - extra
            frame.origin.y = frame.origin.y - extra
            frame.size.width = frame.size.width + (2 * extra)
            frame.size.height = frame.size.height + (2 * extra)
        }
        
        layer.shadowPath = UIBezierPath(rect: frame).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    // OUTPUT 2
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

class ViewTopBorder: UIView {
    override open func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    
    @IBInspectable open var radius: CGFloat = 16.0
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        roundCorners(corners: [.topLeft, .topRight], radius: radius)
    }
}

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
