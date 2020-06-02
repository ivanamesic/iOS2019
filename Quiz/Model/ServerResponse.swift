//
//  ServerResponse.swift
//  Quiz
//
//  Created by five on 02/06/2020.
//  Copyright © 2020 Ivana Mesic. All rights reserved.
//

import Foundation

enum ServerResponse:Int{
    
    case UNAUTHORIZED = 401
    case FORBBIDEN = 403
    case NOT_FOUND = 404
    case BAD_REQUEST = 400
    case SUCCESS = 200
    
}
