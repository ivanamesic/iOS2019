//
//  ResultsService.swift
//  Quiz
//
//  Created by five on 07/06/2020.
//  Copyright © 2020 Ivana Mesic. All rights reserved.
//

import Foundation

class ResultsService{
    
    func postSolvedQuiz(urlString: String, jsonData:Data, completion: @escaping ((Any?) -> Void)){
        if let url = URL(string: urlString){
            var request = URLRequest(url:url)
            request.httpMethod="POST"
            let token = UserDefaults.standard.string(forKey: "token")
            request.setValue(token, forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody=jsonData
            
          
            let dataTask = URLSession.shared.dataTask(with: request){(data, response, error) in
                if let httpResponse = response as? HTTPURLResponse{
                    completion(ServerResponse(rawValue: httpResponse.statusCode))
                } else {
                    completion(nil)
                }
            }
            dataTask.resume()

        }
    }
    
    
    func getResultsForQuiz(quizId: Int, completion: @escaping (([Result]?) -> Void)){
        let urlString = Constants.getQuizResultsURL+String(quizId)
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.addValue("225b3ddf80msha350534f81c8c4cp1c0858jsn2a5d1107aad8", forHTTPHeaderField: "X-RapidAPI-Key")
            let token = UserDefaults.standard.string(forKey: "token")
            request.setValue(token, forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "GET"
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let data = data {
                    do {
                        let jsonDecoder = JSONDecoder.init()
                        let results = try jsonDecoder.decode([Result].self, from: data)
                        completion(results)
                        
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
}
