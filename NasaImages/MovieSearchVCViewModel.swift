//
//  MovieSearchVCViewModel.swift
//  NasaImages
//
//  Created by Jim Campagno on 3/23/17.
//  Copyright © 2017 Jim Campagno. All rights reserved.
//

import Foundation


final class MovieSearchVCViewModel {
    
    var movies: [Movie] = []
    
    var itemsInRow: Int {
        return movies.count
    }

}
