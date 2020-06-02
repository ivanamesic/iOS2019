//
//  LoginService.swift
//  QuizApp
//
//  Created by five on 09/05/2020.
//  Copyright © 2020 Ivana Mesic. All rights reserved.
//

import Foundation
import UIKit

class LoginService{
    
    func sendLoginRequest(urlString: String, jsonData:[String:Any], completion: @escaping ((Any?) -> Void)){
        if let url = URL(string: urlString) {
            var request = URLRequest(url:url)
            request.httpMethod="POST"
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let json = try? JSONSerialization.data(withJSONObject: jsonData)
            request.httpBody=json
            
            let dataTask = URLSession.shared.dataTask(with: request){(data, response, error) in
                if let data = data {
                    do{
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary

                        
                        if let parseJSON = json,
                            let token = parseJSON["token"] as? String,
                            let id = parseJSON["user_id"] as? Int{
                            let userDefaults = UserDefaults.standard
                            userDefaults.set(id, forKey: "user_id")
                            userDefaults.set(token, forKey: "token")
                            completion(json)
                        } else {
                            completion(nil)
                        }
                        
                    }catch{
                        completion(nil)
                    }
                } else {
                    completion(nil)
                }
                
            }
            dataTask.resume()
            
            
            
        }
    }
}
