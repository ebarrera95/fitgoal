//
//  ImageCache.swift
//  FitGoal
//
//  Created by Eliany Barrera on 4/6/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class ImageCache {
    static private var imageCache: [URL: UIImage] = [:]
    
    static func write(url: URL, image: UIImage) {
        imageCache[url] = image
    }
    
    static func read(url: URL) -> UIImage? {
        return imageCache[url]
    }
}
