//
//  ViewController.swift
//  FitGoal
//
//  Created by Eliany Barrera on 18/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    private var scrollView = UIScrollView()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var startExerciseButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.56, green: 0.07, blue: 1, alpha: 1)
        let string = "Start Exercise".formattedText(
            font: "Roboto-Regular",
            size: 17,
            color: .white,
            kern: 0
        )
        
        button.setAttributedTitle(string, for: .normal)
        return button
    }()
    
    private var imageLoadingState: ImageLoadingState = .inProgress {
        didSet {
            switch imageLoadingState {
            case .inProgress:
                imageGradient.isHidden = true
                playButton.isHidden = true
                placeholder.startAnimating()
            case .finished(let image):
                imageGradient.isHidden = false
                playButton.isHidden = false
                placeholder.stopAnimating()
                exerciseImage.image = image
            case .failed(let error):
                print("Unable to load image with error: \(error)")
            }
        }
    }
    
    private var cellTitle = UILabel()
    
    private var exerciseImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 7
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var playButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(imageLiteralResourceName: "PlayButton"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 72, height: 72)
        button.contentMode = .scaleAspectFit
        return button
        
    }()
    
    private let text: UITextView = {
        let text = UITextView()
        text.isEditable = false
        text.isScrollEnabled = false
        text.isSelectable = false
        text.textContainerInset = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 0)
        return text
    }()
    
    private var placeholder: UIActivityIndicatorView = {
        let placeholder = UIActivityIndicatorView()
        placeholder.color = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        placeholder.style = .medium
        return placeholder
    }()
    
    private let descriptionTitle: UILabel = {
        let label = UILabel()
        let text = "DESCRIPTION"
        label.attributedText = text.formattedText(
            font: "Oswald-Medium",
            size: 16,
            color: #colorLiteral(red: 0.38, green: 0.39, blue: 0.38, alpha: 1),
            kern: 0.17
        )
        return label
    }()
    
    private let descriptionView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = false
        view.layer.shadowOffset = CGSize(width: 0, height: 6)
        view.layer.shadowColor = UIColor(r: 131, g: 164, b: 133, a: 12).cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 10
        view.layer.cornerRadius = 7
        return view
    }()
    
    private lazy var gradientBackgroundView: UIView = {
        let gradientView = GradientView(frame: CGRect(x: 0, y: 0, width: 800, height: 812))
        gradientView.layer.cornerRadius = 150
        gradientView.layer.maskedCorners = [.layerMinXMaxYCorner]
        gradientView.colors = [#colorLiteral(red: 0.2816967666, green: 0.8183022738, blue: 0.9222241044, alpha: 1), #colorLiteral(red: 0.5647058824, green: 0.07450980392, blue: 0.9568627451, alpha: 1)]
        let rotation = CGAffineTransform(rotationAngle: -26 / 180 * CGFloat.pi)
        gradientView.transform = rotation.translatedBy(x: 15, y: -650)
        return gradientView
    }()

    private var imageGradient: UIView = {
        let gradientView = GradientView(frame: .zero)
        gradientView.layer.cornerRadius = 7
        gradientView.colors = [#colorLiteral(red: 0.9411764706, green: 0.7137254902, blue: 0.7137254902, alpha: 0), #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.06), #colorLiteral(red: 0.6980392157, green: 0.7294117647, blue: 0.9490196078, alpha: 0.55)]
        return gradientView
    }()

    private var grayShadow: UIView = {
        var shadow = UIView()
        shadow.clipsToBounds = false
        shadow.layer.shadowOffset = CGSize(width: 0, height: 6)
        shadow.layer.shadowColor = UIColor(r: 131, g: 164, b: 133, a: 12).cgColor
        shadow.layer.shadowOpacity = 1
        shadow.layer.shadowRadius = 10
        return shadow
    }()
    
    private var shadowWithGradient: UIView = {
        let gradientView = GradientView(frame: .zero)
        gradientView.layer.cornerRadius = 9
        gradientView.colors = [#colorLiteral(red: 0.18, green: 0.74, blue: 0.89, alpha: 1), #colorLiteral(red: 0.51, green: 0.09, blue: 0.86, alpha: 1)]
        gradientView.startPoint = CGPoint(x: 0, y: 0.70)
        gradientView.endPoint = CGPoint(x: 1, y: 0.74)
        gradientView.alpha = 0.15
        return gradientView
    }()
    
    //MARK: -VC life cycle
    
    init(exercise: Exercise) {
        let imageURL = exercise.url
        self.cellTitle.attributedText = exercise.name.uppercased().formattedText(
            font: "Oswald-Medium",
            size: 34,
            color: .white,
            kern: -0.14
        )
        self.text.attributedText = exercise.description.formattedText(
            font: "Roboto-Light",
            size: 15,
            color: #colorLiteral(red: 0.52, green: 0.53, blue: 0.57, alpha: 1),
            kern: 0.3,
            lineSpacing: 6
        )
        super.init(nibName: nil, bundle: nil)
        fetchImage(with: imageURL)
        startExerciseButton.addTarget(self, action: #selector(handlePlayButton), for: .touchUpInside)
        playButton.addTarget(self, action: #selector(handlePlayButton), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
        view.addSubview(scrollView)
        view.addSubview(startExerciseButton)
        grayShadow.addSubview(exerciseImage)
        
        let views = [gradientBackgroundView,
                     cellTitle,
                     shadowWithGradient,
                     grayShadow,
                     imageGradient,
                     playButton,
                     descriptionView,
                     descriptionTitle,
                     text
        ]
        add(subviews: views, to: scrollView)
        setConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height - 100)
        scrollView.layoutIfNeeded()
        
        exerciseImage.frame = grayShadow.bounds
        imageGradient.frame = grayShadow.frame
        playButton.center = grayShadow.center
        
        startExerciseButton.frame = CGRect (x: 16, y: view.bounds.maxY - 100, width: view.bounds.width - 32, height: 54)
        startExerciseButton.layer.cornerRadius = startExerciseButton.bounds.height/2
    }
    
    @objc func handlePlayButton() {
        self.present(ExercisePlayerViewController(exercise: Exercise(id: 1, name: "Ex", url: URL(string: "https://www.youtube.com")!, description: ""), routine: []), animated: true, completion: nil)
    }
    
    private func setConstraints(){
        setTitleLabelConstraints()
        setGrayShadowConstraints()
        setShadowWithGradientConstraints()
        setDescriptionViewConstraints()
        setTextConstraints()
        setLabelConstraints()
    }
    
    private func add(subviews: [UIView],  to parentView: UIView) {
        subviews.forEach { view in
            parentView.addSubview(view)
        }
    }
    
    private func fetchImage(with imageURL: URL) {
        imageURL.fetchImage { result in
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
    
    //MARK: -Constraints

    private func setTitleLabelConstraints() {
        cellTitle.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            cellTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 32),
            cellTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
    }
    
    private func setGrayShadowConstraints() {
        grayShadow.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            grayShadow.topAnchor.constraint(equalTo: cellTitle.bottomAnchor, constant: 32),
            grayShadow.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            grayShadow.heightAnchor.constraint(equalToConstant: 228),
            grayShadow.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    private func setShadowWithGradientConstraints() {
           shadowWithGradient.translatesAutoresizingMaskIntoConstraints = false
           
           NSLayoutConstraint.activate([
               shadowWithGradient.bottomAnchor.constraint(equalTo: grayShadow.bottomAnchor, constant: 16),
               shadowWithGradient.leadingAnchor.constraint(equalTo: grayShadow.leadingAnchor, constant: 16),
               shadowWithGradient.trailingAnchor.constraint(equalTo: grayShadow.trailingAnchor, constant: -16),
               shadowWithGradient.heightAnchor.constraint(equalToConstant: 30)
           ])
    }
    
    private func setDescriptionViewConstraints() {
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionView.widthAnchor.constraint(equalTo: grayShadow.widthAnchor),
            descriptionView.leadingAnchor.constraint(equalTo: grayShadow.leadingAnchor),
            descriptionView.topAnchor.constraint(equalTo: shadowWithGradient.bottomAnchor, constant: 16)
        ])
    }
    
    private func setLabelConstraints() {
        descriptionTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionTitle.leadingAnchor.constraint(equalTo: descriptionView.leadingAnchor, constant: 16),
            descriptionTitle.topAnchor.constraint(equalTo: descriptionView.topAnchor, constant: 16)
        ])
    }
    
    private func setTextConstraints() {
        text.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            text.leadingAnchor.constraint(equalTo: descriptionTitle.leadingAnchor),
            text.topAnchor.constraint(equalTo: descriptionTitle.bottomAnchor, constant: 8),
            text.trailingAnchor.constraint(equalTo: descriptionView.trailingAnchor, constant: -16),
            text.bottomAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: -16)
        ])
    }
}
