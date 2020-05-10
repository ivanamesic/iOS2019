//
//  QuizViewController.swift
//  Quiz
//
//  Created by five on 10/05/2020.
//  Copyright © 2020 Ivana Mesic. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.wrongFetchLabel.isHidden = true
        self.QuizTableView.delegate = self
        self.QuizTableView.dataSource = self
         QuizTableView.register(UINib(nibName: "QuizTableViewCell", bundle: nil), forCellReuseIdentifier: "QuizTableViewCell")
        //self.QuizTableView.register(QuizTableViewCell.self, forCellReuseIdentifier: "QuizTableViewCell")
        //self.QuizTableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")

    }
    @IBAction func FetchButtonClick(_ sender: UIButton) {
        fetchQuizzes()
    }
    @IBOutlet weak var QuizTableView: UITableView!
    
    @IBOutlet weak var wrongFetchLabel: UILabel!
    
    @IBOutlet weak var funFactLabel: UILabel!
    
    var allQuizzes: Array<Quiz> = []
    var refresher: UIRefreshControl!
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuizTableViewCell", for: indexPath) as? QuizTableViewCell ?? QuizTableViewCell()
        
        let thisCell: Quiz = allQuizzes[indexPath.row]
        
        self.wrongFetchLabel.isHidden = true
        
        cell.quizCellTitle.text = thisCell.title
        cell.quizCellLevel.text = "Level: "+String(thisCell.level)
        //print("cell", cell.quizCellLevel)
        
        self.fetchQuizImage(pickedQuiz: thisCell, imageView: cell.quizCellImage)

        //cell.setValues(image: img, level: lvl, title: thisCell.title)
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("broj redaka: ", allQuizzes.count)
        return allQuizzes.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*let oneQuizController = OneQuizViewController()
        oneQuizController.indexpath = indexPath
        oneQuizController.kategorije = kategorije
        oneQuizController.kvizovi = cells
        //self.cells.removeAll()
        self.navigationController?.pushViewController(oneQuizController, animated: true)*/
        
    }
    
    /*func tableView(_ tableView: UITableView, willDisplay:QuizTableViewCell, indexPath: IndexPath) -> UITableViewCell {
        print("postavljam table2")
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuizTableViewCell", for: indexPath) as! QuizTableViewCell
        
        let thisCell: Quiz = allQuizzes[indexPath.row]
        
        self.wrongFetchLabel.isHidden = true

        //cell.quizCellTitle.text = thisCell.title
        //cell.quizCellLevel.text = "Level: "+String(thisCell.level)
        let lvl = "Level: "+String(thisCell.level)
        let img = self.fetchQuizImage(pickedQuiz: thisCell, imageView: cell.quizCellImage)
        cell.setValues(image: img, level: lvl, title: thisCell.title)
        return cell
    }*/
    
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
                        
                        self.funFactLabel.text="FUN FACT: The word NBA is in question text \(number) times"
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
