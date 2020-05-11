//
//  AppDelegate.swift
//  Quiz
//
//  Created by five on 10/05/2020.
//  Copyright © 2020 Ivana Mesic. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var navigationController: UINavigationController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("APPDELEGATE")
        let userDefaults = UserDefaults.standard
        let value = userDefaults.string(forKey: "user_id")
        var root: UIViewController
        if (value != nil){
            root = QuizViewController()
        } else{
            root = LoginViewController()
        }
        
        navigationController = UINavigationController(rootViewController: root)
        window?.rootViewController = navigationController
        
        //window = UIWindow(frame: UIScreen.main.bounds)
        //let vc = LoginViewController()
        //window?.rootViewController = vc
        window?.makeKeyAndVisible()

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func switchToQuizController() {
        
        let vc = QuizViewController()
        navigationController = UINavigationController(rootViewController: vc)
        window?.rootViewController = navigationController
        print("Changing to quiz view")
        
    }


}

