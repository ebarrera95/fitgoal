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
    private var imageURL: URL
    private var fetchingWasCancelled = false
    
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
    
    init(url: URL) {
        self.imageURL = url
    }
    
    func startFetching() {
        imageLoadingState = .inProgress
        
        if let cachedImage = ImageCache.read(url: imageURL) {
            self.imageLoadingState = .finished(cachedImage)
        }
        else {
            currentImageDownloadTask = imageURL.downloadImage(completion: { (result) in
                DispatchQueue.main.async {
                    guard !self.fetchingWasCancelled else { return }
                    switch result {
                    case .failure(let error):
                        self.imageLoadingState = .failed(error)
                    case .success(let image):
                        ImageCache.write(url: self.imageURL, image: image)
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
        currentImageDownloadTask?.cancel()
        fetchingWasCancelled = true
    }
}

private enum ImageLoadingState {
    case inProgress
    case finished(UIImage)
    case failed(Error)
}
