//
//  OneQuizController.swift
//  Quiz
//
//  Created by five on 01/06/2020.
//  Copyright © 2020 Ivana Mesic. All rights reserved.
//

import UIKit

struct SolvedQuiz: Codable {
    var quiz_id: Int?
    var user_id: Int?
    var time: TimeInterval?
    var no_of_correct: Int?

}

extension OneQuizController: QuizProtocol{
    func questionAnswered() {
        self.numberOfAnswered!+=1
        if quiz!.questions.count==numberOfAnswered{
            self.duration = Date.init().timeIntervalSince(startTime!)
            self.sendQuiz()
        }else{
            var begin: CGPoint = questionScrollView.contentOffset
            begin.x += self.scrollPaneWidth!
            questionScrollView.setContentOffset(begin, animated: true)
        }
    }
          
    func correctQuestion() {
      self.numberOfCorrect! += 1
    }
}


class OneQuizController: UIViewController {
    
    var quiz: Quiz?
    var questionScrollView: UIScrollView!
    var quizTitle: UILabel!
    var quizImage: UIImageView!
    var startButton: UIButton!
    
    var duration: TimeInterval?
    var startTime: Date?
    var numberOfCorrect: Int? = 0
    var numberOfAnswered: Int? = 0
    var scrollPaneWidth: CGFloat?
    var scrollPaneHeight: CGFloat?
    
    @objc func startQuizAction(sender: UIButton!) {
        self.questionScrollView.isHidden = false
        self.startButton.isHidden = true
        self.startTime = Date.init()
    }
    
   

    
    override func viewDidLoad() {
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
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        let scrollX = scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let scrollTop = scrollView.topAnchor.constraint(equalTo: self.startButton.bottomAnchor, constant: view.frame.height*0.02)
        self.scrollPaneWidth = view.frame.width*0.85
        let scrollWidth = scrollView.widthAnchor.constraint(equalToConstant: scrollPaneWidth!)
        self.scrollPaneHeight = view.frame.height*0.55
        let scrollHeight = scrollView.heightAnchor.constraint(equalToConstant: scrollPaneHeight!)

        view.addConstraints([scrollX, scrollTop, scrollHeight, scrollWidth])

        self.questionScrollView = scrollView
        self.questionScrollView.isHidden = true
    }
    
    func setupSlideScrollView(questions: [Question]) {
        let questions = quiz?.questions
        questionScrollView.contentSize = CGSize(width: self.scrollPaneWidth! * CGFloat(questions!.count), height: self.scrollPaneHeight!)
        for q in 0...questions!.count-1 {
            let newView = QuestionView(frame: CGRect(x:CGFloat(q)*self.scrollPaneWidth!,y: 0,width: self.scrollPaneWidth!,height: self.scrollPaneHeight!), question: questions![q], color: Constants.backgroundColors[quiz!.category]!)
            newView.delegate = self
            self.questionScrollView.addSubview(newView)
        }
        
        questionScrollView.isScrollEnabled = false
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
    
    func sendQuiz(){
        let quizService = QuizService()
        let userId = UserDefaults.standard.value(forKey: "user_id") as! Int
        let urlString = Constants.sendOneQuizURL
        let solvedQuiz = SolvedQuiz(quiz_id: quiz?.id, user_id: userId, time: self.duration, no_of_correct: self.numberOfCorrect)
        let jsonEncoder = JSONEncoder()
        let quizData = try? jsonEncoder.encode(solvedQuiz)
        
        quizService.postSolvedQuiz(urlString: urlString, jsonData: quizData!){ (e) in
            DispatchQueue.main.async {
                if e != nil {
                    let code = e as! ServerResponse
                    if code==ServerResponse.SUCCESS{
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                            self.navigationController?.popViewController(animated: false)
                        })
                    } else {
                        let title = "Error \(code.rawValue)"
                        let alert = UIAlertController(title: title, message:"Something went wrong while posting quiz results, try again.", preferredStyle: UIAlertController.Style.alert)
                        let tryAgainButton = UIAlertAction(title: "Try again", style: .default, handler: {(_ action: UIAlertAction) -> Void in
                            self.sendQuiz()
                        })
                        let cancelButton = UIAlertAction(title: "Cancel", style: .default, handler: {(_ action: UIAlertAction) -> Void in
                            self.navigationController?.popViewController(animated: true)
                        })
                        alert.addAction(tryAgainButton)
                        alert.addAction(cancelButton)
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                }else{
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                                           self.navigationController?.popViewController(animated: false)
                    })
                    
                }
            }
        }
    }

}
