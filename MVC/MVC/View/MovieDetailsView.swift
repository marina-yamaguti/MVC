//
//  MovieDetailsView.swift
//  MVC
//
//  Created by Waldyr Schneider on 19/03/24.
//

import UIKit

class MovieDetailsView: UIViewController, UIScrollViewDelegate {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? .black : .white
        }
        return scrollView
    }()
    
    private let cover: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "spider")
        img.contentMode = .scaleAspectFill
        img.layer.cornerRadius = 10
        return img
    }()
    
    private let titleLabel: UILabel = {
        let title = UILabel()
        title.font = UIFont.preferredFont(forTextStyle: .headline)
        title.text = "Spider-Man"
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private let tagsLabel: UILabel = {
        let tags = UILabel()
        tags.font = UIFont.preferredFont(forTextStyle: .footnote)
        tags.textColor = UIColor.gray
        tags.text = "Adventure, Animation, Family"
        tags.translatesAutoresizingMaskIntoConstraints = false
        return tags
    }()
    
    private let starImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(systemName: "star")
        img.tintColor = UIColor.gray
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    private let ratingLabel: UILabel = {
        let rating = UILabel()
        rating.font = UIFont.preferredFont(forTextStyle: .footnote)
        rating.textColor = UIColor.gray
        rating.text = "7.8"
        rating.translatesAutoresizingMaskIntoConstraints = false
        return rating
    }()
    
    private let overviewLabel: UILabel = {
        let overview = UILabel()
        overview.font = UIFont.preferredFont(forTextStyle: .headline)
        overview.text = "Overview"
        overview.translatesAutoresizingMaskIntoConstraints = false
        return overview
    }()
    
    private let descriptionLabel: UILabel = {
        let description = UILabel()
        description.font = UIFont.preferredFont(forTextStyle: .callout)
        description.textColor = UIColor.gray
        description.text = """
        A kindhearted street urchin named Aladdin embarks on a magical adventure after finding a lamp that releases a wisecra
        A kindhearted street urchin named Aladdin embarks on a magical adventure after finding a lamp that releases a wisecra
        A kindhearted street urchin named Aladdin embarks on a magical adventure after finding a lamp that releases a wisecra
        A kindhearted street urchin named Aladdin embarks on a magical adventure after finding a lamp that releases a wisecra
        A kindhearted street urchin named Aladdin embarks on a magical adventure after finding a lamp that releases a wisecra
                A kindhearted street urchin named Aladdin embarks on a magical adventure after finding a lamp that releases a wisecra
                A kindhearted street urchin named Aladdin embarks on a magical adventure after finding a lamp that releases a wisecra
                A kindhearted street urchin named Aladdin embarks on a magical adventure after finding a lamp that releases a wisecra
                A kindhearted street urchin named Aladdin embarks on a magical adventure after finding a lamp that releases a wisecra
                A kindhearted street urchin named Aladdin embarks on a magical adventure after finding a lamp that releases a wisecra
                A kindhearted street urchin named Aladdin embarks on a magical adventure after finding a lamp that releases a wisecra
                A kindhearted street urchin named Aladdin embarks on a magical adventure after finding a lamp that releases a wisecra
                A kindhearted street urchin named Aladdin embarks on a magical adventure after finding a lamp that releases a wisecra
                A kindhearted street urchin named Aladdin embarks on a magical adventure after finding a lamp that releases a wisecra
                A kindhearted street urchin named Aladdin embarks on a magical adventure after finding a lamp that releases a wisecra
        """
        description.numberOfLines = 0
        description.translatesAutoresizingMaskIntoConstraints = false
        return description
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        view.addSubview(scrollView)
        scrollView.addSubview(cover)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(tagsLabel)
        scrollView.addSubview(starImage)
        scrollView.addSubview(ratingLabel)
        scrollView.addSubview(overviewLabel)
        scrollView.addSubview(descriptionLabel)
        configScrollView()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset.x = 0
    }
    
    private func configScrollView() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            cover.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            cover.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            cover.topAnchor.constraint(equalTo: scrollView.topAnchor),
            cover.widthAnchor.constraint(equalToConstant: 128),
            cover.heightAnchor.constraint(equalToConstant: 194),
            
            titleLabel.centerYAnchor.constraint(equalTo: cover.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: cover.trailingAnchor, constant: 12),
            
            tagsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            tagsLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            starImage.bottomAnchor.constraint(equalTo: cover.bottomAnchor, constant: -8),
            starImage.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            starImage.widthAnchor.constraint(equalToConstant: 18),
            starImage.heightAnchor.constraint(equalToConstant: 18),
            
            ratingLabel.leadingAnchor.constraint(equalTo: starImage.trailingAnchor, constant: 4),
            ratingLabel.centerYAnchor.constraint(equalTo: starImage.centerYAnchor),
            
            overviewLabel.topAnchor.constraint(equalTo: cover.bottomAnchor, constant: 16),
            overviewLabel.leadingAnchor.constraint(equalTo: cover.leadingAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: cover.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//            descriptionLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
}
