//
//  QuestionView.swift
//  QuizApp
//
//  Created by five on 09/05/2020.
//  Copyright © 2020 Ivana Mesic. All rights reserved.
//

import UIKit

class QuestionView: UIView {

    
    var questionLabel: UILabel!
    
    var answer1: UIButton!
    var answer2: UIButton!
    var answer3: UIButton!
    var answer4: UIButton!
    var answerButtons: Array<UIButton> = []
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        makeElements()
        //setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
    }
    
    func setQuestionValues( question: Question, color: UIColor){
        self.questionLabel.text = question.questionText
        
        self.answer1.setTitle(question.answers[0], for: .normal)
        self.answer2.setTitle(question.answers[1], for: .normal)
        self.answer3.setTitle(question.answers[2], for: .normal)
        self.answer4.setTitle(question.answers[3], for: .normal)

        self.isHidden = false
    }
    
    func makeElements(){
        self.questionLabel = UILabel(frame: CGRect(x: 0,y: 0,width: 100,height: 100))
               questionLabel.text = "Placeholder question"
               self.addSubview(questionLabel)
        print(self.frame.width)
        self.answer1 = UIButton(frame: CGRect(x: 0,y: 0,width: 10,height: 10))
        self.answer2 = UIButton(frame: CGRect(x: 10,y: 10,width: 10,height: 10))
        self.answer3 = UIButton(frame: CGRect(x: 20,y: 20,width: 10,height: 10))
        self.answer4 = UIButton(frame: CGRect(x: 30,y: 30,width: 10,height: 10))
        self.answerButtons = [self.answer1, self.answer2, self.answer3, self.answer3]
        for (index, element) in answerButtons.enumerated() {
            element.tag = index
        }
    }
    
    func setConstraints(view: UIView){
        view.translatesAutoresizingMaskIntoConstraints = false
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        answer1.translatesAutoresizingMaskIntoConstraints = false
        answer2.translatesAutoresizingMaskIntoConstraints = false
        answer3.translatesAutoresizingMaskIntoConstraints = false
        answer4.translatesAutoresizingMaskIntoConstraints = false

        
        let labelX = questionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let labelTop = questionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height*0.08)
        view.addConstraints([labelX, labelTop])
        let answer1X = answer1.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let answer2X = answer2.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let answer3X = answer3.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let answer4X = answer4.centerXAnchor.constraint(equalTo: view.centerXAnchor)

        /*let answer1Left = answer1.leftAnchor.constraint(equalTo: self.leftAnchor, constant:self.frame.width*0.05)
        let answer3Left = answer3.leftAnchor.constraint(equalTo: self.leftAnchor, constant:self.frame.width*0.05)
        let answer2Right = answer2.rightAnchor.constraint(equalTo: self.rightAnchor, constant: self.frame.width*0.05)
        let answer4Right = answer4.rightAnchor.constraint(equalTo: self.rightAnchor, constant: self.frame.width*0.05)*/

        view.addConstraints([answer1X, answer3X, answer2X, answer4X])
        //self.addConstraint(answer1.widthAnchor.constraint(equalToConstant: self.frame.width*0.4))
        /*for i in [answer1, answer2, answer3, answer4]{
            
            
        }*/
    }
    
    

}
