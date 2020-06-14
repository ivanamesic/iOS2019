//
//  Constants.swift
//  Quiz
//
//  Created by five on 11/05/2020.
//  Copyright © 2020 Ivana Mesic. All rights reserved.
//

import Foundation
import UIKit
class Constants{
    
    static let backgroundColors = [
        QuizCategory.science: UIColor(displayP3Red: 0.572, green: 0.827, blue: 0.643, alpha: 0.6),
        QuizCategory.sports: UIColor(displayP3Red: 0.368, green: 0.584, blue: 0.729, alpha: 0.6)]
    
    static let sendOneQuizURL = "https://iosquiz.herokuapp.com/api/result"
    static let fetchQuizesURL = "https://iosquiz.herokuapp.com/api/quizzes"
    static let loginURL = "https://iosquiz.herokuapp.com/api/session"
    static let getQuizResultsURL = "https://iosquiz.herokuapp.com/api/score?quiz_id="

    static let userdef_addedQuizzes = "addedQuizzes"
}
