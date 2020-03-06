//
//  RoutineCell.swift
//  FitGoal
//
//  Created by Eliany Barrera on 4/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class SuggestedRoutineCell: UICollectionViewCell {
    
    static var indentifier: String = "Suggestions"
    
    var cellState: CellState? {
        didSet {
            switch cellState {
            case .loading:
                placeholder.isHidden = true
                gradientView.isHidden = true
                placeholder.startAnimating()
            case .displayed:
                placeholder.isHidden = false
                gradientView.isHidden = false
                placeholder.stopAnimating()
            default:
                return
            }
        }
    }
    
    var routine: Routine? {
        didSet {
            stringURL = routine?.url
            
            //configure title
            guard let title = routine?.name else { return }
            let cellTitle = configureCellTitle(with: title)
            self.title.attributedText = cellTitle
            
            //configure subtitle
            guard let numberOfexercises = routine?.exercises.count else { return }
            let subtitle = "\(numberOfexercises) new"
            let cellSubtitle = configureCellSubtitle(with: subtitle)
            self.subtitle.attributedText = cellSubtitle
        }
    }

    var stringURL: String? {
        didSet {
            if let string = stringURL {
                cellState = .loading
                if let imageURL = URL(string: string) {
                    if let image = imageCache[imageURL] {
                        cellState = .displayed
                        backgroundImage.image = image
                    } else {
                        currentImageDownloadTask = getDataTask(with: imageURL)
                        currentImageDownloadTask?.resume()
                    }
                }
            }
        }
    }
    
    private var currentImageDownloadTask: URLSessionDataTask?

    private var gradientView: UIView = {
        let gradientView = GradientView(frame: .zero)
        gradientView.layer.cornerRadius = 7
        gradientView.colors = [#colorLiteral(red: 0.9411764706, green: 0.7137254902, blue: 0.7137254902, alpha: 0), #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.06), #colorLiteral(red: 0.6980392157, green: 0.7294117647, blue: 0.9490196078, alpha: 0.55)]
        return gradientView
    }()
    
    private var placeholder: UIActivityIndicatorView = {
        let placeholder = UIActivityIndicatorView()
        placeholder.color = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        placeholder.style = .medium
        return placeholder
    }()
    
    private var title = UILabel()
    private var subtitle = UILabel()
    
    private var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 7
        return imageView
    }()
    
    private var roundedButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(imageLiteralResourceName: "icons - System - Add"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(backgroundImage)
        addBackgroundImageSubview()
        
        roundedButton.addTarget(self, action: #selector(handleTouch), for: .touchUpInside)
        
        layoutBackgroundImageSubviews()
    }
    
    @objc private func handleTouch() {
        print("Button clicked!")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        backgroundImage.image = nil
        stringURL = nil
        gradientView.isHidden = true
        currentImageDownloadTask?.cancel()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundImage.frame = contentView.bounds
        gradientView.frame = contentView.bounds
        placeholder.center = CGPoint(x: contentView.bounds.midX, y: contentView.bounds.midY)
    }
    
    //MARK: - View Layouts
    private func layoutTitleLabel() {
        title.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            title.bottomAnchor.constraint(equalTo: subtitle.topAnchor, constant: -4),
            title.leadingAnchor.constraint(equalTo: backgroundImage.leadingAnchor, constant: 16)
        ])
    }
    
    private func layoutSubtitleLabel() {
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            subtitle.bottomAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: -12),
            subtitle.leadingAnchor.constraint(equalTo: backgroundImage.leadingAnchor, constant: 16)
        ])
    }
    
    private func layoutButton() {
        roundedButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            roundedButton.bottomAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: -8),
            roundedButton.trailingAnchor.constraint(equalTo: backgroundImage.trailingAnchor, constant: -16),
            roundedButton.widthAnchor.constraint(equalToConstant: 25),
            roundedButton.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    private func layoutBackgroundImageSubviews() {
        layoutSubtitleLabel()
        layoutTitleLabel()
        layoutButton()
    }
    
    private func addBackgroundImageSubview() {
        contentView.addSubview(gradientView)
        contentView.addSubview(placeholder)
        contentView.addSubview(title)
        contentView.addSubview(subtitle)
        contentView.addSubview(roundedButton)
    }

    // MARK: - text configuration
    
    func configureCellTitle(with string: String) -> NSAttributedString {
        let capString = string.localizedUppercase
        let atributes: [NSAttributedString.Key : Any] = [
            .font: UIFont(name: "Roboto-Bold", size: 12)!,
            .foregroundColor: UIColor.white,
            .kern: 0.14
        ]
        let cellTitle = NSAttributedString(string: capString, attributes: atributes)
        return cellTitle
    }
    
    func configureCellSubtitle(with string: String) -> NSAttributedString {
        let capString = string.localizedLowercase
        let atributes: [NSAttributedString.Key : Any] = [
            .font: UIFont(name: "Roboto-Regular", size: 9)!,
            .foregroundColor: UIColor.white,
            .kern: 0.11
        ]
        let cellSubtitle = NSAttributedString(string: capString, attributes: atributes)
        return cellSubtitle
    }
    
    //MARK: - Others
    
    private func getDataTask(with url: URL) -> URLSessionDataTask? {
        return URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            
            DispatchQueue.global().async {
                if let  data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        imageCache[url] = image
                        if url.absoluteString == self.stringURL {
                            self.backgroundImage.image = image
                            self.cellState = .displayed
                        }
                    }
                }
            }
        }
    }
}

enum CellState {
    case loading
    case displayed
}
