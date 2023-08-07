//
//  PostDetailViewController.swift
//  Connect
//
//  Created by Andrew Koo on 8/7/23.
//

import UIKit

class PostDetailViewController: UIViewController {
    
    private let viewModel: PostDetailViewModel
    
    private let creatorNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let creatorLocationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        return label
    }()
    
    private let postDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Initialization
    
    init(post: Post) {
        self.viewModel = PostDetailViewModel(post: post)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        displayPostDetails()
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = viewModel.postChannel
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        scrollView.addSubview(creatorNameLabel)
        scrollView.addSubview(creatorLocationLabel)
        scrollView.addSubview(postDateLabel)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(contentLabel)
        
        let padding: CGFloat = 16
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            creatorNameLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: padding),
            creatorNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            creatorNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            creatorLocationLabel.topAnchor.constraint(equalTo: creatorNameLabel.bottomAnchor, constant: 4),
            creatorLocationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            creatorLocationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            postDateLabel.topAnchor.constraint(equalTo: creatorLocationLabel.bottomAnchor, constant: 4),
            postDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            postDateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            titleLabel.topAnchor.constraint(equalTo: postDateLabel.bottomAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            contentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            contentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            contentLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            contentLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -padding),
        ])
    }
    
    // MARK: - Display Post Details
    
    private func displayPostDetails() {
        creatorNameLabel.text = viewModel.creatorName
        creatorLocationLabel.text = viewModel.creatorLocation
        postDateLabel.text = viewModel.postDate
        titleLabel.text = viewModel.postTitle
        contentLabel.text = viewModel.postContent
    }
}

