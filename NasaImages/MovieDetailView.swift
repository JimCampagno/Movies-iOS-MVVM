//
//  MovieDetailView.swift
//  NasaImages
//
//  Created by Jim Campagno on 3/13/17.
//  Copyright © 2017 Jim Campagno. All rights reserved.
//

import UIKit

class MovieDetailView: UIView {
    
    @IBOutlet var contentView: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("MovieDetailView", owner: self, options: nil)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        contentView.constrainEdges(to: self)
    }
    
    
    
    

}
