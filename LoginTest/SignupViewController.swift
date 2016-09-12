//
//  SignupViewController.swift
//  LoginTest
//
//  Created by yam7611 on 8/5/16.
//  Copyright © 2016 yam7611. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
    
    var connection = false
    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    var successfullySignUp = false
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        //print("viewDidLoad loaded!")
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func login(sender: UIButton) {
        postToServer();
        
        if connection && successfullySignUp {
            self.performSegueWithIdentifier(Storyboard.segueIdentifier, sender: sender)
        }
        print("btn clicked!")
    }
    
    func postToServer(){
        //print("request is sent!")
        sendRequestToServer()
    }
    func sendRequestToServer(){
        let url = NSURL(string: "http://localhost:8888/testForios.php")
        
        let request = NSMutableURLRequest(URL:url!)
        
        print ("request\(request)")
        
        let postString = "username_insert=\(username.text!)&password_insert=\(password.text!)"
        
        request.HTTPMethod="POST"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            if error != nil{
                self.connection = false
                print("error\(error)")
            } else {
                self.connection = true
                let responseString = NSString(data:data!,encoding:NSUTF8StringEncoding)
                print("responseString=\(responseString!)")
                
                
                
                if (responseString?.containsString("Successfully") != nil){
                    self.successfullySignUp = true
                    print ("successfully go to set up sign up as true ")
                    
                } else {
                    print ("the id is invalid")
                }
               
                
            }
        }
        task.resume()
        
    }
    
    private struct Storyboard {
        static let segueIdentifier = "ShowStartingApp"
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("prepareForSegue is loaded! ")
        if segue.identifier == Storyboard.segueIdentifier{
           
            print ("go to the prepare for segue")
            if let dvc = segue.destinationViewController as? GettingStartViewController{
                dvc.userName = username.text!
                print("dvc.userName = \(dvc.userName)")
            }
            
        }
    }
    
    
    
}
