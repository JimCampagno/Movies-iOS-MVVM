//
//  MovieView.swift
//  NasaImages
//
//  Created by Jim Campagno on 3/8/17.
//  Copyright © 2017 Jim Campagno. All rights reserved.
//

import Foundation
import UIKit

protocol MovieViewDelegate: class {
    func movieView(_ movieView: MovieView, canDisplayMovie movie: Movie) -> Bool
    func movieView(_ movieView: MovieView, showDetailForMovie movie: Movie)
}

final class MovieView: UIView {
  
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieLabel: UILabel!
    weak var delegate: MovieViewDelegate?
    
    
    var movie: Movie! {
        didSet {
            setupMovie()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("MovieView", owner: self, options: nil)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        contentView.constrainEdges(to: self)
        clearPriorFilm()
        // TODO: Handle when there is no poster image, display title.
        movieLabel.isHidden = true
        setupTapGesture()
    }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(detailForMovie))
        addGestureRecognizer(tapGesture)
    }
    
    func detailForMovie() {
        delegate?.movieView(self, showDetailForMovie: movie)
    }
}

//MARK: - Movie Methods
extension MovieView {
    
    func setupMovie() {
        movieLabel.text = movie.title
        
        if movie.image != nil {
            movieImageView.image = movie.image!
            if movie.hasNoPoster {
                movieLabel.isHidden = false
            }
            return
        }
        
        if !movie.isDownloading {
            movie.downloadImage(handler: { success in                
                if success {
                    let canDisplayImage = self.delegate?.movieView(self, canDisplayMovie: self.movie) ?? false
                    if canDisplayImage {
                        self.movieImageView.alpha = 0.0
                        self.movieImageView.image = self.movie.image
                        UIView.animate(withDuration: 1.5, animations: {
                            self.movieImageView.alpha = 1.0
                            if self.movie.hasNoPoster {
                                self.movieLabel.isHidden = false
                            }
                        })
                    }
                }
            })
        }
    }

    func clearPriorFilm() {
        movieImageView.image = nil
        movieLabel.text = nil
        movieLabel.isHidden = true
    }
    
}


//MARK: - Constraint Methods
extension UIView {
    
    func constrainEdges(to view: UIView) {
        leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
    
}

