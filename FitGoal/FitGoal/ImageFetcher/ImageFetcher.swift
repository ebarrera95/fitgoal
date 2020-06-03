//
//  ImageFetcher.swift
//  FitGoal
//
//  Created by Eliany Barrera on 4/6/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

var imageCache: [URL: UIImage] = [:]

protocol ImageFetcherDelegate: AnyObject {
    
    func imageFetcherIsInProgress()
    
    func imageFetcher(_ imageFetcher: ImageFetcher, didFinishFetchingWith image: UIImage)
    
    func imageFetcher(_ imageFetcher: ImageFetcher, failedWith error: Error)
}

class ImageFetcher {
    
    weak var delegate: ImageFetcherDelegate?
    private var currentImageDownloadTask: URLSessionTask?
    
    init(url: URL) {
        self.currentImageDownloadTask = fetchImage(with: url)
    }
    private var imageLoadingState: ImageLoadingState = .inProgress {
        didSet {
            switch imageLoadingState {
            case .inProgress:
                delegate?.imageFetcherIsInProgress()
            case .finished(let image):
                delegate?.imageFetcher(self, didFinishFetchingWith: image)
            case .failed(let error):
                delegate?.imageFetcher(self, failedWith: error)
            }
        }
    }
    
    private func fetchImage(with imageURL: URL) -> URLSessionTask? {
        return imageURL.fetchImage { result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    self.imageLoadingState = .failed(error)
                case .success(let image):
                    imageCache[imageURL] = image
                    self.imageLoadingState = .finished(image)
                }
            }
        }
    }
    
    func cancelFetching() {
        self.currentImageDownloadTask?.cancel()
    }
}

enum ImageLoadingState {
    case inProgress
    case finished(UIImage)
    case failed(Error)
}

enum NetworkError: Error {
    case invalidImage
}
