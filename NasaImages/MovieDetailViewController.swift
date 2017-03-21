//
//  MovieDetailViewController.swift
//  NasaImages
//
//  Created by Jim Campagno on 3/20/17.
//  Copyright © 2017 Jim Campagno. All rights reserved.
//

import Foundation
import UIKit

final class MovieDetailViewController: UIViewController {
    
    var movie: Movie!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        print(movie.title)
    }
    
}
