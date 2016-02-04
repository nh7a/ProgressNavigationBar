//
//  ProgressNavigationBar.swift
//  ProgressNav
//
//  Created by Naoki Hiroshima on 2/3/16.
//  Copyright © 2016 WTF. All rights reserved.
//

import UIKit

class ProgressNavigationBar: UINavigationBar {
    dynamic var trackTintColor: UIColor {  // UI_APPEARANCE_SELECTOR
        didSet { setNeedsDisplay() }
    }
    
    dynamic var progressTintColor: UIColor {  // UI_APPEARANCE_SELECTOR
        didSet { setNeedsDisplay() }
    }
    
    var progressHeight: CGFloat {
        didSet { setNeedsLayout(); setNeedsDisplay() }
    }
    
    var progress: Float {
        didSet { progress = max(0, min(1, progress)); setNeedsDisplay() }
    }
    
    private var progressLayer: CAShapeLayer
    
    required init?(coder aDecoder: NSCoder) {
        progressLayer = CAShapeLayer()
        trackTintColor = UIColor.clearColor()
        progressTintColor = UIColor.blueColor()
        progress = 0
        progressHeight = 1.0
        
        super.init(coder: aDecoder)
        layer.addSublayer(progressLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var rect = bounds
        rect.origin.y = rect.height - progressHeight
        rect.size.height = progressHeight
        progressLayer.frame = rect
        
        let path = UIBezierPath()
        path.moveToPoint(CGPointMake(0, rect.height / 2))
        path.addLineToPoint(CGPointMake(rect.width, rect.height / 2))
        progressLayer.path = path.CGPath
    }
    
    override func setNeedsDisplay() {
        if progress == 0 {
            progressLayer.hidden = true
            progressLayer.strokeEnd = 0
        } else {
            progressLayer.hidden = false
            progressLayer.strokeEnd = CGFloat(progress)
            progressLayer.backgroundColor = trackTintColor.CGColor
            progressLayer.strokeColor = progressTintColor.CGColor
            progressLayer.lineWidth = progressHeight
        }
        
        super.setNeedsDisplay()
    }
}
