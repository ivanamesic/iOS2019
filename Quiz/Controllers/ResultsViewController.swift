//
//  ResultsViewController.swift
//  Quiz
//
//  Created by five on 07/06/2020.
//  Copyright © 2020 Ivana Mesic. All rights reserved.
//

import UIKit

struct LeaderboardResponse: Decodable{
    var results: [Result]
}

struct Result: Decodable {
    var score: String?
    var username: String?
    
    enum CodingKeys: String, CodingKey {
        case score
        case username
    }
}

class ResultsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource  {

    let tableView = UITableView()
    var safeArea: UILayoutGuide!
    let closeButton = UIButton(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
    var leaderboardResults: [Result]?
    @objc func closeLeaderboard(){
        self.navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        safeArea = view.layoutMarginsGuide
        setupButton()
        setupTableView()
    }
    
    func setupButton(){
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.addTarget(self, action: #selector(closeLeaderboard), for: .touchUpInside)
        closeButton.setTitle("Close", for: .normal)
        closeButton.backgroundColor = UIColor.white
        closeButton.setTitleColor(UIColor(red: 0.11, green: 0.42, blue: 0.75, alpha: 1.00), for: .normal)
        view.addSubview(closeButton)

        closeButton.widthAnchor.constraint(equalToConstant: view.frame.width*0.2).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: view.frame.height*0.05).isActive = true
        closeButton.rightAnchor.constraint(equalTo: safeArea.rightAnchor).isActive = true
        closeButton.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: view.frame.height*0.02).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.register(LeaderboardCell.self, forCellReuseIdentifier: "LeaderboardCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaderboardResults!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeaderboardCell", for: indexPath) as! LeaderboardCell

        let result: Result = leaderboardResults![indexPath.row]
        cell.result = result
        
        return cell
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
