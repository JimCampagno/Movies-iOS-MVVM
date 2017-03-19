//
//  MovieCollectionViewCell.swift
//  NasaImages
//
//  Created by Jim Campagno on 3/9/17.
//  Copyright © 2017 Jim Campagno. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieView: MovieView!
    weak var movie: Movie! {
        didSet {
            movieView.movieViewModel.movie = movie
        }
    }
    var hasNotSetupDelegate: Bool {
        return movieView.movieViewModel.delegate == nil
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        movieView.clearPriorFilm()
    }
    
}
