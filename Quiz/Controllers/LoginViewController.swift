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
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBOutlet weak var loginImageView: UIImageView!
    
    @IBOutlet weak var signinButton: UIButton!
    
    @IBOutlet weak var clearButton: UIButton!
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        animateEverythingIn()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
         
        animateEverythingOut()
        Thread.sleep(forTimeInterval: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupCenter()
        setupAlpha(to: 0.0)
        self.loginImageView.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
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
                        self.animateEverythingOut()
                        self.navigationController?.pushViewController(tabController, animated: true)
                    })
                }else{
                    self.wrongPasswordLabel.isHidden=false;

                }
            }
        }
    }
    
    func setupCenter(){
         
         self.loginImageView.center.x-=self.view.bounds.width
         self.usernameLabel.center.x-=self.view.bounds.width
         self.usernameField.center.x-=self.view.bounds.width
         self.passwordLabel.center.x-=self.view.bounds.width
         self.passwordField.center.x-=self.view.bounds.width
         self.signinButton.center.x-=self.view.bounds.width
         self.clearButton.center.x-=self.view.bounds.width
         self.wrongPasswordLabel.center.x-=self.view.bounds.width
         

     }
     
     func setupYcenter(){
         self.loginImageView.center.y+=100
         self.usernameField.center.y+=100
         self.usernameLabel.center.y+=100
         self.passwordLabel.center.y+=100
         self.passwordField.center.y+=100
         self.signinButton.center.y+=100
         self.clearButton.center.y+=100
         self.wrongPasswordLabel.center.y+=100
     }
     
     func setupAlpha(to: CGFloat){
         self.loginImageView.alpha=to
         self.usernameLabel.alpha=to
         self.usernameField.alpha=to
         self.passwordField.alpha=to
         self.passwordLabel.alpha=to
         self.signinButton.alpha=to
         self.clearButton.alpha=to
         self.wrongPasswordLabel.alpha=to
     }
     
     func animateEverythingIn(){
         
         UIView.animate(withDuration: 0.6, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
             self.loginImageView.center.x+=self.view.bounds.width
             self.loginImageView.alpha=1.0
             
         }) { _ in
         }
         
         UIView.animate(withDuration: 1.0, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
             self.loginImageView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
             
         }) { _ in
         }
         
         UIView.animate(withDuration: 0.6, delay: 0.2, options: UIView.AnimationOptions.curveEaseInOut, animations: {
             self.usernameLabel.center.x+=self.view.bounds.width
             self.usernameField.center.x+=self.view.bounds.width
             self.usernameLabel.alpha=1.0
             self.usernameField.alpha=1.0
         }) { _ in
         }
         
         UIView.animate(withDuration: 0.6, delay: 0.4, options: UIView.AnimationOptions.curveEaseInOut, animations: {
             self.passwordField.center.x+=self.view.bounds.width
             self.passwordLabel.center.x+=self.view.bounds.width
             self.passwordField.alpha=1.0
             self.passwordLabel.alpha=1.0
         }) { _ in
         }
         
         UIView.animate(withDuration: 0.6, delay: 0.6, options: UIView.AnimationOptions.curveEaseInOut, animations: {
             self.signinButton.center.x+=self.view.bounds.width
             self.signinButton.alpha=1.0
            self.clearButton.center.x+=self.view.bounds.width
            self.clearButton.alpha=1.0
         }) { _ in
         }
         
         UIView.animate(withDuration: 0.6, delay: 0.8, options: UIView.AnimationOptions.curveEaseInOut, animations: {
             self.wrongPasswordLabel.center.x+=self.view.bounds.width
             self.wrongPasswordLabel.alpha=1.0
         }) { _ in
         }
     }
     
     func animateEverythingOut(){
         
         
         UIView.animate(withDuration: 0.6, delay: 0.0, animations: {
             self.loginImageView.center.y-=100
             self.loginImageView.alpha=0.0
             
         }) { _ in
         }
         
         UIView.animate(withDuration: 1.0, delay: 0.0, animations: {
             self.loginImageView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
             
         }) { _ in
         }
         
         UIView.animate(withDuration: 0.6, delay: 0.2, animations: {
             self.usernameLabel.center.y-=100
             self.usernameField.center.y-=100
             self.usernameField.alpha=0.0
             self.usernameLabel.alpha=0.0
         }) { _ in
         }
         
         UIView.animate(withDuration: 0.6, delay: 0.4, animations: {
             self.passwordField.center.y-=100
             self.passwordLabel.center.y-=100
             self.passwordField.alpha=0.0
             self.passwordLabel.alpha=0.0
         }) { _ in
         }
         
         UIView.animate(withDuration: 0.6, delay: 0.6, animations: {
             self.signinButton.center.y-=100
             self.signinButton.alpha=0.0
            self.clearButton.center.y-=100
            self.clearButton.alpha=0.0
         }) { _ in
         }
         
         UIView.animate(withDuration: 0.6, delay: 0.8, animations: {
             self.wrongPasswordLabel.center.y-=100
             self.wrongPasswordLabel.alpha=0.0
         }) { _ in
         }
         
     }
    
    
}
