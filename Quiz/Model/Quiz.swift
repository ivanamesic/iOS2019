//
//  Quiz.swift
//  QuizApp
//
//  Created by five on 09/05/2020.
//  Copyright © 2020 Ivana Mesic. All rights reserved.
//

import Foundation

class Quiz{
    let id: Int
    let title: String
    let description: String
    let category: QuizCategory
    let level: Int
    let image: String
    let questions: [Question]
    
    
    init?(json: Any) {

        if let jsonDict = json as? [String: Any],
            let id = jsonDict["id"] as? Int,
            let title = jsonDict["title"] as? String,
            let description = jsonDict["description"] as? String,
            let category = jsonDict["category"] as? String,
            let level = jsonDict["level"] as? Int,
            let image = jsonDict["image"] as? String,
            let questions = jsonDict["questions"] as? [Any]{
                self.id = id
                self.title = title
                self.description = description
                self.category=QuizCategory(name:category)
                self.level=level
                self.image=image
            
                var array = [Question]()
                for q in questions{
                    array.append(Question(json: q)!)
                }
                
                self.questions = array
        } else {
            return nil
        }
    }
    
    init(id: Int, title: String, description: String, category: String, level: Int, image: String, questions: [Question]){
        self.id = id
        self.title = title
        self.description = description
        self.category = QuizCategory(name: category)
        self.level = level
        self.image = image
        self.questions = questions
    }
    
    
    
}

