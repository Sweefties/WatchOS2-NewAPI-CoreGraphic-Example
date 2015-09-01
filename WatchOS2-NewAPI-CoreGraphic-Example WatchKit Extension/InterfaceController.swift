//
//  InterfaceController.swift
//  WatchOS2-NewAPI-CoreGraphic-Example WatchKit Extension
//
//  Created by Wlad Dicario on 01/09/2015.
//  Copyright © 2015 Sweefties. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    // MARK: - Interface
    @IBOutlet var drawImage: WKInterfaceImage!
    
    // MARK: - Properties
    private let color = UIColor(red: 0.0/255.0, green: 153.0/255.0, blue: 221.0/255.0, alpha: 1.0)
    private let scale = WKInterfaceDevice.currentDevice().screenScale
    private let circleDash:Bool = true // false to draw a classic circle
    
    // MARK: - Calls
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        drawCoreGraphicInImage()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}

//MARK: - DrawCoreGraphic -> InterfaceController Extension
typealias DrawCoreGraphic = InterfaceController
extension DrawCoreGraphic {
    
    private func drawCoreGraphicInImage() {
        // Begin context for image
        UIGraphicsBeginImageContextWithOptions(self.contentFrame.size, false, scale)
        
        // Get the current context
        let context:CGContextRef = UIGraphicsGetCurrentContext()!
        
        // Set Color, Stroke, LineWidth, LineDash
        let strokeColor:CGColorRef = color.CGColor
        CGContextSetStrokeColorWithColor(context, strokeColor)
        CGContextSetLineWidth(context, 2.0)
        if circleDash {
            CGContextSetLineDash(context, 3, [2,3], 2)
        }
        // Define content frame, center, radius
        let contentFrameWidth = self.contentFrame.size.width
        let contentFrameHeight = self.contentFrame.size.height
        let center = CGPointMake(contentFrameWidth / 2.0, contentFrameHeight / 2.0)
        let radius = min(contentFrameWidth / 2.0, contentFrameHeight / 2.0) - 2
        
        // Context and add an Arc of a circle to the current path
        CGContextBeginPath(context)
        CGContextAddArc(context, center.x, center.y, radius, 0, CGFloat(2 * M_PI), 1)
        CGContextStrokePath(context)
        
        // Set text title with attributes
        let title:String = "Core Graphic"
        let rectTitle = CGRectMake(center.x - radius / 4.0, center.y - radius / 4.0, radius / 2.0, radius / 2.0)
        let textStyle = NSMutableParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        textStyle.alignment = NSTextAlignment.Center
        
        let textAttributes: [String: AnyObject] = [
            NSForegroundColorAttributeName : color.CGColor,
            NSFontAttributeName : UIFont.systemFontOfSize(8),
            NSParagraphStyleAttributeName : textStyle
        ]
        title.drawInRect(rectTitle, withAttributes: textAttributes)
        
        // Context create image
        let cgImage:CGImageRef = CGBitmapContextCreateImage(context)!
        let drawingImage:UIImage = UIImage(CGImage: cgImage)
        UIGraphicsEndImageContext()
        
        // Drawing in WKInterfaceImage
        self.drawImage.setImage(drawingImage)
    }
}