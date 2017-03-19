//
//  ImageResponse.swift
//  NasaImages
//
//  Created by Jim Campagno on 3/19/17.
//  Copyright © 2017 Jim Campagno. All rights reserved.
//

import Foundation
import UIKit

enum ImageResponse {
    
    case hasImage(image: UIImage, shouldHideLabel: Bool)
    case imageDownloadComplete(image: UIImage, shouldHideLabel: Bool, canDisplayImage: Bool)
    
}
