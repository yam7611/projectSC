//
//  DrawView.swift
//  LoginTest
//
//  Created by yam7611 on 9/8/16.
//  Copyright © 2016 yam7611. All rights reserved.
//

import UIKit

class DrawView: UIView {
    
    var lines: [Line] = []
    var lastPoint:CGPoint!
    var isMoving:Bool!
    let imageView:UIImageView=UIImageView()
    
    let handWriteImgV:UIImageView = UIImageView()
    let saveMemoryV:UIImageView = UIImageView()
    let uploadStoryV:UIImageView = UIImageView()
    let rectangleImgV:UIImageView = UIImageView()
    let undoImgV:UIImageView = UIImageView()
    var tempLineRecorder:Int = 0
    var previousLineRecorder:Int = 0
    var pathRecording:[Int] = []
    
    override init(frame: CGRect){
        super.init(frame: frame)
        imageView.frame = CGRectMake(0,0,frame.width,frame.height)
        //imageView.backgroundColor = UIColor.brownColor()
        //self.backgroundColor = UIColor.blueColor()
        self.addSubview(imageView)
        createButtonsOnTopOfImageView()
    }
    func initWithLine(frame:CGRect ,lines:Line){
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        isMoving = false
        if let touch = touches.first {
            lastPoint = touch.locationInView(imageView)
             //print("begin at x:\(lastPoint.x),y:\(lastPoint.y)")
            
            if CGRectContainsPoint(self.undoImgV.frame,lastPoint) {
                //lines.removeLast()

                print ("before deleting index 0 : \(lines.startIndex) , last index:\(lines.endIndex) , should delete from:\(lines.count - (pathRecording.last! - 1)) , to:\(lines.count) ")
                if pathRecording != []{
                lines.removeRange(Range<Int>(start:lines.count - pathRecording.last!  , end: lines.count ))
                print ("before remove,last line:\(pathRecording.last)")
                
                    pathRecording.removeLast()
                    self.setNeedsDisplay()
                }
                print ("after remove,last line:\(pathRecording.last)")
                print ("after deleting index 0 : \(lines.startIndex) , last index:\(lines.endIndex),the previousTempLine is:\(pathRecording.last)")
                
                

            } else if CGRectContainsPoint(self.handWriteImgV.frame, lastPoint){
                self.hidden = true
                removeAllButtonViewsFromDrawView()
            }
            
            else {
                //tempLineRecorder += 1
                print("gotoesle")
            }
        }
    }
    
    
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {

        if let touch = touches.first{
            
           let newPoint = touch.locationInView(imageView)
            //print("moved to x:\(newPoint.x),y:\(newPoint.y)")
            if CGRectContainsPoint(imageView.frame, newPoint){
                lines.append(Line(start:lastPoint, end:newPoint))
                lastPoint = newPoint
                tempLineRecorder += 1
                //print("number in lines:\(lines.count), tempLine:\(tempLineRecorder)")
                self.setNeedsDisplay()
                hideAllButton()
            }
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //previousLineRecorder =
        
        if let touch = touches.first{
            let point = touch.locationInView(imageView)
            showAllButton()
            if CGRectContainsPoint(undoImgV.frame, point){
                
                if pathRecording == []{
                    self.undoImgV.hidden = true
                }
                
                
                
            } else {
                pathRecording.append(tempLineRecorder)
                tempLineRecorder = 0
                self.undoImgV.hidden = false
            }
        }
        
        //previousLineRecorder = 0
    }
    
    func createButtonsOnTopOfImageView(){
        let SCREEN_HEIGHT = self.frame.height
        let SCREEN_WIDTH = self.frame.width
       // let centerPoint:CGPoint = CGPointMake(self.frame.width/2,self.frame.height/2)
        
        //MARK: draw a circle for define second for dismissing photo
        
        let radius:CGFloat = 30.0
        let startAngle:CGFloat = 0.0
        let endAngle:CGFloat = CGFloat(M_PI * 2)
        let path = UIBezierPath(arcCenter: CGPointMake(10, self.frame.origin.y-45), radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        let layer = CAShapeLayer()
        layer.path = path.CGPath
        layer.fillColor = UIColor.clearColor().CGColor
        layer.strokeColor = UIColor.clearColor().CGColor
        self.layer.addSublayer(layer)
        //MARK: setting each button image
        let handWriteImg:UIImage = UIImage(named: "pencil.png")!
        let saveToMemory:UIImage = UIImage(named:"download.png")!
        let uploadToStory:UIImage = UIImage(named:"new-document.png")!
        let rectangle:UIImage = UIImage(named:"rectangle.png")!
        let undo:UIImage = UIImage(named:"undo.png")!
        
        //MARK: attach them on imageView
        handWriteImgV.image = handWriteImg
        saveMemoryV.image = saveToMemory
        uploadStoryV.image = uploadToStory
        rectangleImgV.image = rectangle
        undoImgV.image = undo
        undoImgV.backgroundColor = UIColor.redColor()
        
        //rectangleImgV.addSubview(handWriteImgV)
        
       
        //MARK: set the position of each button(imageView) on self.view
        
        handWriteImgV.frame = CGRectMake(SCREEN_WIDTH - 36,8,22,22)
        rectangleImgV.frame = CGRectMake(SCREEN_WIDTH - 40,5,30,30)
        handWriteImgV.backgroundColor = UIColor.redColor()
        saveMemoryV.frame = CGRectMake(40,SCREEN_HEIGHT - 40,30,30)
        undoImgV.frame = CGRectMake(rectangleImgV.frame.origin.x - 40,5,30,30)
        uploadStoryV.frame = CGRectMake(saveMemoryV.frame.origin.x + 40,SCREEN_HEIGHT-40,30,30)
        
        //MARK: attach all buttons view on self.view
        self.addSubview(self.handWriteImgV)
        self.addSubview(self.rectangleImgV)
        self.addSubview(self.saveMemoryV)
        self.addSubview(self.uploadStoryV)
        self.addSubview(self.undoImgV)
        self.undoImgV.hidden = true

        
    }
    
    func showAllButton(){
        self.handWriteImgV.hidden = false
        self.rectangleImgV.hidden = false
        self.saveMemoryV.hidden = false
        self.uploadStoryV.hidden = false
        //self.undoImgV.hidden = false
            }
    func hideAllButton(){
        self.handWriteImgV.hidden = true
        self.rectangleImgV.hidden = true
        self.saveMemoryV.hidden = true
        self.uploadStoryV.hidden = true
        self.undoImgV.hidden = true
    }
    func removeAllButtonViewsFromDrawView(){
        self.handWriteImgV.removeFromSuperview()
        self.rectangleImgV.removeFromSuperview()
        self.saveMemoryV.removeFromSuperview()
        self.uploadStoryV.removeFromSuperview()
        self.undoImgV.removeFromSuperview()
        
    }
    
    override func drawRect(rect: CGRect) {
        var context = UIGraphicsGetCurrentContext()
        CGContextBeginPath(context)
        for line in lines{
            CGContextMoveToPoint(context, line.start.x, line.start .y)
            CGContextAddLineToPoint(context, line.end.x, line.end.y)
            
        }
        CGContextSetLineCap(context, CGLineCap.Round)
        CGContextSetLineWidth(context, 5)
        CGContextSetRGBStrokeColor(context, 1, 0, 0, 1)
        CGContextStrokePath(context)
    }
    
}
