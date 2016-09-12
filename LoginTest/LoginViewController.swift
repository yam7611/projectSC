//
//  LoginViewController.swift
//  LoginTest
//
//  Created by yam7611 on 8/5/16.
//  Copyright © 2016 yam7611. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userName: UITextField!

    @IBOutlet weak var userPassword: UITextField!
    
    
    var validityPassword = true
    
    @IBOutlet weak var wrongPassLabel: UILabel!
    
        override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
    
   
    
    @IBAction func login(sender: UIButton) {
        
        let validP = getContentFromPhp()
        if validP {
            performSegueWithIdentifier(Storyboard.segueIdentifier, sender: sender)
        }
    }
    private func getContentFromPhp()->Bool{
        
        
        let snapchatTest = "http://192.168.1.10:8888/return_value_for_iOS.php?username=\(userName.text!)&password=\(userPassword.text!)"
        
        let url = NSURL(string:snapchatTest)
        
        do {
            
           let str = try NSString(contentsOfURL:url!, encoding:NSUTF8StringEncoding)
            var nstr = str.stringByReplacingOccurrencesOfString("<html>\n", withString: "")
            nstr = nstr.stringByReplacingOccurrencesOfString("</html>", withString: "")
            
            let data = nstr.dataUsingEncoding(NSUTF8StringEncoding)
            var json:NSArray
            
            json = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSArray
            
            if json == [] {
                wrongPassLabel.text = "wrong password!"
                
            }else {
                print(json)
                return true
            }
            
            
            
        } catch {
           print (error)
        }
        return false
 
//        let str = try! NSString(contentsOfURL:url!, encoding:NSUTF8StringEncoding)
//        
        
       // print ("before:\(str)")
        
//        let request = NSMutableURLRequest(URL:url!)
//        
//        let usernameAndPassword = "username=yam7611@yahoo.com.tw&password=garnett7611"
//        
//        request.HTTPMethod = "POST"
//        
//        request.HTTPBody = usernameAndPassword.dataUsingEncoding(NSUTF8StringEncoding)
//        
//        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) in
//            if error != nil{
//                print("error\(error)")
//            } else {
//                let responseString = NSString(data:data!,encoding:NSUTF8StringEncoding)
//               // print("responseString=\(responseString)")
//                
//               
//            }
//            
//            
//        }
//        task.resume()
        
        /*
        let data = NSData(contentsOfURL: url!)
        var datas:Array<AnyObject>!
        do{
            datas = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as? Array } catch {
             print (error)
        }
        print("datas[0]=\(datas[0])")
        */
        
    }
    
    
    private struct Storyboard{
        static let segueIdentifier = "segueToCamera"
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

            if segue.identifier == Storyboard.segueIdentifier  {
                if let dvc = segue.destinationViewController as? UIViewController{
                        //dvc.imageList.insert("123", atIndex: 0)
                        //print ("go to camera page")
                }
            }
        
    }

}
