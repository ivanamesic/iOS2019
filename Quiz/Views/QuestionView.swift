//
//  QuestionView.swift
//  QuizApp
//
//  Created by five on 09/05/2020.
//  Copyright © 2020 Ivana Mesic. All rights reserved.
//

import UIKit

class QuestionView: UIView {

    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var answer1: UIButton!
    @IBOutlet weak var answer2: UIButton!
    @IBOutlet weak var answer3: UIButton!
    @IBOutlet weak var answer4: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        common()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
    }
    func common(){
        guard let view = loadNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        contentView = view
        self.isHidden = true
    }
    
    var contentView:UIView?
    var nibName = "QuestionView"
    
    func loadNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    func setValues( question: Question, color: UIColor){
        print(question.questionText)
        self.questionLabel.text = question.questionText
        self.answer1.setTitle(question.answers[0], for: .normal)
        self.answer2.setTitle(question.answers[1], for: .normal)
        self.answer3.setTitle(question.answers[2], for: .normal)
        self.answer4.setTitle(question.answers[3], for: .normal)

        self.backgroundColor = color
        self.isHidden = false
    }
    
    
    

}
