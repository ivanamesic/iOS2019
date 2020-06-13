//
//  SettingsController.swift
//  Quiz
//
//  Created by five on 12/06/2020.
//  Copyright © 2020 Ivana Mesic. All rights reserved.
//

import UIKit

class SettingsController: UIViewController {
    
    var logOutButton = UIButton()
    var usernameLabel = UILabel()
    
    @objc func logout(_ sender: UIButton) {
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: "token")
        userDefaults.removeObject(forKey: "user_id")
        self.navigationController?.pushViewController(LoginViewController(), animated: false)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        createElements()
        view.addSubview(logOutButton)
        view.addSubview(usernameLabel)
        
        addConstraints()
        // Do any additional setup after loading the view.
    }
    
    func createElements(){
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        logOutButton.setTitle("LOG OUT", for: .normal)
        logOutButton.backgroundColor = UIColor(red: 0.11, green: 0.42, blue: 0.75, alpha: 1.00)
        logOutButton.setTitleColor(UIColor.white, for: .normal)
        logOutButton.setTitleColor(UIColor.systemGray2, for: .selected)
        logOutButton.addTarget(self, action: #selector(logout(_:)), for: .touchUpInside)
        
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.backgroundColor = UIColor.white
        let username = UserDefaults.standard.string(forKey: "username")
        usernameLabel.textColor = UIColor.systemGray2
        usernameLabel.text = username
        usernameLabel.textAlignment = NSTextAlignment.center
    }
    
    func addConstraints(){
        
        let l1 = usernameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let l2 = usernameLabel.widthAnchor.constraint(equalToConstant: view.frame.width*0.6)
        let l3 = usernameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height*0.3)
        
        
        let c1 = logOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let c2 = logOutButton.widthAnchor.constraint(equalToConstant: view.frame.width*0.5)
        let c3 = logOutButton.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height*0.6)
        
        
        view.addConstraints([l1,l2,l3,c1,c2,c3])
       
        
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
