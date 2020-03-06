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
            guard let numberOfexercises = routine?.exercices.count else { return }
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
                        task = getDataTask(with: imageURL)
                        task?.resume()
                    }
                }
            }
        }
    }
    var task: URLSessionDataTask?

    var gradientView: UIView = {
        let gradientView = GradientView(frame: .zero)
        gradientView.layer.cornerRadius = 7
        gradientView.colors = [#colorLiteral(red: 0.9411764706, green: 0.7137254902, blue: 0.7137254902, alpha: 0), #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.06), #colorLiteral(red: 0.6980392157, green: 0.7294117647, blue: 0.9490196078, alpha: 0.55)]
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        gradientView.isHidden = true
        return gradientView
    }()
    
    var placeholder: UIActivityIndicatorView = {
        let placeholder = UIActivityIndicatorView()
        placeholder.color = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        placeholder.style = .medium
        placeholder.translatesAutoresizingMaskIntoConstraints = false
        placeholder.isHidden = true
        return placeholder
    }()
    
    var title: UILabel = {
        let title = UILabel(frame: .zero)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    var subtitle: UILabel = {
        let title = UILabel(frame: .zero)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 7
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var roundedButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(UIImage(imageLiteralResourceName: "icons - System - Add"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(backgroundImage)
        addBackgroundImageSubview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        backgroundImage.image = nil
        stringURL = nil
        gradientView.isHidden = true
        task?.cancel()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutBackgroundImageView()
        layoutBackgroundImageSubviews()
    }
    
    //MARK: - View Layouts
    private func layoutTitelLabel() {
        contentView.addSubview(title)
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: backgroundImage.topAnchor, constant: 2/3 * backgroundImage.bounds.height),
            title.leadingAnchor.constraint(equalTo: backgroundImage.leadingAnchor, constant: 16)
        ])
    }
    
    private func layoutSubtitleLabel() {
        NSLayoutConstraint.activate([
            subtitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 4),
            subtitle.leadingAnchor.constraint(equalTo: title.leadingAnchor)
        ])
    }
    
    private func layoutBackgroundImageView() {
        backgroundImage.bounds.size = CGSize(width: contentView.bounds.size.width - 32, height: contentView.bounds.height)
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundImage.heightAnchor.constraint(equalToConstant: backgroundImage.bounds.height),
            backgroundImage.widthAnchor.constraint(equalToConstant: backgroundImage.bounds.size.width),
            backgroundImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        ])
    }
    
    private func layoutButton() {
        NSLayoutConstraint.activate([
            roundedButton.topAnchor.constraint(equalTo: title.topAnchor),
            roundedButton.trailingAnchor.constraint(equalTo: backgroundImage.trailingAnchor, constant: -16),
            roundedButton.widthAnchor.constraint(equalToConstant: 25),
            roundedButton.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    private func layoutPlaceHolder() {
        NSLayoutConstraint.activate([
            placeholder.centerXAnchor.constraint(equalTo: backgroundImage.centerXAnchor),
            placeholder.centerYAnchor.constraint(equalTo: backgroundImage.centerYAnchor)
        ])
    }
    private func layoutOverlay() {
        NSLayoutConstraint.activate([
            gradientView.topAnchor.constraint(equalTo: backgroundImage.topAnchor),
            gradientView.leadingAnchor.constraint(equalTo: backgroundImage.leadingAnchor),
            gradientView.widthAnchor.constraint(equalTo: backgroundImage.widthAnchor),
            gradientView.heightAnchor.constraint(equalTo: backgroundImage.heightAnchor)
        ])
    }
    private func layoutBackgroundImageSubviews() {
        layoutOverlay()
        layoutPlaceHolder()
        layoutTitelLabel()
        layoutSubtitleLabel()
        layoutButton()
    }
    
    private func addBackgroundImageSubview() {
        backgroundImage.addSubview(gradientView)
        backgroundImage.addSubview(placeholder)
        backgroundImage.addSubview(title)
        backgroundImage.addSubview(subtitle)
        backgroundImage.addSubview(roundedButton)
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
