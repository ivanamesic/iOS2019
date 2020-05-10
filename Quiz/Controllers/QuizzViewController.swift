//
//  QuizzViewController.swift
//  QuizApp
//
//  Created by five on 10/05/2020.
//  Copyright © 2020 Ivana Mesic. All rights reserved.
//

import UIKit

class QuizzViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    
    @IBOutlet weak var funFactLabel: UILabel!
    @IBOutlet weak var wrongFetchLabel: UILabel!
    
    var allQuizzes: Array<Quiz> = []
    var categories: Dictionary<QuizCategory, UIColor> = [:]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.wrongFetchLabel.isHidden = true
    }
    
    @IBAction func fetch(_ sender: UIButton) {
        fetchQuizzes()
    }
    

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allQuizzes.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*let oneQuizController = OneQuizViewController()
        oneQuizController.indexpath = indexPath
        oneQuizController.kategorije = kategorije
        oneQuizController.kvizovi = cells
        //self.cells.removeAll()
        self.navigationController?.pushViewController(oneQuizController, animated: true)*/
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuizTableViewCell", for: indexPath) as! QuizTableViewCell
        
        let thisCell: Quiz = allQuizzes[indexPath.row]
        
        self.wrongFetchLabel.isHidden = true

        cell.quizTitleCell.text = thisCell.title
        cell.quizLevelCell.text = "Level: "+String(thisCell.level)
                
        self.fetchQuizImage(pickedQuiz: thisCell, imageView: cell.quizImageCell)
        return cell
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
                        
                        print(self.allQuizzes)
                        self.funFactLabel.text="FUN FACT: The word NBA is in question text \(number) times"
                        
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
