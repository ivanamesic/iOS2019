//
//  RootViewController.swift
//  Quiz
//
//  Created by five on 01/06/2020.
//  Copyright © 2020 Ivana Mesic. All rights reserved.
//

import UIKit

class RootViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        /*let userDefaults = UserDefaults.standard
        let value = userDefaults.string(forKey: "user_id")
        var root: UIViewController
        if (value != nil){
            root = QuizViewController()
        } else{
            root = LoginViewController()
        }
        print(root)*/
        self.navigationBar.isHidden = true //Swift 5
        //self.navigationController?.pushViewController(root, animated: false)
        // Do any additional setup after loading the view.
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
