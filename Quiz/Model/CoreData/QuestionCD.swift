//
//  QuestionCD.swift
//  Quiz
//
//  Created by five on 14/06/2020.
//  Copyright © 2020 Ivana Mesic. All rights reserved.
//

import Foundation
import UIKit

public class QuestionCD: NSObject, NSCoding {
    public var question_id: Int
    public var question_text: String
    public var correct_question: Int
    public let answer1: String
    public let answer2: String
    public let answer3: String
    public let answer4: String
    
    init(_ question_id: Int,_ question_text: String,_ correctQuestion:Int,
        _ answer1: String,_ answer2: String,_ answer3: String,_ answer4: String) {
        self.question_id = question_id
        self.question_text = question_text
        self.correct_question = correctQuestion
        self.answer1=answer1
        self.answer2=answer2
        self.answer3=answer3
        self.answer4=answer4
    }
   
    public func encode(with aCoder: NSCoder){
        aCoder.encode(self.question_id, forKey: "question_id")
        aCoder.encode(self.question_text, forKey: "question_text")
        aCoder.encode(self.correct_question, forKey: "correct_question")
        aCoder.encode(self.answer1, forKey: "answer1")
        aCoder.encode(self.answer2, forKey: "answer2")
        aCoder.encode(self.answer3, forKey: "answer3")
        aCoder.encode(self.answer4, forKey: "answer4")
    }
    
    public required convenience init?(coder aCoder: NSCoder){
        let id = aCoder.decodeInt32(forKey: "question_id")
        let txt = aCoder.decodeObject(forKey: "question_text") as! String
        let correct = aCoder.decodeInt32(forKey: "correct_question")
        let ans1 = aCoder.decodeObject(forKey: "answer1") as! String
        let ans2 = aCoder.decodeObject(forKey: "answer1") as! String
        let ans3 = aCoder.decodeObject(forKey: "answer3") as! String
        let ans4 = aCoder.decodeObject(forKey: "answer4") as! String
        self.init(Int(id),txt,Int(correct),ans1,ans2,ans3,ans4)
    }
}
