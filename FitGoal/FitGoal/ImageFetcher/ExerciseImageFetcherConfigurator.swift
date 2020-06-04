//
//  ExerciseImageFetcherConfigurator.swift
//  FitGoal
//
//  Created by Eliany Barrera on 4/6/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class ExerciseImageFetcherConfigurator: NSObject, ImageFetcherDelegate {
    
    private let imageFetcher: ImageFetcher
    private let exerciseImageView: UIImageView
    private let imageGradient: UIView
    private let placeholder: UIActivityIndicatorView
    private var playExerciseButton: UIButton?
    
    init(imageFetcher: ImageFetcher, exerciseImageView: UIImageView, imageGradient: UIView, placeholder: UIActivityIndicatorView) {
        self.imageGradient = imageGradient
        self.placeholder = placeholder
        self.exerciseImageView = exerciseImageView
        self.imageFetcher = imageFetcher
        super.init()
        imageFetcher.delegate = self
        imageFetcher.fetchImage()
    }
    
    convenience init(imageFetcher: ImageFetcher, exerciseImageView: UIImageView, imageGradient: UIView, placeholder: UIActivityIndicatorView, playExerciseButton: UIButton) {
        self.init(imageFetcher: imageFetcher, exerciseImageView: exerciseImageView, imageGradient: imageGradient, placeholder: placeholder)
        self.playExerciseButton = playExerciseButton
    }
    
    private func configureViews(forFetchingState isImageFetched: Bool) {
        imageGradient.isHidden = isImageFetched
        playExerciseButton?.isHidden = isImageFetched
        
        if isImageFetched {
            placeholder.startAnimating()
        } else {
            placeholder.stopAnimating()
        }
    }
    
    func imageFetcherStartedFetching(_ imageFetcher: ImageFetcher) {
        configureViews(forFetchingState: false)
    }
    
    func imageFetcher(_ imageFetcher: ImageFetcher, didFinishFetchingWith image: UIImage) {
        configureViews(forFetchingState: true)
        exerciseImageView.image = image
    }
    
    func imageFetcher(_ imageFetcher: ImageFetcher, failedWith error: Error) {
        configureViews(forFetchingState: false)
        print("Couldn't fetch image with error \(error)")
    }
}
