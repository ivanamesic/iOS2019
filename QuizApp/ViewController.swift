//
//  ViewController.swift
//  QuizApp
//
//  Created by five on 07/05/2020.
//  Copyright © 2020 Ivana Mesic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var SignInButton: UIButton!
    
    @IBOutlet weak var ClearButton: UIButton!
    
    @IBAction func SignIn(_ sender: UIButton) {
        
        if (sender.tag==0){
            if (usernameField.text=="ivana" && passwordField.text=="Pass1234"){
                print("Login successful!")
            } else {
                print("Wrong username and/or password!")
            }
        }
        
    }
    
    @IBAction func ClearAll(_ sender: UIButton) {
        if(sender.tag==1){
            print("\(sender.currentTitle) buttontap!")
            usernameField.text = ""
            passwordField.text = ""
        }
    }
}

