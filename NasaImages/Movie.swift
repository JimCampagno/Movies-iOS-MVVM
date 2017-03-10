//
//  Movie.swift
//  NasaImages
//
//  Created by Jim Campagno on 3/8/17.
//  Copyright © 2017 Jim Campagno. All rights reserved.
//

import Foundation
import UIKit

final class Movie {
    
    let title: String
    let imdbID: String
    let year: String
    let poster: String
    var image: UIImage?
    var isDownloading = false
    
    init(dictionary: [String : String]) {
        title = dictionary["Title"] ?? "No Title"
        imdbID = dictionary["imdbID"] ?? "No ID"
        year = dictionary["Year"] ?? "No Year"
        poster = dictionary["Poster"] ?? "No Poster"
    }
    
}


// MARK: - Download Methods
extension Movie {
    
    func downloadImage(handler: @escaping (Bool) -> Void) {
        guard let url = URL(string: poster) else { handler(false); return }
        isDownloading = true
        OMDbAPIManager.downloadImage(at: url, handler: { movieImage in
            self.image = movieImage
            handler(true)
        })
    }
    
}

// MARK: - Hash Value
extension Movie: Hashable {
    
    var hashValue: Int {
        return imdbID.hashValue
    }
    
    static func ==(lhs: Movie, rhs: Movie) -> Bool {
        return lhs.imdbID == rhs.imdbID
    }
}
