//
//  ExerciseCell.swift
//  FitGoal
//
//  Created by Eliany Barrera on 8/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class ExerciseCell: UICollectionViewCell {
    
    private var imageLoadingState: ImageLoadingState = .inProgress {
        didSet {
            switch imageLoadingState {
            case .inProgress:
                gradientView.isHidden = true
                placeholder.startAnimating()
            case .finished(let image):
                gradientView.isHidden = false
                placeholder.stopAnimating()
                backgroundImage.image = image
            case .failed(let error):
                print("Unable to load image with error: \(error)")
            }
        }
    }
    
    var exercise: Exercise? {//TODO: Custom the title for this cell
        didSet {
             imageURL = exercise?.url
            //Title
            guard let title = exercise?.name else { return }
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
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 7
        return imageView
    }()
    
    var currentImageDownloadTask: URLSessionTask?

    var imageURL: URL? {
        didSet {
            guard let imageURL = imageURL else { return }
            
            imageLoadingState = .inProgress
            
            currentImageDownloadTask = imageURL.fetchImage { result in
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
    }

    private var placeholder: UIActivityIndicatorView = {
        let placeholder = UIActivityIndicatorView()
        placeholder.color = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        placeholder.style = .medium
        return placeholder
    }()
    
    var title = UILabel()
    private var gradientView: UIView = {
        let gradientView = GradientView(frame: .zero)
        gradientView.layer.cornerRadius = 7
        gradientView.colors = [#colorLiteral(red: 0.9411764706, green: 0.7137254902, blue: 0.7137254902, alpha: 0), #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.06), #colorLiteral(red: 0.6980392157, green: 0.7294117647, blue: 0.9490196078, alpha: 0.55)]
        return gradientView
    }()
    
    var dayIndicatorLabel = UILabel()
    var exersiceStatus = UIImageView()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.layer.cornerRadius = 7
        self.clipsToBounds = true
        contentView.addSubview(backgroundImage)
        contentView.addSubview(placeholder)
        contentView.addSubview(gradientView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundImage.frame = contentView.bounds
        gradientView.frame = contentView.bounds
        placeholder.center = CGPoint(x: contentView.bounds.midX, y: contentView.bounds.midY)

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        backgroundImage.image = nil
        imageURL = nil
        gradientView.isHidden = true
        currentImageDownloadTask?.cancel()
    }
}
