//
//  ImageCache.swift
//  BottleRocketRestaurant
//
//  Created by Pawel Milek.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import Foundation
import UIKit

final class ImageCache {
    static var sharedCache = NSCache<NSString, UIImage>()

    typealias ImageCacheCompletion = (UIImage) -> ()
    
    static func fetchImage(with url: URL, completionHandler: @escaping ImageCacheCompletion) {
        let task = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
            if error == nil {
                if let imageData = data, let image = UIImage(data: imageData) {
                    ImageCache.sharedCache.setObject(image, forKey: url.absoluteString as NSString)
                    DispatchQueue.main.async {
                        completionHandler(image)
                    }
                }
            }
        })
        
        task.resume()
    }
}


