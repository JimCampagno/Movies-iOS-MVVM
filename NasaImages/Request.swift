//
//  Request.swift
//  NasaImages
//
//  Created by Jim Campagno on 3/8/17.
//  Copyright © 2017 Jim Campagno. All rights reserved.
//

import Foundation


enum Request {
    
    static private let baseURL = "http://www.omdbapi.com"
    
    case search(SearchQuery)
    case imdbID(String)
    
    var url: URL? {
        var string: String
        
        switch self {
        case .search(let query):
            string = Request.baseURL + "/?s=\(query.string)"
            return URL(string: string)
        case .imdbID(let id):
            string = Request.baseURL + "/?i=\(id)"
        }
        
        return URL(string: string)
    }

}
