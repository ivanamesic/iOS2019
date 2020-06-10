//
//  LeaderboardCell.swift
//  Quiz
//
//  Created by five on 09/06/2020.
//  Copyright © 2020 Ivana Mesic. All rights reserved.
//

import UIKit

class LeaderboardCell: UITableViewCell {
    
    var result:Result? {
        didSet {
            guard let resultItem = result else {return}
            if let username = resultItem.username {
                usernameLabel.text = username
            }
            if let score = resultItem.score {
                if let s = Double(score) {
                    scoreLabel.text = String(format: "%.3f", s)
                } else {
                    scoreLabel.text = String(0)
                }
            } else {
                scoreLabel.text = String(0)
            }
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(usernameLabel)
        self.contentView.addSubview(scoreLabel)
        usernameLabel.leftAnchor.constraint(equalTo:self.contentView.leftAnchor, constant:20).isActive = true
        usernameLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        scoreLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        scoreLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -20).isActive = true

     }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

     required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    let usernameLabel:UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = UIColor.black
            return label
    }()
    
    let scoreLabel:UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = UIColor.systemGray2
            return label
    }()
    
    
}
