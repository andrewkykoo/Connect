//
//  ChannelViewController.swift
//  Connect
//
//  Created by Andrew Koo on 8/7/23.
//

import UIKit

class ChannelViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var postsViewModel: ChannelPostsViewModel
    private let channel: Channel
    var channelSelectionHandler: ((Channel) -> Void)?

    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    init(channel: Channel) {
        self.channel = channel
        self.postsViewModel = ChannelPostsViewModel(channel: channel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostCell")
        navigationItem.title = postsViewModel.channelName
    }
    
    func didSelectChannel(_ channel: Channel) {
        channelSelectionHandler?(channel)
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsViewModel.filteredPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostTableViewCell
        let post = postsViewModel.filteredPosts[indexPath.row]
        cell.configure(with: post)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPost = postsViewModel.filteredPosts[indexPath.row]
        let postDetailViewController = PostDetailViewController(post: selectedPost)
        navigationController?.pushViewController(postDetailViewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

