//
//  MovieView.swift
//  NasaImages
//
//  Created by Jim Campagno on 3/8/17.
//  Copyright © 2017 Jim Campagno. All rights reserved.
//

import Foundation
import UIKit


final class MovieView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieLabel: UILabel!
    let duration: TimeInterval = 1.5
    lazy var movieViewModel: MovieViewModel = { [unowned self] in
        MovieViewModel(movieUpdated: self.moviedUpdated)
        }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
}

// MARK: - Setup Methods
extension MovieView {
    
    fileprivate func commonInit() {
        Bundle.main.loadNibNamed("MovieView", owner: self, options: nil)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        contentView.constrainEdges(to: self)
        setupTapGesture()
        clearPriorFilm()
    }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(detailForMovie))
        addGestureRecognizer(tapGesture)
    }
    
}

//MARK: - Movie Methods
extension MovieView {
    
    func moviedUpdated(_ response: ImageResponse?) {
        movieLabel.text = movieViewModel.titleForLabel
        
        guard let response = response else { return }
        
        switch response {
        case let .hasImage(image, shouldHideMovieLabel):
            self.displayMovie(image: image, shouldHideLabel: shouldHideMovieLabel)
            
        case let .imageDownloadComplete(image, shouldHideLabel, canDisplayImage):
            guard canDisplayImage else { return }
            self.displayMovie(image: image, shouldHideLabel: shouldHideLabel, animate: true)
        }
    }
    
    private func displayMovie(image: UIImage, shouldHideLabel: Bool, animate: Bool = false) {
        switch animate {
        case false:
            self.movieImageView.image = image
            self.movieLabel.isHidden = shouldHideLabel
            
        case true:
            self.movieImageView.alpha = 0
            self.movieImageView.image = image
            UIView.animate(withDuration: self.duration, animations: {
                self.movieImageView.alpha = 1.0
                self.movieLabel.isHidden = shouldHideLabel
            })
        }
    }
    
    func detailForMovie() {
        movieViewModel.showMovieDetail()
    }
    
}

// MARK: - ReUse Methods
extension MovieView {
    
    func clearPriorFilm() {
        movieImageView.image = nil
        movieLabel.text = nil
        movieLabel.isHidden = true
    }
    
}



