//
//  SearchQuery.swift
//  NasaImages
//
//  Created by Jim Campagno on 3/8/17.
//  Copyright © 2017 Jim Campagno. All rights reserved.
//

import Foundation

struct SearchQuery {
    
    let string: String
    
    init?(query: String) {
        guard let searchString = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return nil }
        string = searchString
    }
    
}
