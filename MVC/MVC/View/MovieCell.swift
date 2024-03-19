//
//  MovieCell.swift
//  MVC
//
//  Created by Luciana Lemos on 18/03/24.
//
import UIKit

class MovieCell: UITableViewCell {
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
    private let descriptionLabel: UILabel = {
        let description = UILabel()
        description.font = UIFont.preferredFont(forTextStyle: .caption1)
        description.textColor = UIColor.gray
        description.text = "A kindhearted street urchin named Aladdin embarks on a magical adventure after finding a lamp that releases a wisecra"
        description.numberOfLines = 3
        description.translatesAutoresizingMaskIntoConstraints = false
        return description
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configSubViews() {
        contentView.addSubview(cover)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(starImage)
        contentView.addSubview(ratingLabel)
        
        NSLayoutConstraint.activate([
            cover.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            cover.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cover.widthAnchor.constraint(equalTo: cover.heightAnchor, multiplier: 0.66),
            cover.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: -8),
            
            titleLabel.topAnchor.constraint(equalTo: cover.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: cover.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            starImage.bottomAnchor.constraint(equalTo: cover.bottomAnchor),
            starImage.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            starImage.widthAnchor.constraint(equalToConstant: 18),
            starImage.heightAnchor.constraint(equalToConstant: 18),
            
            ratingLabel.leadingAnchor.constraint(equalTo: starImage.trailingAnchor, constant: 4),
            ratingLabel.centerYAnchor.constraint(equalTo: starImage.centerYAnchor)
        ])
    }
    
}
