//
//  OMDbAPIManager.swift
//  NasaImages
//
//  Created by Jim Campagno on 3/8/17.
//  Copyright © 2017 Jim Campagno. All rights reserved.
//

import Foundation
import UIKit



final class OMDbAPIManager {
    
    static func get(request: Request, handler: @escaping (Response) -> Void) {
        guard let url = request.url else { handler(.badURL("Can't generate URL")); return }
        let urlRequest = URLRequest(url: url)
        let session = URLSession.shared
        session.dataTask(with: urlRequest, completionHandler: { data, response, error in
            DispatchQueue.main.async {
                guard let json = self.generateJSON(with: data)
                    else { handler(.badJSON("Can't generate JSON")); return }
                handler(.success(json))
            }
        }).resume()
    }
    
}

// MARK: - Image Downloads
extension OMDbAPIManager {
    
    static func downloadImage(at url: URL, handler: @escaping (UIImage?) -> Void) {
        let session = URLSession.shared
        let request = URLRequest(url: url)
        session.dataTask(with: request, completionHandler: { data, response, error in
            DispatchQueue.main.async {
                guard let rawData = data, let image = UIImage(data: rawData)
                    else { handler(nil); return }
                handler(image)
            }
        }).resume()
    }
    
    
}

// MARK: - Helper Methods
extension OMDbAPIManager {
    
    static fileprivate func generateJSON(with data: Data?) -> JSON? {
        guard let data = data else { return nil }
        do {
            return try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? JSON
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
}
