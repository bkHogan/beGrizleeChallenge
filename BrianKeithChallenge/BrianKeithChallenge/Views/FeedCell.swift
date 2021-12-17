//
//  FeedCell.swift
//  BrianKeithChallenge
//
//  Created by Brian Hogan on 12/17/21.
//

import UIKit

class FeedCell: UITableViewCell {
    
    // MARK: - static properties
    static let identifier = "FeedCell"
    
    // MARK: - override
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - private properties
    lazy private var feedImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy private var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize:16)
        return label
    }()
    
    lazy private var numCommentsLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize:16)
        label.textColor = .darkGray
        return label
    }()
    
    // MARK: - internal func
    func configureCell(title: String?, numComments: String?, imageData: Data?) {
        
        setUpUI(imageData: imageData)
        
        titleLabel.text = title
        numCommentsLabel.text = "# comments: \(numComments ?? "")"
        
        feedImageView.image = nil
        if let data = imageData {
            feedImageView.image = UIImage(data: data)
        }
    }
    
    // MARK: - private func
    private func setUpUI(imageData: Data? = nil) {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        
        stackView.addArrangedSubview(titleLabel)
        // validate image constraint
        if let _ = imageData {
            stackView.addArrangedSubview(feedImageView)
        }
        stackView.addArrangedSubview(numCommentsLabel)

        stackView.setCustomSpacing(CGFloat(CustomSpaces.spacingBetweenViews), after: titleLabel)
        stackView.setCustomSpacing(CGFloat(CustomSpaces.spacingBetweenViews), after: feedImageView)
        
        contentView.addSubview(stackView)
        
        // setup constraint
        let spacingConstant = CGFloat(CustomSpaces.spacingBetweenViews)
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: spacingConstant).isActive = true
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: spacingConstant).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -spacingConstant).isActive = true
        
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -spacingConstant).isActive = true
    }
}
