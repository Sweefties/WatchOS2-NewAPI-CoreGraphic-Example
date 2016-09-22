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
    fileprivate let color = UIColor(red: 0.0/255.0, green: 153.0/255.0, blue: 221.0/255.0, alpha: 1.0)
    fileprivate let scale = WKInterfaceDevice.current().screenScale
    fileprivate let circleDash:Bool = true // false to draw a classic circle
    
    // MARK: - Calls
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
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
    
    fileprivate func drawCoreGraphicInImage() {
        // Begin context for image
        UIGraphicsBeginImageContextWithOptions(self.contentFrame.size, false, scale)
        
        // Get the current context
        let context:CGContext = UIGraphicsGetCurrentContext()!
        
        // Set Color, Stroke, LineWidth, LineDash
        let strokeColor:CGColor = color.cgColor
        context.setStrokeColor(strokeColor)
        context.setLineWidth(2.0)
        if circleDash {
            context.setLineDash(phase: 3, lengths: [2,3])
        }
        // Define content frame, center, radius
        let contentFrameWidth = self.contentFrame.size.width
        let contentFrameHeight = self.contentFrame.size.height
        let center = CGPoint(x: contentFrameWidth / 2.0, y: contentFrameHeight / 2.0)
        let radius = min(contentFrameWidth / 2.0, contentFrameHeight / 2.0) - 2
        
        // Context and add an Arc of a circle to the current path
        context.beginPath()
        context.addArc(center: center, radius: radius, startAngle: 0, endAngle: CGFloat(2 * M_PI), clockwise: true)
        context.strokePath()
        
        // Set text title with attributes
        let title:String = "Core Graphic"
        let rectTitle = CGRect(x: center.x - radius / 4.0, y: center.y - radius / 4.0, width: radius / 2.0, height: radius / 2.0)
        let textStyle = NSMutableParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        textStyle.alignment = NSTextAlignment.center
        
        let textAttributes: [String: AnyObject] = [
            NSForegroundColorAttributeName : color.cgColor,
            NSFontAttributeName : UIFont.systemFont(ofSize: 8),
            NSParagraphStyleAttributeName : textStyle
        ]
        title.draw(in: rectTitle, withAttributes: textAttributes)
        
        // Context create image
        let cgImage:CGImage = context.makeImage()!
        let drawingImage:UIImage = UIImage(cgImage: cgImage)
        UIGraphicsEndImageContext()
        
        // Drawing in WKInterfaceImage
        self.drawImage.setImage(drawingImage)
    }
}
