//
//  TabBarController.swift
//  Quiz
//
//  Created by five on 07/06/2020.
//  Copyright © 2020 Ivana Mesic. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let quizController = QuizViewController()
        quizController.tabBarItem = UITabBarItem(title: "Quiz", image: UIImage(named: "quiz_icon"), tag: 0)
        let settingsController = SettingsController()
        settingsController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(named: "settings_icon"), tag: 1)
        settingsController.tabBarItem.title = "Settings"
        let searchController = SearchController()
        searchController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 2)
        let tabBarList = [quizController, settingsController, searchController]
        viewControllers = tabBarList
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
