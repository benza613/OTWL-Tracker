//
//  RoundedView.swift
//  OceanWorld_Clearance
//
//  Created by Sanjay Mali on 07/02/18.
//  Copyright © 2018 Sanjay Mali. All rights reserved.
//

import Foundation
import UIKit
@IBDesignable class RoundedView: UIView {
        @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set(newRadius) {
            layer.cornerRadius = newRadius
            layer.masksToBounds = newRadius > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set(newWidth) {
            layer.borderWidth = newWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            if let layerColor = layer.borderColor {
                return UIColor(cgColor: layerColor)
            }
            return nil
        }
        set(newColor) {
            layer.borderColor = newColor?.cgColor
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}
