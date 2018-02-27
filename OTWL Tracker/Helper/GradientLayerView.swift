//
//  GradientLayerView.swift
//  ValYou
//
//  Created by Sanjay Mali on 20/12/17.
//  Copyright © 2017 Moses Afonso. All rights reserved.
//

import UIKit
@IBDesignable class GradientLayerView: UIView {
        @IBInspectable var startColor:   UIColor = .black { didSet { updateColors() }}
        @IBInspectable var endColor:     UIColor = .white { didSet { updateColors() }}
        @IBInspectable var startLocation: Double =   0.05 { didSet { updateLocations() }}
        @IBInspectable var endLocation:   Double =   0.95 { didSet { updateLocations() }}
        @IBInspectable var horizontalMode:  Bool =  false { didSet { updatePoints() }}
        @IBInspectable var diagonalMode:    Bool =  false { didSet { updatePoints() }}
        
        override class var layerClass: AnyClass { return CAGradientLayer.self }
        
        var gradientLayer: CAGradientLayer { return layer as! CAGradientLayer }
        
        func updatePoints() {
            if horizontalMode {
                gradientLayer.startPoint = diagonalMode ? CGPoint(x: 1, y: 0) : CGPoint(x: 0, y: 0.5)
                gradientLayer.endPoint   = diagonalMode ? CGPoint(x: 0, y: 1) : CGPoint(x: 1, y: 0.5)
            } else {
                gradientLayer.startPoint = diagonalMode ? CGPoint(x: 0, y: 0) : CGPoint(x: 0.5, y: 0)
                gradientLayer.endPoint   = diagonalMode ? CGPoint(x: 1, y: 1) : CGPoint(x: 0.5, y: 1)
            }
        }
        func updateLocations() {
            gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
        }
        func updateColors() {
            gradientLayer.colors    = [startColor.cgColor, endColor.cgColor]
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            updatePoints()
            updateLocations()
            updateColors()
        }
    
    
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

