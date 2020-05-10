//
//  Question.swift
//  QuizApp
//
//  Created by five on 09/05/2020.
//  Copyright © 2020 Ivana Mesic. All rights reserved.
//

import Foundation

class Question{
    
    let id: Int
    let questionText: String
    let answers:[String]
    let correct_answer: Int
    
    init?(json: Any) {
        
        if let jsonDict = json as? [String: Any],
            let id = jsonDict["id"] as? Int,
            let questionText = jsonDict["question"] as? String,
            let answers = jsonDict["answers"] as? [String],
            let correct_answer = jsonDict["correct_answer"] as? Int { 
                self.id = id
                self.questionText = questionText
                self.answers = answers
                self.correct_answer=correct_answer
        } else {
            return nil
        }
    }
}
