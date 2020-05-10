//
//  QuiyService.swift
//  QuizApp
//
//  Created by five on 10/05/2020.
//  Copyright © 2020 Ivana Mesic. All rights reserved.
//

import Foundation
import UIKit

class QuizService{
    
    func fetchQuiz(urlString: String, completion: @escaping (([Quiz?]?) -> Void)) {
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.addValue("225b3ddf80msha350534f81c8c4cp1c0858jsn2a5d1107aad8", forHTTPHeaderField: "X-RapidAPI-Key")
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let data = data {
                    
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])

                        var quizzes = [Quiz?]()
                        if let dictionary = json as? [String: Any], let all = dictionary["quizzes"] as? [Any]  {
                            for quiz in all{
                                quizzes.append(Quiz(json:quiz))
                            }
                        }
                        
                        completion(quizzes)
                    } catch {
                        completion(nil)
                    }
                    
                    
                } else {
                    completion(nil)
                }
            }
            dataTask.resume()
        } else {
            completion(nil)
        }

    }
    
    func fetchImage(quiz: Quiz, completion: @escaping ((UIImage?) -> Void)){
        let urlString = quiz.image
        
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)

            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let data = data {
                    let image = UIImage(data: data)
                    completion(image)
                } else {
                    completion(UIImage(named: "Quiz"))
                }
            }
            dataTask.resume()
        } else {
            completion(UIImage(named: "Quiz"))
        }
    }
}
