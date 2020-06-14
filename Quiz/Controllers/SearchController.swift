//
//  SearchController.swift
//  Quiz
//
//  Created by five on 12/06/2020.
//  Copyright © 2020 Ivana Mesic. All rights reserved.
//

import UIKit

class SearchController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    var textField = UITextField()
    var searchButton = UIButton()
    var tableView = UITableView()
    
    var searchResults: Array<Array<Quiz>> = []
    var refresher: UIRefreshControl!
    var groupedByCategories: [QuizCategory: Array<Quiz>] = [:]
    var categories: [Int:QuizCategory] = [:]
    
    @objc func beginSearchAction(_ sender: UIButton){
        self.search()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.tableView.delegate = self
        self.tableView.dataSource = self
        createElements()
        addConstraints()
        
        tableView.register(UINib(nibName: "QuizTableViewCell", bundle: nil), forCellReuseIdentifier: "QuizTableViewCell")
        // Do any additional setup after loading the view.
    }
    
    func createElements(){
        textField.layer.cornerRadius = 15.0
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = CGColor.init(srgbRed: 0.62, green: 0.64, blue: 0.66, alpha: 1.00)
        textField.textAlignment = NSTextAlignment.center
        
        searchButton.setTitle("SEARCH", for: .normal)
        searchButton.backgroundColor = UIColor(red: 0.11, green: 0.42, blue: 0.75, alpha: 1.00)
        searchButton.setTitleColor(UIColor.white, for: .normal)
        searchButton.addTarget(self, action: #selector(beginSearchAction(_:)), for: .touchUpInside)
        
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(textField)
        view.addSubview(searchButton)
        view.addSubview(tableView)
        
    }
    
    func addConstraints(){
        let t1 = textField.widthAnchor.constraint(equalToConstant: view.frame.width*0.8)
        let t2 = textField.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let t3 = textField.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height*0.08 )
        let t4 = textField.heightAnchor.constraint(equalToConstant: view.frame.height*0.06)
        view.addConstraints([t1,t2,t3,t4])
        
        let b1 = searchButton.widthAnchor.constraint(equalToConstant: view.frame.width*0.5)
        let b2 = searchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let b3 = searchButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: view.frame.height*0.03)
        view.addConstraints([b1,b2,b3])
        
        let v1 = tableView.widthAnchor.constraint(equalToConstant: view.frame.width*0.9)
        let v2 = tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let v3 = tableView.topAnchor.constraint(equalTo: searchButton.bottomAnchor, constant: view.frame.height*0.03)
        let v4 = tableView.heightAnchor.constraint(equalToConstant: view.frame.height*0.7)
        view.addConstraints([v1,v2,v3,v4])

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return searchResults.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuizTableViewCell", for: indexPath) as? QuizTableViewCell ?? QuizTableViewCell()
        
        let thisCell: Quiz = searchResults[indexPath.section][indexPath.row]
                
        cell.quizCellTitle.text = thisCell.title
        var lvl = "";
        for _ in 1...thisCell.level{
            lvl += "*"
        }
        cell.quizCellLevel.text = lvl
        cell.quizCellDescription.text=thisCell.description
        self.fetchQuizImage(pickedQuiz: thisCell, imageView: cell.quizCellImage)
        
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults[section].count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let oneQuizController = OneQuizController()
        let quiz = searchResults[indexPath.section][indexPath.row]
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
    
    func fetchQuizImage(pickedQuiz: Quiz, imageView: UIImageView){

        let quizService = QuizService()
        quizService.fetchImage(quiz: pickedQuiz) { (fetchedImage) in
                DispatchQueue.main.async {
                    imageView.image = fetchedImage
                }
        }
    }
    
    func search(){
        let keyWord = self.textField.text
        let quizzes = PersistenceService.getFilteredQuizzesCD(constant: keyWord!)
        fillElementsWithData(quizzes: quizzes)
    }
    
    func fillElementsWithData(quizzes: [Quiz]){
        var tempDict: [QuizCategory:Array<Quiz>] = [:]
        for quiz in quizzes{
            var res = tempDict[quiz.category]
            if res==nil{
                let newar = [quiz]
                tempDict[quiz.category]=newar
            } else {
                res?.append(quiz)
                tempDict[quiz.category]=res
            }
        }
        
        self.groupedByCategories=tempDict
        self.searchResults.removeAll()
        var counter = 0
        for (cat, ar) in tempDict{
            self.searchResults.append(ar)
            self.categories[counter]=cat
            counter += 1
        }
        self.tableView.reloadData()
    }

}
