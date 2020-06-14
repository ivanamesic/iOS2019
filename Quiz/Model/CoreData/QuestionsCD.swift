//
//  QuestionsCD.swift
//  Quiz
//
//  Created by five on 14/06/2020.
//  Copyright © 2020 Ivana Mesic. All rights reserved.
//

import Foundation

public class QuestionsCD: NSObject, NSCoding {
    
    public var questions: [QuestionCD] = []
    
    init(questions: [QuestionCD]){
        self.questions = questions
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(questions, forKey: "questions")
    }
    
    public required convenience init?(coder: NSCoder) {
        let qs = coder.decodeObject(forKey: "questions") as! [QuestionCD]
        self.init(questions: qs)
    }
    
    
}
