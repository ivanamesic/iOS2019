//
//  OneQuizController.swift
//  Quiz
//
//  Created by five on 01/06/2020.
//  Copyright © 2020 Ivana Mesic. All rights reserved.
//

import UIKit


class OneQuizController: UIViewController {
    
    var quiz: Quiz?
    var questionScrollView: UIScrollView!
    var quizTitle: UILabel!
    var quizImage: UIImageView!
    var startButton: UIButton!
    
    @objc func startQuizAction(sender: UIButton!) {
        print("quiz start")
        self.questionScrollView.isHidden = false
    }

    
    override func viewDidLoad() {
        print("LOADED")
        super.viewDidLoad()
        view.backgroundColor=UIColor.white
        

        let label = UILabel(frame: CGRect(x: 10, y: 10, width: 10, height: 10))
        label.text="Quiz title"
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        let titleX = label.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let titleTop = label.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height*0.08)
        view.addConstraints([titleX, titleTop])
        self.quizTitle = label

        setImageView()
        setStartButton()
        setScrollView()
        initializeWithQuizData()
    }
    
    func setStartButton(){
        
        let button = UIButton(frame: CGRect(x: 10, y: 10, width: 10, height: 10))
        button.setTitle("START QUIZ", for: .normal)
        button.backgroundColor = UIColor.systemGray2
        button.isOpaque = true
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(startQuizAction), for: .touchUpInside)
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false

        let buttonX = button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let buttonTop = button.topAnchor.constraint(equalTo: self.quizImage.bottomAnchor, constant: view.frame.height*0.02)
        let buttonWidth = button.widthAnchor.constraint(equalToConstant: view.frame.width*0.5)
        let buttonHeight = button.heightAnchor.constraint(equalToConstant: view.frame.height*0.07)
        view.addConstraints([buttonX, buttonTop, buttonWidth, buttonHeight])
        self.startButton = button
    }
    
    func setImageView(){
        
        let imgView = UIImageView(frame: CGRect(x: 0,y: 0,width: 100,height: 100))
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.backgroundColor = UIColor.red
        view.addSubview(imgView)

        let imgX = imgView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let imgY = imgView.topAnchor.constraint(equalTo: self.quizTitle.bottomAnchor, constant: view.frame.height*0.02)
        let imgWidth = imgView.widthAnchor.constraint(equalToConstant: view.frame.width*0.7)
        let imgHeight = imgView.heightAnchor.constraint(equalToConstant: view.frame.height*0.18)
        view.addConstraints([imgX, imgY, imgWidth, imgHeight])
        self.quizImage = imgView
    }
    
    func setScrollView(){
        let scrollView = UIScrollView(frame: CGRect(x: 0,y: 0,width: 100,height: 100))
        scrollView.backgroundColor = UIColor.blue
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        let scrollX = scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let scrollTop = scrollView.topAnchor.constraint(equalTo: self.startButton.bottomAnchor, constant: view.frame.height*0.02)
        let scrollBottom = scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.frame.height*0.02)
        let scrollWidth = scrollView.widthAnchor.constraint(equalToConstant: view.frame.width*0.85)
        view.addConstraints([scrollX, scrollTop, scrollBottom, scrollWidth])
        self.questionScrollView = scrollView
        self.questionScrollView.isHidden = true
        
    }
    
    func setupSlideScrollView(questions: [Question]) {
        let slides = createQuestions(questions: questions)
        questionScrollView.contentSize = CGSize(width: questionScrollView.frame.width * CGFloat(slides.count), height: questionScrollView.frame.height)

        
        for i in 0 ..< slides.count {
            questionScrollView.addSubview(slides[i])
        }
        
        questionScrollView.isScrollEnabled = false
    }
    
    func createQuestions(questions: [Question]) -> [QuestionView] {
        var slides: Array<QuestionView> = []
        let questions = quiz?.questions
        for i in 0...questions!.count-1{
            
            var questionView1 = QuestionView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
            questionView1.setQuestionValues(question: questions![i], color: Constants.backgroundColors[quiz!.category]!)
            questionView1.setConstraints(view: questionScrollView)
            slides.append(questionView1)
        }
        return slides
    }
    
    func initializeWithQuizData(){
        self.quizTitle.text = quiz?.title
        fetchQuizImage(pickedQuiz: self.quiz!, imageView: self.quizImage)
        self.setupSlideScrollView(questions: quiz!.questions)
    }
    
    func fetchQuizImage(pickedQuiz: Quiz, imageView: UIImageView){

        let quizService = QuizService()
        quizService.fetchImage(quiz: pickedQuiz) { (fetchedImage) in
                DispatchQueue.main.async {
                    imageView.image = fetchedImage
                }
        }
    }

}
