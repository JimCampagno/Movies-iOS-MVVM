//
//  MovieSearchCViewController.swift
//  NasaImages
//
//  Created by Jim Campagno on 3/9/17.
//  Copyright © 2017 Jim Campagno. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MovieCell"

class MovieSearchCViewController: UICollectionViewController {
    
    fileprivate let sectionInsets = UIEdgeInsets(top: 25.0, left: 25.0, bottom: 25.0, right: 25.0)
    fileprivate let itemsPerRow: CGFloat = 2
    fileprivate let aspectRatio: (w: CGFloat, h: CGFloat) = (300, 450)
    @IBOutlet weak var searchTextField: UITextField!
    var movies: [Movie] = []
    var isSearching = false
    var originalContentOffset: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageView = UIImageView(frame: view.bounds)
        imageView.image = #imageLiteral(resourceName: "MovieBackground")
        collectionView?.backgroundView = imageView
        // view.insertSubview(imageView, at: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        originalContentOffset = collectionView!.contentOffset
        searchTextField.delegate = self
    }
    
}

// MARK: - UICollection View DataSource
extension MovieSearchCViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MovieCollectionViewCell
        if cell.hasNotSetupDelegate { cell.movieView.movieViewModel.delegate = self }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let movieCell = cell as! MovieCollectionViewCell
        movieCell.movie = movies[indexPath.row]
    }
    
}

// MARK: - MovieView Delegate
extension MovieSearchCViewController: MovieViewModelDelegate {
    
    func movieViewModel(_ movieViewModel: MovieViewModel, canDisplayMovie movie: Movie) -> Bool {
        var visibleMovies: Set<String> = []
        
        let visibleIndexPaths = collectionView?.indexPathsForVisibleItems ?? []
        
        for indexPath in visibleIndexPaths {
            let movieAtIndexPath = movies[indexPath.row]
            visibleMovies.insert(movieAtIndexPath.imdbID)
        }
        
        return visibleMovies.contains(movie.imdbID)
    }
    
    func movieViewModel(_ movieViewModel: MovieViewModel, showDetailForMovie movie: Movie) {
        print(movie.title)
    }
    
}

// MARK: - TextField Delegate
extension MovieSearchCViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if !isSearching {
            searchForFilm(with: textField.text)
        }
        
        return true
    }
}

// MARK: - Movie Search Films
extension MovieSearchCViewController {
    
    func searchForFilm(with title: String?) {
        guard let query = title, let searchQuery = SearchQuery(query: query)
            else { return }
        isSearching = true
        let request = Request.search(searchQuery)
        OMDbAPIManager.get(request: request, handler: { [unowned self] response in
            switch response {
            case .success(let json):
                self.createMovies(with: json)
            default:
                fatalError("Can't make json!")
            }
            self.isSearching = false
        })
    }
    
    func createMovies(with json: JSON) {
        guard let search = json["Search"] as? [[String : String]] else { return }
        movies.removeAll()
        for filmInfo in search {
            movies.append(Movie(dictionary: filmInfo))
        }
        collectionView?.setContentOffset(originalContentOffset, animated: true)
        collectionView?.reloadData()
    }
    
}

// MARK: - Collection Layout
extension MovieSearchCViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let width = availableWidth / itemsPerRow
        let multiplyValue: CGFloat = 1.0 + ((aspectRatio.h - aspectRatio.w) / aspectRatio.w)
        let height = width * multiplyValue
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    
}
