//
//  GraphView.swift
//  MEMELogger
//
//  Created by Shoya Ishimaru on 2015/07/28.
//  Copyright (c) 2015年 Katsuma Tanaka. All rights reserved.
//

import UIKit

@IBDesignable class GraphView: UIView {
    @IBInspectable var maximumValue: Double = 1000.0{
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable var minimumValue: Double = -1000.0{
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable var minimumNumberOfValuesToBeDisplayed: UInt = 100{
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable var contentInset: UIEdgeInsets = UIEdgeInsetsZero{
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable var gridColor = UIColor(white: (219.0 / 255.0), alpha: 1.0){
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable var lineColor = UIColor.blueColor(){
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable var values: [Double]?{
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        // Calculate frame size
        var frame = self.bounds
        frame.origin.x += self.contentInset.left
        frame.origin.y += self.contentInset.bottom
        frame.size.width -= (self.contentInset.left + self.contentInset.right)
        frame.size.height -= (self.contentInset.top + self.contentInset.bottom)
        
        // Draw background
        self.backgroundColor = UIColor.whiteColor()
        
        // Draw grid
        let numberOfHorizontalGrids: UInt = 5
        let horizontalGridMargin = (self.maximumValue - self.minimumValue) / Double(numberOfHorizontalGrids - 1)
        let verticalPixelPerValue: CGFloat = frame.height / CGFloat(self.maximumValue - self.minimumValue)
        
        let labelFont = UIFont.systemFontOfSize(8.0)
        let labelAttributes = [
            NSForegroundColorAttributeName: self.gridColor,
            NSFontAttributeName: labelFont
        ]
        
        let context: CGContextRef = UIGraphicsGetCurrentContext()!
        CGContextSetLineWidth(context, 1.0)
        
        for i in 0..<numberOfHorizontalGrids {
            let value: Double = self.minimumValue + horizontalGridMargin * Double(i)
            
            // Draw horizontal line
            var gridY: CGFloat = verticalPixelPerValue * CGFloat(value - self.minimumValue)
            if i == numberOfHorizontalGrids - 1 { gridY -= 1.0 }
            if i == 0 { gridY += 1.0 }
            
            CGContextMoveToPoint(context, 0, gridY);
            CGContextAddLineToPoint(context, frame.width, gridY);
            
            // Draw label
            var labelY: CGFloat = frame.minY + verticalPixelPerValue * CGFloat(self.maximumValue - value)
            if i == 0 {labelY -= (labelFont.lineHeight + 1.0) }
            
            NSString(format: "%ld", Int(value)).drawAtPoint(
                CGPoint(
                    x: frame.minX,
                    y: labelY
                ),
                withAttributes: labelAttributes
            )
        }
        
        CGContextSetFillColorWithColor(context, self.gridColor.CGColor)
        CGContextStrokePath(context);
        
        // Don't draw graph if values.count == 0
        if self.values == nil { return }
        let values = self.values!
        
        // Draw graph
        let path = UIBezierPath()
        path.lineWidth = 1.0
        
        let horizontalPixelPerValue: CGFloat = frame.width / CGFloat(max(1, max(Int(self.minimumNumberOfValuesToBeDisplayed) - 1, values.count - 1)))
        let offset = max(0, Int(self.minimumNumberOfValuesToBeDisplayed) - values.count)
        
        for (index, value) in values.enumerate() {
            let point = CGPoint(
                x: frame.minX + horizontalPixelPerValue * CGFloat(offset + index),
                y: frame.minY + verticalPixelPerValue * CGFloat(self.maximumValue - value)
            )
            
            if index == 0 {
                path.moveToPoint(point)
            } else {
                path.addLineToPoint(point)
            }
        }
        
        self.lineColor.setStroke()
        path.stroke()
    }
}