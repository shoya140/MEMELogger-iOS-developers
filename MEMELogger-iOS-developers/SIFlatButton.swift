//
//  SIFlatButton.swift
//  MEMELogger
//
//  Created by Shoya Ishimaru on 2015/06/06.
//  Copyright (c) 2015年 shoya140. All rights reserved.
//

import UIKit

@IBDesignable
class SIFlatButton: UIButton {
    
    @IBInspectable var inverse: Bool = false {
        didSet {
            updateButtonColor()
        }
    }
    
    @IBInspectable var buttonColor: UIColor = UIColor.blueColor() {
        didSet {
            updateButtonColor()
        }
    }
    
    func updateButtonColor() {
        if inverse {
            setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            setTitleColor(buttonColor, forState: UIControlState.Highlighted)
            backgroundColor = buttonColor
        } else {
            setTitleColor(buttonColor, forState: UIControlState.Normal)
            setTitleColor(UIColor.whiteColor(), forState: UIControlState.Highlighted)
            backgroundColor = UIColor.whiteColor()
        }
        
        setTitleShadowColor(UIColor.clearColor(), forState: UIControlState.Normal)
        setTitleShadowColor(UIColor.clearColor(), forState: UIControlState.Highlighted)
        layer.borderColor = buttonColor.CGColor
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    override var highlighted: Bool {
        didSet {
            if highlighted {
                if inverse {
                    backgroundColor = UIColor.whiteColor()
                } else {
                    backgroundColor = buttonColor
                }
            } else {
                if inverse {
                    backgroundColor = buttonColor
                } else {
                    backgroundColor = UIColor.whiteColor()
                }
            }
        }
    }
    
}