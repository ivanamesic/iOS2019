//
//  QuizTableViewCell.swift
//  QuizApp
//
//  Created by five on 10/05/2020.
//  Copyright © 2020 Ivana Mesic. All rights reserved.
//

import UIKit

class QuizTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var quizCellImage: UIImageView!
    @IBOutlet weak var quizCellLevel: UILabel!
    @IBOutlet weak var quizCellTitle: UILabel!
    
    
    func setValues(image: UIImageView, level: String, title: String){
        self.quizCellImage = image
        self.quizCellLevel?.text = level
        self.quizCellTitle?.text = title
    }
}
