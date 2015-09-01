![](https://img.shields.io/badge/build-pass-brightgreen.svg?style=flat-square)
![](https://img.shields.io/badge/platform-WatchOS2-ff69b4.svg?style=flat-square)
![](https://img.shields.io/badge/Require-XCode7-lightgrey.svg?style=flat-square)


# WatchOS2 - New API - Core Graphic - Example
WatchOS 2 Experiments - New API Components - Drawing with Core Graphic

## Example

![](https://raw.githubusercontent.com/Sweefties/WatchOS2-NewAPI-CoreGraphic-Example/master/source/Apple_Watch_template-CoreGraphic.jpg)

## Requirements

- >= XCode 7 beta 6~.
- >= Swift 2.

Tested on WatchOS2 Simulator.

## Usage

To run the example project, download or clone the repo.

### Example Code!


Configure your Storyboard :

- Drag and drop WKInterfaceImage to Interface Controller
- connect your WKInterfaceImage `image` to your Interface Controller class
- put code to your controller class.

```swift
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
```


Build and Run!
