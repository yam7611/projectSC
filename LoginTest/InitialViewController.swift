//
//  InitialViewController.swift
//  LoginTest
//
//  Created by yam7611 on 8/5/16.
//  Copyright © 2016 yam7611. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

    @IBAction func login(sender: UIButton) {
       // print ("pressed the button Login")
    }
    @IBAction func signup(sender: UIButton) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
