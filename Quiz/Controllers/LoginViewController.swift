//
//  LoginViewController.swift
//  QuizApp
//
//  Created by five on 10/05/2020.
//  Copyright © 2020 Ivana Mesic. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var wrongPasswordLabel: UILabel!
    
    
    @IBAction func SignInButton(_ sender: UIButton) {
        if (sender.tag != 0){
            return
        }
        login(password: passwordField.text ?? "", username: usernameField.text ?? "")
    }
    
    @IBAction func ClearAllButton(_ sender: UIButton) {
        if(sender.tag==1){
            print("\(sender.currentTitle) buttontap!")
            usernameField.text = ""
            passwordField.text = ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wrongPasswordLabel.isHidden = true
    }
    
    func login(password: String, username: String){
        
        if (password == "" || username=="") {
            print("Fields can't be empty!")
            return
        }
               
        let urlString = Constants.loginURL

        let login = LoginService()
        let jsonData:[String: Any] = [
            "username": username,
            "password": password
        ]
               
        login.sendLoginRequest(urlString: urlString, jsonData: jsonData){ (e) in
            
            DispatchQueue.main.async {
                if e != nil {
                    self.wrongPasswordLabel.isHidden = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                        let defaults = UserDefaults.standard
                        defaults.set(username, forKey: "username")
                        let tabController = TabBarController()
                        self.navigationController?.pushViewController(tabController, animated: true)
                    })
                }else{
                    self.wrongPasswordLabel.isHidden=false;

                }
            }
        }
    }
    
}
