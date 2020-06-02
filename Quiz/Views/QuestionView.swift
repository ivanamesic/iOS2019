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
    var question: Question?
    
    @objc func buttonClicked(_ sender: UIButton){
        if sender.tag == question?.correct_answer{
            sender.backgroundColor = UIColor(red: 0.30, green: 0.79, blue: 0.45, alpha: 1.00)
        } else {
            sender.backgroundColor = UIColor(red: 0.93, green: 0.33, blue: 0.31, alpha: 1.00)
        }
    }
    
    init(frame: CGRect, question: Question, color: UIColor) {
        super.init(frame:frame)
        self.backgroundColor = UIColor.white
        self.translatesAutoresizingMaskIntoConstraints = false
        makeElements()
        setQuestionValues(question: question, color: color)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
    }
    
    func setQuestionValues( question: Question, color: UIColor){
        self.questionLabel.text = question.questionText
        self.question = question
        self.answer1.setTitle(question.answers[0], for: .normal)
        self.answer2.setTitle(question.answers[1], for: .normal)
        self.answer3.setTitle(question.answers[2], for: .normal)
        self.answer4.setTitle(question.answers[3], for: .normal)

        self.isHidden = false
    }
    
    func makeElements(){
        let x = self.frame.minX
        var y = self.frame.minY
        self.questionLabel = UILabel(frame: CGRect(x: x+self.frame.width*0.1,y:y+self.frame.height*0.1,width: self.frame.width*0.8,height: self.frame.height*0.1))
        questionLabel.text = "Placeholder question"
        y += 2*self.frame.height*0.1
        self.questionLabel.textAlignment = NSTextAlignment.center
        self.questionLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        self.questionLabel.numberOfLines = 2
        self.addSubview(questionLabel)
        let buttonW = self.frame.width*0.8
        let buttonHeight = self.frame.height*0.12
        let spacing = self.frame.height*0.02
        let buttonL = x+self.frame.width*0.1
        self.answer1 = UIButton(frame: CGRect(x: buttonL,y:y+spacing,width:buttonW,height: buttonHeight))
        self.answer2 = UIButton(frame: CGRect(x: buttonL,y:y+buttonHeight+2*spacing,width: buttonW,height: buttonHeight))
        self.answer3 = UIButton(frame: CGRect(x: buttonL,y:y+2*buttonHeight+3*spacing,width: buttonW,height: buttonHeight))
        self.answer4 = UIButton(frame: CGRect(x: buttonL,y:y+3*buttonHeight+4*spacing,width: buttonW,height: buttonHeight))
        self.answerButtons = [self.answer1, self.answer2, self.answer3, self.answer4]
        for (index, element) in answerButtons.enumerated() {
            element.tag = index
            element.backgroundColor = UIColor.systemGray2
            element.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
            self.addSubview(element)
        }
        
        
    }
    
    func setConstraints(){
        self.translatesAutoresizingMaskIntoConstraints = false
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        answer1.translatesAutoresizingMaskIntoConstraints = false
        answer2.translatesAutoresizingMaskIntoConstraints = false
        answer3.translatesAutoresizingMaskIntoConstraints = false
        answer4.translatesAutoresizingMaskIntoConstraints = false

        let answer1Left = answer1.leftAnchor.constraint(equalTo: self.leftAnchor, constant:self.frame.width*0.05)
        //let answer3Left = answer3.leftAnchor.constraint(equalTo: self.leftAnchor, constant:self.frame.width*0.05)
        //let answer2Right = answer2.rightAnchor.constraint(equalTo: self.rightAnchor, constant: self.frame.width*0.05)
        let answer4Right = answer4.rightAnchor.constraint(equalTo: self.rightAnchor, constant: self.frame.width*0.05)

        self.addConstraints([answer1Left, answer4Right])
        //self.addConstraint(answer1.widthAnchor.constraint(equalToConstant: self.frame.width*0.4))
        /*for i in [answer1, answer2, answer3, answer4]{
            
            
        }*/
    }
    
    

}
