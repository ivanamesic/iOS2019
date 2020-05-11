//
//  QuizViewController.swift
//  Quiz
//
//  Created by five on 10/05/2020.
//  Copyright © 2020 Ivana Mesic. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBAction func FetchButtonClick(_ sender: UIButton) {
        if sender.tag != 0 {return}
        fetchQuizzes()
    }
    @IBOutlet weak var QuizTableView: UITableView!
    @IBOutlet weak var wrongFetchLabel: UILabel!
    @IBOutlet weak var funFactLabel: UILabel!
    @IBOutlet weak var questionView: UIView!

    @IBAction func SignOutButton(_ sender: UIButton) {
        if sender.tag != 1 {return}
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: "token")
        userDefaults.removeObject(forKey: "user_id")
    }
    
    var allQuizzes: Array<Quiz> = []
    var backgroundColors: Dictionary<QuizCategory, UIColor> = [:]
    var refresher: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.wrongFetchLabel.isHidden = true
        self.QuizTableView.delegate = self
        self.QuizTableView.dataSource = self
        self.questionView.isHidden = true
        QuizTableView.register(UINib(nibName: "QuizTableViewCell", bundle: nil), forCellReuseIdentifier: "QuizTableViewCell")
        backgroundColors[QuizCategory.science] = UIColor(displayP3Red: 0.572, green: 0.827, blue: 0.643, alpha: 1.0)
        backgroundColors[QuizCategory.sports] = UIColor(displayP3Red: 0.368, green: 0.584, blue: 0.729, alpha: 1.0)

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuizTableViewCell", for: indexPath) as? QuizTableViewCell ?? QuizTableViewCell()
        
        let thisCell: Quiz = allQuizzes[indexPath.row]
        
        self.wrongFetchLabel.isHidden = true
        
        cell.backgroundColor = backgroundColors[thisCell.category]
        cell.quizCellTitle.text = thisCell.title
        cell.quizCellLevel.text = "Level: "+String(thisCell.level)
        //print("cell", cell.quizCellLevel)
        
        self.fetchQuizImage(pickedQuiz: thisCell, imageView: cell.quizCellImage)
        
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allQuizzes.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chosenQuiz = allQuizzes[indexPath.row]
        let chosenQuestion = chosenQuiz.questions[0]
        print("aaaaa")
        let customView = (Bundle.main.loadNibNamed("QuestionView", owner: QuestionView.self, options: [:])?.first as? QuestionView)!
        self.questionView.addSubview(customView)
        //var view = QuestionView(frame: CGRect(x: 10, y: 30, width: 50, height: 40))
        //self.questionView.setValues(question: chosenQuestion, color: Constants.backgroundColors[chosenQuiz.category]!)
        print("heere2")
        
        /*let oneQuizController = OneQuizViewController()
        oneQuizController.indexpath = indexPath
        oneQuizController.kategorije = kategorije
        oneQuizController.kvizovi = cells
        //self.cells.removeAll()
        self.navigationController?.pushViewController(oneQuizController, animated: true)*/
        
    }
    
    func fetchQuizzes() {
            print("Fetching...")
            let urlString = "https://iosquiz.herokuapp.com/api/quizzes"
            let quizService = QuizService()
            
            quizService.fetchQuiz(urlString: urlString) { (quizArray) in
                DispatchQueue.main.async {
                    if let quizArray = quizArray {
                        self.wrongFetchLabel.isHidden = true
                        var collection: Array<String> = []
                        var temp: Array<Quiz> = []
                        for quiz in quizArray{
                            temp.append(quiz!)
                            for question in quiz!.questions{
                                collection.append(question.questionText)
                            }
                        }
                        
                        let number = collection.filter({e in e.contains("NBA")}).count
                        
                        self.allQuizzes.removeAll()
                        self.allQuizzes = temp
                        
                        self.funFactLabel.text="FUN FACT: The word NBA is in questions \(number) times"
                        self.QuizTableView.reloadData()
                        
                    } else{
                        self.wrongFetchLabel.isHidden = false
                    }
                }
            }
            
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
