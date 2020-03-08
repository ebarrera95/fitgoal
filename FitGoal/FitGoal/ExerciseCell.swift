//
//  ExerciseCell.swift
//  FitGoal
//
//  Created by Eliany Barrera on 8/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class ExerciseCell: UICollectionViewCell {
    
    var exersice: Exercise? {
        didSet {
             imageURL = exersice?.url
            //Title
            guard let title = exersice?.name else { return }
            let cellTitle = title.uppercased().formattedText(
                font: "Roboto-Bold",
                size: 12,
                color: .white,
                kern: 0.14
            )
            self.title.attributedText = cellTitle
        }
    }
    
    
    static var identifier = "Cell Exercise"
    
    var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    var imageURL: URL? {
        didSet {
            guard let imageURL = imageURL else { return }
            
            
        }
    }
    /*
     didSet {
        guard let imageURL = imageURL else {
            return
        }
        
        imageLoadingState = .inProgress
        
        currentImageDownloadTask = fetchImage(from: imageURL) { result in
            DispatchQueue.main.async {
                guard self.imageURL == imageURL else { return }
                
                switch result {
                case .failure(let error):
                    self.imageLoadingState = .failed(error)
                case .success(let image):
                    self.imageLoadingState = .finished(image)
                }
            }
        }
    }
     */
    var placeHolder = UIActivityIndicatorView()
    var title = UILabel()
    var gradient = UIView()
    var dayIndicatorLabel = UILabel()
    var exersiceStatus = UIImageView()
    
    
    var view = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .red
        contentView.addSubview(view)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        view.frame = contentView.bounds
        view.backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
