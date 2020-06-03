//
//  ExerciseImageFetcherDelegate.swift
//  FitGoal
//
//  Created by Eliany Barrera on 4/6/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class ExerciseImageFetcherDelegate: NSObject, ImageFetcherDelegate {
    
    private let exerciseImageView: UIImageView
    private let imageGradient: UIView
    private let placeholder: UIActivityIndicatorView
    private var playExerciseButton: UIButton?
    
    init(exerciseImageView: UIImageView, imageGradient: UIView, placeholder: UIActivityIndicatorView) {
        self.imageGradient = imageGradient
        self.placeholder = placeholder
        self.exerciseImageView = exerciseImageView
        super.init()
    }
    
    convenience init(exerciseImageView: UIImageView, imageGradient: UIView, placeholder: UIActivityIndicatorView, playExerciseButton: UIButton) {
        self.init(exerciseImageView: exerciseImageView, imageGradient: imageGradient, placeholder: placeholder)
        self.playExerciseButton = playExerciseButton
    }
    
    func imageFetcherIsInProgress() {
        imageGradient.isHidden = true
        playExerciseButton?.isHidden = true
        placeholder.startAnimating()
    }
    
    func imageFetcher(_ imageFetcher: ImageFetcher, didFinishFetchingWith image: UIImage) {
        imageGradient.isHidden = false
        playExerciseButton?.isHidden = false
        placeholder.stopAnimating()
        exerciseImageView.image = image
    }
    
    func imageFetcher(_ imageFetcher: ImageFetcher, failedWith error: Error) {
        assertionFailure("Couldn't fetch image with error \(error)")
    }
}
