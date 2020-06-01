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

    @objc func SignOutButton(_ sender: UIButton) {
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: "token")
        userDefaults.removeObject(forKey: "user_id")
        print("Logging out...")
        self.navigationController?.pushViewController(LoginViewController(), animated: false)
        
    }
    
    var allQuizzes: Array<Array<Quiz>> = []
    var refresher: UIRefreshControl!
    var groupedByCategories: [QuizCategory: Array<Quiz>] = [:]
    var categories: [Int:QuizCategory] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.wrongFetchLabel.isHidden = true
        self.QuizTableView.delegate = self
        self.QuizTableView.dataSource = self
        
        QuizTableView.register(UINib(nibName: "QuizTableViewCell", bundle: nil), forCellReuseIdentifier: "QuizTableViewCell")
        self.QuizTableView.tableFooterView=getTableFooter(self.QuizTableView)
        self.view.isHidden = false

    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           navigationController?.navigationBar.isTranslucent = true
           navigationController?.navigationBar.barTintColor = .clear
    }
    
    
    func getTableFooter(_ tableView: UITableView)->UIView{
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 25))
        let button = UIButton(frame: CGRect(x: 10, y: 5, width: tableView.frame.size.width, height: 25))
        button.setTitle("Log out", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.darkGray
        button.isOpaque = true
        button.addTarget(self, action: #selector(SignOutButton(_:)), for: .touchUpInside)
        footerView.addSubview(button)
        return footerView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return allQuizzes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuizTableViewCell", for: indexPath) as? QuizTableViewCell ?? QuizTableViewCell()
        
        let thisCell: Quiz = allQuizzes[indexPath.section][indexPath.row]
        
        self.wrongFetchLabel.isHidden = true
        
        cell.quizCellTitle.text = thisCell.title
        var lvl = "";
        for i in 1...thisCell.level{
            lvl += "*"
        }
        cell.quizCellLevel.text = lvl
        cell.quizCellDescription.text=thisCell.description
        self.fetchQuizImage(pickedQuiz: thisCell, imageView: cell.quizCellImage)
        
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allQuizzes[section].count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.section, indexPath.row)
        let oneQuizController = OneQuizController()
        let quiz = allQuizzes[indexPath.section][indexPath.row]
        oneQuizController.quiz = quiz
        self.navigationController?.pushViewController(oneQuizController, animated: false)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 18))
        let label = UILabel(frame: CGRect(x: 10, y: 5, width: tableView.frame.size.width, height: 18))
        label.text = categories[section]?.text
        view.backgroundColor = Constants.backgroundColors[categories[section]!]
        view.addSubview(label)
        return view
    }
    
    
    func fetchQuizzes() {
            let urlString = "https://iosquiz.herokuapp.com/api/quizzes"
            let quizService = QuizService()
            
            quizService.fetchQuiz(urlString: urlString) { (quizArray) in
                DispatchQueue.main.async {
                    if let quizArray = quizArray {
                        self.wrongFetchLabel.isHidden = true
                        var collection: Array<String> = []
                        var tempDict: [QuizCategory:Array<Quiz>] = [:]
                        for quiz in quizArray{
                            for question in quiz!.questions{
                                collection.append(question.questionText)
                            }
                            var res = tempDict[quiz!.category]
                            if res==nil{
                                var newar = [quiz!]
                                tempDict[quiz!.category]=newar
                            } else {
                                res?.append(quiz!)
                                tempDict[quiz!.category]=res
                            }
                        }
                        
                        let number = collection.filter({e in e.contains("NBA")}).count
                        self.groupedByCategories=tempDict
                        self.allQuizzes.removeAll()
                        var counter = 0
                        for (cat, ar) in tempDict{
                            self.allQuizzes.append(ar)
                            self.categories[counter]=cat
                            counter += 1
                        }
                        
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
