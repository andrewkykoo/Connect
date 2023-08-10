//
//  PostTableViewCell.swift
//  Connect
//
//  Created by Andrew Koo on 8/7/23.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    private let postDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupSelectedBackgroundView()
        
        contentView.addSubview(containerView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(locationLabel)
        containerView.addSubview(titleLabel)
        contentView.addSubview(postDateLabel)
        
        let padding: CGFloat = 5
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            
            locationLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
            locationLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            locationLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            
            postDateLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 5),
            postDateLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            postDateLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            
            titleLabel.topAnchor.constraint(equalTo: postDateLabel.bottomAnchor, constant: 2),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        setupSelectedBackgroundView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
//    private func setupSelectedBackgroundView() {
//        let selectedBackgroundView = UIView()
//        selectedBackgroundView.backgroundColor = UIColor.systemMint
//        self.selectedBackgroundView = selectedBackgroundView
//    }
    
    func configure(with post: Post) {
        nameLabel.text = "\(post.creator.firstName) \(post.creator.lastName)"
        locationLabel.text = post.creator.location
        titleLabel.text = post.title
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        let dateString = dateFormatter.string(from: post.createdDate)
        postDateLabel.text = dateString
    }
}

