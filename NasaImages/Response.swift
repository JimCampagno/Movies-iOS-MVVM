//
//  Response.swift
//  NasaImages
//
//  Created by Jim Campagno on 3/8/17.
//  Copyright © 2017 Jim Campagno. All rights reserved.
//

import Foundation

typealias JSON = [String : Any]

enum Response {
    
    case success(JSON)
    case badURL(String)
    case badData(String)
    case badJSON(String)
    case noImage(String)
    case noInterent(String)
    
}
