//
//  CameraViewController.swift
//  LoginTest
//
//  Created by yam7611 on 8/5/16.
//  Copyright © 2016 yam7611. All rights reserved.
//

import UIKit
import MobileCoreServices
class CameraViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    
    var accountName:String?
    var password:String?
    let shotBtn = UIButton()
    var imageList = Array<String>()
    let picker = UIImagePickerController()
    let changeBtnView:UIView = UIView()
    let closeImgV:UIImageView = UIImageView()
    let handWriteImgV:UIImageView = UIImageView()
    let textImgV:UIImageView = UIImageView()
    let paperImgV:UIImageView = UIImageView()
    let saveMemoryV:UIImageView = UIImageView()
    let uploadStoryV:UIImageView = UIImageView()

    
    
    var isButtonVisible:Bool = false
    
    @IBOutlet weak var cameraView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initialiseCamera()
        createTakePhotoBtn()
        fetchImageFromDevice()
       
        //print("the first element in CameraViewController is :\(imageList[0])")
        // Do any additional setup after loading the view.
        
    }
   
    func createTakePhotoBtn(){
        if cameraView.image != nil {
            
            shotBtn.setTitle("take a photo", forState:UIControlState.Normal)
            shotBtn.frame = CGRectMake(self.view.frame.width/2,self.view.frame.height/2,50,30)
            shotBtn.backgroundColor = UIColor.blackColor()
            shotBtn.addTarget(self, action: #selector(CameraViewController.takePhotoPressed(_:)), forControlEvents: UIControlEvents.TouchUpOutside)
            self.view.addSubview(shotBtn)
        }
    }
    
    
    func takePhotoPressed(sender:UIButton){
        fetchImageFromDevice()
        self.shotBtn.removeFromSuperview()
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    func initialiseCamera() {
        picker.delegate = self
        picker.sourceType = .Camera
        changeBtnView.frame = (CGRectMake(10, 300, 125, 80))
        changeBtnView.backgroundColor = UIColor.clearColor()
        
        let text:UILabel = UILabel(frame:CGRectMake(0,0,110,30))
        text.text = "photo  video"
        changeBtnView.addSubview(text)
        let changeModeSwitch:UISwitch = UISwitch(frame:CGRectMake(10,text.frame.height+5,40,25))
        changeModeSwitch.setOn(false, animated: true)
        changeModeSwitch.addTarget(self, action: #selector(CameraViewController.stateChanged(_:)), forControlEvents: UIControlEvents.ValueChanged)
        changeBtnView.addSubview(changeModeSwitch)
        picker.cameraOverlayView = changeBtnView
        
        //picker.mediaTypes = [kUTTypeMovie as String]
    }
    
    func fetchImageFromDevice(){

        presentViewController(self.picker, animated: true, completion: nil)
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        showAllButton()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first{
            let point = touch.locationInView(self.view)
            

            if CGRectContainsPoint(closeImgV.frame, point){
                cancelCurrentPhoto()
            } else if CGRectContainsPoint(handWriteImgV.frame,point){
                hideAllButton()
                goHandWriteMode()
                self.isButtonVisible = true
                print("gotihandwritemode")
            }
            
            else {
                self.isButtonVisible = false
                hideAllButton()
            }
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first{
            touch.locationInView(self.view)
            if !self.isButtonVisible{
                showAllButton()
            }
        }
    }
    
    
    func stateChanged(switchState:UISwitch){
        if switchState.on{
           picker.mediaTypes = [kUTTypeMovie as String]
        } else {
            picker.mediaTypes = [kUTTypeImage as String]
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        cameraView.image = info[UIImagePickerControllerOriginalImage] as? UIImage; dismissViewControllerAnimated(true,completion:nil)
        createButtonsOnTopOfImageView()
    }
    
    
    func createButtonsOnTopOfImageView(){
        
        let SCREEN_HEIGHT = self.view.frame.height
        let SCREEN_WIDTH = self.view.frame.width
        
        let centerPoint:CGPoint = CGPointMake(self.view.frame.width/2,self.view.frame.height/2)
        
        
        
        //MARK: draw a circle for define second for dismissing photo
        
        let radius:CGFloat = 30.0
        let startAngle:CGFloat = 0.0
        let endAngle:CGFloat = CGFloat(M_PI * 2)
        let path = UIBezierPath(arcCenter: centerPoint, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        let layer = CAShapeLayer()
        layer.path = path.CGPath
        layer.fillColor = UIColor.clearColor().CGColor
        layer.strokeColor = UIColor.clearColor().CGColor
        
        //MARK: setting each button image
        let handWriteImg:UIImage = UIImage(named: "pencil.png")!
        let paperImg:UIImage = UIImage(named: "new-document-button.png")!
        let textImg:UIImage = UIImage(named: "text.png")!
        let closeImg:UIImage = UIImage(named:"cancel.png")!
        let saveToMemory:UIImage = UIImage(named:"download.png")!
        let uploadToStory:UIImage = UIImage(named:"new-document.png")!
        
        
        //MARK: attach them on imageView
        handWriteImgV.image = handWriteImg
        textImgV.image = textImg
        paperImgV.image = paperImg
        closeImgV.image = closeImg
        saveMemoryV.image = saveToMemory
        uploadStoryV.image = uploadToStory
        
        
        //MARK: set the position of each button(imageView) on self.view
        paperImgV.frame = CGRectMake(200,5,30,30)
        closeImgV.frame = CGRectMake(5,5,30,30)
        textImgV.frame = CGRectMake(paperImgV.frame.origin.x+40, paperImgV.frame.origin.y, 30, 30)
        handWriteImgV.frame = CGRectMake(textImgV.frame.origin.x+40,textImgV.frame.origin.y,30,30)
        
        saveMemoryV.frame = CGRectMake(40,SCREEN_HEIGHT - 40,30,30)
        uploadStoryV.frame = CGRectMake(saveMemoryV.frame.origin.x + 40,SCREEN_HEIGHT-40,30,30)
        
        //MARK: attach all buttons view on self.view
        self.tabBarController?.tabBar.hidden = true
        
        showAllButton()
    }
    
    func goHandWriteMode(){
        let drawV:DrawView = DrawView(frame:self.cameraView.frame)
        //drawV.frame = CGRectMake(0,0,400,960)
        drawV.backgroundColor = UIColor.clearColor()
        self.view.addSubview(drawV)
    }
    
    func showAllButton(){
        self.view.addSubview(self.paperImgV)
        self.view.addSubview(self.handWriteImgV)
        self.view.addSubview(self.textImgV)
        self.view.addSubview(self.closeImgV)
        self.view.addSubview(self.saveMemoryV)
        self.view.addSubview(self.uploadStoryV)
    }
    
    func cancelCurrentPhoto(){
        print("cancel drawing")
        hideAllButton()
        //self.drawV.removeFromSuperview()
        //cameraView.image = nil
        self.tabBarController?.tabBar.hidden = false
        fetchImageFromDevice()
            }
    
    func hideAllButton(){
        
        self.handWriteImgV.removeFromSuperview()
        self.paperImgV.removeFromSuperview()
        self.textImgV.removeFromSuperview()
        self.closeImgV.removeFromSuperview()
        self.saveMemoryV.removeFromSuperview()
        self.uploadStoryV.removeFromSuperview()
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
