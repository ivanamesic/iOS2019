//
//  QuizCategory.swift
//  QuizApp
//
//  Created by five on 09/05/2020.
//  Copyright © 2020 Ivana Mesic. All rights reserved.
//

import Foundation

enum QuizCategory:String{
    
    case sports
    case science
        
    static func allCases()->Array<QuizCategory>{
        return [.sports, .science]
    }
    
    init(name: String) {
        switch name {
        case "SPORTS":
           self = .sports
        default:
            self = .science
        }
        
    }
    
    var text: String {
        switch self {
        case .sports:
            return "SPORTS"
        case .science:
            return "SCIENCE"
        }
    }
    
    
}

