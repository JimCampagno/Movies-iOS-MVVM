//
//  MovieViewModel.swift
//  NasaImages
//
//  Created by Jim Campagno on 3/19/17.
//  Copyright © 2017 Jim Campagno. All rights reserved.
//

import Foundation
import UIKit


typealias MovieUpdatedClosure = (ImageResponse?) -> Void

protocol MovieViewModelDelegate: class {
    func movieViewModel(_ movieViewModel: MovieViewModel, canDisplayMovie movie: Movie) -> Bool
    func movieViewModel(_ movieViewModel: MovieViewModel, showDetailForMovie movie: Movie)
}

final class MovieViewModel {
    
    let movieUpdated: MovieUpdatedClosure
    weak var delegate: MovieViewModelDelegate?
    
    weak var movie: Movie! {
        didSet {
            setupMovie()
        }
    }
    
    var titleForLabel: String {
        return movie.title
    }
    
    init(movieUpdated: @escaping MovieUpdatedClosure) {
        self.movieUpdated = movieUpdated
    }
    
}

// MARK: - Image Downloads
extension MovieViewModel {
    
    func setupMovie() {
        guard !movie.hasImage else { movieAlreadyHasImage(); return }
        guard !movie.isDownloading else { movieIsDownloadingImage(); return }
        
        movie.downloadImage(handler: { success in
            guard success else { self.movieUpdated(nil); return }
            self.movieHasFinishedDownloadingImage()
        })
    }
    
    private func movieAlreadyHasImage() {
        movieUpdated(ImageResponse.hasImage(image: movie.image!, shouldHideLabel: !movie.hasNoPoster))
    }
    
    private func movieHasFinishedDownloadingImage() {
        let canDisplayImage = self.delegate?.movieViewModel(self, canDisplayMovie: self.movie) ?? false
        let response = ImageResponse.imageDownloadComplete(image: self.movie.image!, shouldHideLabel: !self.movie.hasNoPoster, canDisplayImage: canDisplayImage)
        self.movieUpdated(response)
    }
    
    private func movieIsDownloadingImage() {
        movieUpdated(nil)
    }
    
}

// MARK: - Movie Detail
extension MovieViewModel {
    
    func showMovieDetail() {
        delegate?.movieViewModel(self, showDetailForMovie: movie)
    }
    
}
