//
//  Button.swift
//  HarishFrameworkSwift4
//
//  Created by Harish on 11/01/18.
//  Copyright © 2018 Harish. All rights reserved.
//
import UIKit
open class Button: UIButton, LayoutParameters {
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
        let obb = ClassPara ()
        obb.shadowLayer = shadowLayer
        obb.backgroundColor = backgroundColor
        obb.layer = layer
        classPara = obb
        layoutSubviews (self)
    }
}

extension UIButton {
    func underline () {
        let tFont = self.titleLabel?.font
        let color = self.titleLabel?.textColor
        let title = self.currentTitle
        
        if tFont != nil && color != nil && title != nil {
            let attributedString = NSMutableAttributedString(string:"")
            
            let attrs = [
                NSAttributedString.Key.font : tFont!,
                NSAttributedString.Key.foregroundColor : color!,
                NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any]
            
            let buttonTitleStr = NSMutableAttributedString(string:title!, attributes:attrs)
            attributedString.append(buttonTitleStr)
            self.setAttributedTitle(attributedString, for: .normal)
        }
    }
}

class BorderButton: UIButton {
    override open func draw(_ rect: CGRect) {
        self.border0(4)
    }
}
