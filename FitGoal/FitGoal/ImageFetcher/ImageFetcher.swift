//
//  ImageFetcher.swift
//  FitGoal
//
//  Created by Eliany Barrera on 4/6/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

protocol ImageFetcherDelegate: AnyObject {
    
    func imageFetcherStartedFetching(_ imageFetcher: ImageFetcher)
    
    func imageFetcher(_ imageFetcher: ImageFetcher, didFinishFetchingWith image: UIImage)
    
    func imageFetcher(_ imageFetcher: ImageFetcher, failedWith error: Error)
}

class ImageFetcher {
    
    weak var delegate: ImageFetcherDelegate?
    private var currentImageDownloadTask: URLSessionTask?
    private var imageURL: URL?
    
    private var imageLoadingState: ImageLoadingState = .inProgress {
        didSet {
            switch imageLoadingState {
            case .inProgress:
                delegate?.imageFetcherStartedFetching(self)
            case .finished(let image):
                delegate?.imageFetcher(self, didFinishFetchingWith: image)
            case .failed(let error):
                delegate?.imageFetcher(self, failedWith: error)
            }
        }
    }
    
    init(url: URL?) {
        self.imageURL = url
    }
    
    func startFetching() {
        guard let currentImageURL = self.imageURL else {
            return
        }
        imageLoadingState = .inProgress
        
        if let cachedImage = ImageCache.read(url: currentImageURL) {
            self.imageLoadingState = .finished(cachedImage)
        }
        else {
            currentImageDownloadTask = currentImageURL.downloadImage(completion: { (result) in
                DispatchQueue.main.async {
                    guard self.imageURL == currentImageURL else { return }
                    switch result {
                    case .failure(let error):
                        self.imageLoadingState = .failed(error)
                    case .success(let image):
                        ImageCache.write(url: currentImageURL, image: image)
                        self.imageLoadingState = .finished(image)
                    }
                }
            })
            resumeFetchingTask()
        }
    }
    
    private func resumeFetchingTask() {
        currentImageDownloadTask?.resume()
    }
    
    func cancelFetching() {
        self.currentImageDownloadTask?.cancel()
    }
}

private enum ImageLoadingState {
    case inProgress
    case finished(UIImage)
    case failed(Error)
}
