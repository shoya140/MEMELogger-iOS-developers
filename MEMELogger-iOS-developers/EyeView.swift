//
//  EyeView.swift
//  MEMELogger
//
//  Created by Shoya Ishimaru on 2015/07/29.
//  Copyright (c) 2015年 Katsuma Tanaka. All rights reserved.
//

import UIKit

class EyeView: UIView {

    var eyeOpened:Bool = true
    var eyePosition: Double = 0
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        EyeMovement.drawCanvas1(horizontal_position: CGFloat(eyePosition), vertical_position: 0, eye: eyeOpened)
        self.transform = CGAffineTransformMakeScale(0.8, 0.8)
    }

}
